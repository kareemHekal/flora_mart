import 'package:bloc/bloc.dart';
import 'package:flora_mart/core/utils/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/api/api_result.dart';
import '../../../../../../domain/usecase/forget_password_usecases/forget_password_usecase.dart';
import '../../../../../../domain/usecase/forget_password_usecases/reset_password_usecase.dart';
import '../../../../../../domain/usecase/forget_password_usecases/verify_reset_code_usecase.dart';
import 'auth_intent.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.verifyresetcodeUseCase,
    required this.resetpasswordUsecase,
    required this.forgetPasswordUseCase,
  }) : super(AuthInitial());
  @factoryMethod
  ForgetPasswordUseCase forgetPasswordUseCase;
  VerifyresetcodeUseCase verifyresetcodeUseCase;
  ResetpasswordUsecase resetpasswordUsecase;

  void doIntent(AuthIntent intent) {
    switch (intent) {
      case ForgetPassword():
        _ForgetPassword(intent: intent);
        break;
      case VerifyResetCode():
        _VerifyResetCode(intent: intent);
        break;
      case ResetPassword():
        _ResetPassword(intent: intent);
        break;
    }
  }

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  String startRoute = RouteManager.forgetPasswordScreen;


  _ForgetPassword({required ForgetPassword intent}) async {
    emit(SendEmailVerificationLoadingState());
    final result = await forgetPasswordUseCase.invoke(
      email: intent.email,
    );
    switch (result) {
      case SuccessApiResult():
        {
          emit(SendEmailVerificationSuccessState(isSent: result.data ?? false));
        }
      case ErrorApiResult():
        {
          emit(SendEmailVerificationErrorState(
              message: result.exception.toString()));
        }
    }
  }

  _VerifyResetCode({required VerifyResetCode intent}) async {
    emit(VerifyResetCodeLoadingState());
    final result = await verifyresetcodeUseCase.check(
      code: intent.resetCode,
    );
    switch (result) {
      case SuccessApiResult():
        {
          emit(VerifyResetCodeSuccessState(isVerified: result.data ?? false));
        }
      case ErrorApiResult():
        {
          emit(VerifyResetCodeErrorState(message: result.exception.toString()));
        }
    }
  }

  _ResetPassword({required ResetPassword intent}) async {
    emit(ResetPasswordLoadingState());

    final result = await resetpasswordUsecase.invoke(
        email: intent.email, password: intent.NewPassword);

    switch (result) {
      case SuccessApiResult():
        {
          emit(ResetPasswordSuccessState(isChanged: result.data ?? false));
        }
      case ErrorApiResult():
        {
          emit(ResetPasswordErrorState(message: result.exception.toString()));
        }
    }
  }
}