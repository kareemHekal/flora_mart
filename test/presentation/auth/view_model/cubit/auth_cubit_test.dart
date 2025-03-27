// import 'package:bloc_test/bloc_test.dart';
// import 'package:flora_mart/core/api/api_result.dart';
// import 'package:flora_mart/domain/common/result.dart';
// import 'package:flora_mart/domain/usecase/changeGuest_usecase.dart';
// import 'package:flora_mart/domain/usecase/check_guest_usecase.dart';
// import 'package:flora_mart/domain/usecase/forget_password_usecases/forget_password_usecase.dart';
// import 'package:flora_mart/domain/usecase/forget_password_usecases/reset_password_usecase.dart';
// import 'package:flora_mart/domain/usecase/forget_password_usecases/verify_reset_code_usecase.dart';
// import 'package:flora_mart/presentation/auth/view_model/cubit/auth_cubit.dart';
// import 'package:flora_mart/presentation/auth/view_model/cubit/auth_intent.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'auth_cubit_test.mocks.dart';
//
//
// @GenerateMocks([CheckGuestUseCase, ChangeguestUsecase,ForgetPasswordUseCase, VerifyresetcodeUseCase, ResetpasswordUsecase])
// void main() {
//   group(
//     'AuthCubit',
//     () {
//       late CheckGuestUseCase checkGuestUseCase;
//       late ChangeguestUsecase changeGuestUsecase;
//       late AuthCubit authCubit;
//       late MockForgetPasswordUseCase mockForgetPasswordUseCase;
//       late MockVerifyresetcodeUseCase mockVerifyresetcodeUseCase;
//       late MockResetpasswordUsecase mockResetpasswordUsecase;
//
//       setUp(() {
//         checkGuestUseCase = MockCheckGuestUseCase();
//         changeGuestUsecase = MockChangeguestUsecase();
//         mockForgetPasswordUseCase = MockForgetPasswordUseCase();
//         mockVerifyresetcodeUseCase = MockVerifyresetcodeUseCase();
//         mockResetpasswordUsecase = MockResetpasswordUsecase();
//
//         authCubit = AuthCubit(
//           mockVerifyresetcodeUseCase,
//           mockResetpasswordUsecase,
//           mockForgetPasswordUseCase,
//           checkGuestUseCase,
//           changeGuestUsecase
//         );
//       });
//       blocTest<AuthCubit, AuthState>(
//         'when call do intent with CheckGuestIntent it '
//         ' should check guest and return correct state',
//         build: () {
//           var result = Success<bool>(true);
//           provideDummy<Result<bool>>(result);
//           when(checkGuestUseCase.call()).thenAnswer((_) async => result);
//           return authCubit;
//         },
//         act: (cubit) {
//           cubit.doIntent(CheckGuestIntent());
//         },
//         expect: () {
//           return [
//             isA<CeckGuestState>(),
//           ];
//         },
//       );
//
//       blocTest<AuthCubit, AuthState>(
//         'when call do intent with ChangeGuestIntent it '
//         ' should change guest and return correct state',
//         build: () {
//           var result = Success<bool>(true);
//           var value = true;
//           provideDummy<Result<bool>>(result);
//           when(changeGuestUsecase.call(isGuest: true))
//               .thenAnswer((_) async => value);
//           when(checkGuestUseCase.call()).thenAnswer((_) async => result);
//           return authCubit;
//         },
//         act: (cubit) {
//           cubit.doIntent(ChangeGuestIntent(isGuest: true));
//         },
//         expect: () {
//           return [
//             isA<CeckGuestState>(),
//           ];
//         },
//       );
//
//       const String testEmail = 'ayaallahemara@gmail.com';
//       const String testPassword = 'Aya@1234';
//       const String testCode = '123456';
//
//       blocTest<AuthCubit, AuthState>(
//         'emits [SendEmailVerificationLoadingState, SendEmailVerificationSuccessState] when email verification is successful',
//         build: () {
//           provideDummy<ApiResult<bool>>(SuccessApiResult(true));
//           when(mockForgetPasswordUseCase.invoke(email: testEmail))
//               .thenAnswer((_) async => SuccessApiResult(true));
//           return authCubit;
//         },
//         act: (cubit) => cubit.doIntent(ForgetPassword(email: testEmail)),
//         expect: () => [
//           isA<SendEmailVerificationLoadingState>(),
//           isA<SendEmailVerificationSuccessState>(),
//         ],
//       );
//
//       blocTest<AuthCubit, AuthState>(
//         'emits [VerifyResetCodeLoadingState, VerifyResetCodeSuccessState] when code verification is successful',
//         build: () {
//           provideDummy<ApiResult<bool>>(SuccessApiResult(true));
//           when(mockVerifyresetcodeUseCase.check(code: testCode))
//               .thenAnswer((_) async => SuccessApiResult(true));
//           return authCubit;
//         },
//         act: (cubit) => cubit.doIntent(VerifyResetCode(resetCode: testCode)),
//         expect: () => [
//           isA<VerifyResetCodeLoadingState>(),
//           isA<VerifyResetCodeSuccessState>(),
//         ],
//       );
//
//       blocTest<AuthCubit, AuthState>(
//         'emits [ResetPasswordLoadingState, ResetPasswordSuccessState] when password reset is successful',
//         build: () {
//           provideDummy<ApiResult<bool>>(SuccessApiResult(true));
//           when(mockResetpasswordUsecase.invoke(email: testEmail, password: testPassword))
//               .thenAnswer((_) async => SuccessApiResult(true));
//           return authCubit;
//         },
//         act: (cubit) => cubit.doIntent(ResetPassword(email: testEmail, NewPassword: testPassword)),
//         expect: () => [
//           isA<ResetPasswordLoadingState>(),
//           isA<ResetPasswordSuccessState>(),
//         ],
//       );
//
//     },
//   );
// }
