import 'package:flora_mart/core/api/api_result.dart';
import 'package:flora_mart/domain/usecase/forget_password_usecases/forget_password_usecase.dart';
import 'package:flora_mart/domain/usecase/forget_password_usecases/reset_password_usecase.dart';
import 'package:flora_mart/domain/usecase/forget_password_usecases/verify_reset_code_usecase.dart';
import 'package:flora_mart/presentation/auth/view_model/cubit/auth_cubit.dart';
import 'package:flora_mart/presentation/auth/view_model/cubit/auth_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';

import 'auth_cubit_test.mocks.dart';

@GenerateMocks([ForgetPasswordUseCase, VerifyresetcodeUseCase, ResetpasswordUsecase])
void main() {
  late MockForgetPasswordUseCase mockForgetPasswordUseCase;
  late MockVerifyresetcodeUseCase mockVerifyresetcodeUseCase;
  late MockResetpasswordUsecase mockResetpasswordUsecase;

  setUp(() {
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    mockVerifyresetcodeUseCase = MockVerifyresetcodeUseCase();
    mockResetpasswordUsecase = MockResetpasswordUsecase();
  });

  group('AuthCubit Tests', () {
    const String testEmail = 'ayaallahemara@gmail.com';
    const String testPassword = 'Aya@1234';
    const String testCode = '123456';

    blocTest<AuthCubit, AuthState>(
      'emits [SendEmailVerificationLoadingState, SendEmailVerificationSuccessState] when email verification is successful',
      build: () {
        when(mockForgetPasswordUseCase.invoke(email: testEmail))
            .thenAnswer((_) async => SuccessApiResult(true));
        return AuthCubit(
          verifyresetcodeUseCase: mockVerifyresetcodeUseCase,
          resetpasswordUsecase: mockResetpasswordUsecase,
          forgetPasswordUseCase: mockForgetPasswordUseCase,
        );
      },
      act: (cubit) => cubit.doIntent(ForgetPassword(email: testEmail)),
      expect: () => [
        isA<SendEmailVerificationLoadingState>(),
        isA<SendEmailVerificationSuccessState>(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [VerifyResetCodeLoadingState, VerifyResetCodeSuccessState] when code verification is successful',
      build: () {
        when(mockVerifyresetcodeUseCase.check(code: testCode))
            .thenAnswer((_) async => SuccessApiResult(true));
        return AuthCubit(
          verifyresetcodeUseCase: mockVerifyresetcodeUseCase,
          resetpasswordUsecase: mockResetpasswordUsecase,
          forgetPasswordUseCase: mockForgetPasswordUseCase,
        );
      },
      act: (cubit) => cubit.doIntent(VerifyResetCode(resetCode: testCode)),
      expect: () => [
        isA<VerifyResetCodeLoadingState>(),
        isA<VerifyResetCodeSuccessState>(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [ResetPasswordLoadingState, ResetPasswordSuccessState] when password reset is successful',
      build: () {
        when(mockResetpasswordUsecase.invoke(email: testEmail, password: testPassword))
            .thenAnswer((_) async => SuccessApiResult(true));
        return AuthCubit(
          verifyresetcodeUseCase: mockVerifyresetcodeUseCase,
          resetpasswordUsecase: mockResetpasswordUsecase,
          forgetPasswordUseCase: mockForgetPasswordUseCase,
        );
      },
      act: (cubit) => cubit.doIntent(ResetPassword(email: testEmail, NewPassword: testPassword)),
      expect: () => [
        isA<ResetPasswordLoadingState>(),
        isA<ResetPasswordSuccessState>(),
      ],
    );
  });
}
