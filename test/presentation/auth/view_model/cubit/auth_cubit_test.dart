import 'package:bloc_test/bloc_test.dart';
import 'package:flora_mart/core/api/api_result.dart';
import 'package:flora_mart/data/model/UserModel.dart';
import 'package:flora_mart/domain/common/result.dart';
import 'package:flora_mart/domain/usecase/changeGuest_usecase.dart';
import 'package:flora_mart/domain/usecase/check_guest_usecase.dart';
import 'package:flora_mart/domain/usecase/login_Usecase.dart';
import 'package:flora_mart/presentation/auth/view_model/cubit/auth_cubit.dart';
import 'package:flora_mart/presentation/auth/view_model/cubit/auth_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_cubit_test.mocks.dart';

@GenerateMocks([CheckGuestUseCase, ChangeguestUsecase, LoginUsecase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group(
    'AuthCubit',
        () {
      late CheckGuestUseCase checkGuestUseCase;
      late LoginUsecase loginUsecase;
      late ChangeguestUsecase changeGuestUsecase;
      late AuthCubit authCubit;
      setUp(() {
        SharedPreferences.setMockInitialValues({});
        loginUsecase = MockLoginUsecase();
        checkGuestUseCase = MockCheckGuestUseCase();
        changeGuestUsecase = MockChangeguestUsecase();
        authCubit = AuthCubit(
          loginUsecase,
          checkGuestUseCase,
          changeGuestUsecase,
        );
      });
      blocTest<AuthCubit, AuthState>(
        'when call do intent with CheckGuestIntent it '
            ' should check guest and return correct state',
        build: () {
          var result = Success<bool>(true);
          provideDummy<Result<bool>>(result);
          when(checkGuestUseCase.call()).thenAnswer((_) async => result);
          return authCubit;
        },
        act: (cubit) {
          cubit.doIntent(CheckGuestIntent());
        },
        expect: () {
          return [
            isA<CeckGuestState>(),
          ];
        },
      );

      blocTest<AuthCubit, AuthState>(
        'when call do intent with ChangeGuestIntent it '
            ' should change guest and return correct state',
        build: () {
          var result = Success<bool>(true);
          var value = true;
          provideDummy<Result<bool>>(result);
          when(changeGuestUsecase.call(isGuest: true))
              .thenAnswer((_) async => value);
          when(checkGuestUseCase.call()).thenAnswer((_) async => result);
          return authCubit;
        },
        act: (cubit) {
          cubit.doIntent(ChangeGuestIntent(isGuest: true));
        },
        expect: () {
          return [
            isA<CeckGuestState>(),
          ];
        },
      );
    },
  );
  group('LoginCubit', () {
    late LoginUsecase signInUsecase;
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testRememberMe = true;
    final testUserModel = UserModel(token: 'test_token');

    setUp(() {
      signInUsecase = MockLoginUsecase();
    });

    provideDummy<ApiResult<UserModel>>(
        SuccessApiResult<UserModel>(UserModel(token: 'dummy_token')));

    blocTest<AuthCubit, AuthState>(
      'emits [LoginLoading, LoginSuccess] when sign in succeeds',
      build: () {
        ApiResult<UserModel> userModelApiResult =
            SuccessApiResult(testUserModel);
        provideDummy<ApiResult<UserModel>>(
            SuccessApiResult<UserModel>(UserModel(token: 'dummy_token')));

        when(signInUsecase.invoke(
          email: testEmail,
          password:testPassword,
          rememberMe: testRememberMe,
        )).thenAnswer((_) async => Future.value(
            SuccessApiResult<UserModel>(UserModel(token: 'valid_token'))));

        return AuthCubit(
            signInUsecase, MockCheckGuestUseCase(), MockChangeguestUsecase());
      },
      act: (cubit) => cubit.doIntent(
        SignInIntent(
          email: testEmail,
          password: testPassword,
          rememberMe: testRememberMe,
        ),
      ),
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginSuccessState>(),
      ],
    );
  });
}
