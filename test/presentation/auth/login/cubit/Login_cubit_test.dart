import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flora_mart/core/api/api_result.dart';
import 'package:flora_mart/data/model/UserModel.dart';
import 'package:flora_mart/domain/usecase/login_Usecase.dart';
import 'package:flora_mart/presentation/auth/login/cubit/Login_cubit.dart';
import 'package:flora_mart/presentation/auth/login/cubit/Login_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginUsecase])
void main() {
  final testUserModel = UserModel(token: 'test_token');

  ApiResult<UserModel> userModelApiResult =SuccessApiResult(testUserModel);
  provideDummy<ApiResult<UserModel>>(SuccessApiResult<UserModel>(null));

  late LoginCubit loginCubit;
  late MockLoginUsecase mockLoginUsecase;

  setUp(() {
    mockLoginUsecase = MockLoginUsecase();
    loginCubit = LoginCubit(signinUsecase: mockLoginUsecase);

    // Stub the invoke method to return a successful login result
    when(mockLoginUsecase.invoke(
      email: anyNamed('email'),
      password: anyNamed('password'),
      rememberMe: anyNamed('rememberMe'),
    )).thenAnswer((_) async => userModelApiResult);
  });


  tearDown(() {
    loginCubit.close();
  });

  group('LoginCubit', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testRememberMe = true;

    blocTest<LoginCubit, LoginStates>(
      'emits [LoginLoading, LoginSuccess] when sign in succeeds',
      build: () => loginCubit,
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
