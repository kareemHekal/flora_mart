import 'dart:developer';

import 'package:flora_mart/domain/common/result.dart';
import 'package:flora_mart/domain/usecase/changeGuest_usecase.dart';
import 'package:flora_mart/domain/usecase/check_guest_usecase.dart';
import 'package:flora_mart/presentation/auth/view_model/cubit/auth_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @factoryMethod
  final CheckGuestUseCase checkGuestUseCase;
  final ChangeguestUsecase changeGuestUsecase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final VerifyresetcodeUseCase verifyresetcodeUseCase;
  final ResetpasswordUsecase resetpasswordUsecase;

  AuthCubit(
     this.verifyresetcodeUseCase,
     this.resetpasswordUsecase,
     this.forgetPasswordUseCase,
     this.checkGuestUseCase,
     this.changeGuestUsecase
  ) : super(AuthInitial());


  void doIntent(AuthIntent authIntent) {
    switch (authIntent) {
      case CheckGuestIntent():
        _checkGuest();
        break;
      case ChangeGuestIntent():
        _changeGuest(intent: authIntent);
        break;
      case ForgetPassword():
        _ForgetPassword(intent: authIntent);
        break;
      case VerifyResetCode():
        _VerifyResetCode(intent: authIntent);
        break;
      case ResetPassword():
        _ResetPassword(intent: authIntent);
        break;
    }
  }


  static AuthCubit get(context) => BlocProvider.of(context);

  bool? isguest = false;
  _checkGuest() async {
    var result = await checkGuestUseCase.call();
    switch (result) {
      case Success():
        isguest = result.data;
        log("in cubit result: ${result.data}");
        emit(CeckGuestState(result.data ?? false));
        break;
      default:
        emit(CeckGuestState(false));
    }
  }

  _changeGuest({required ChangeGuestIntent intent}) async {
    bool success = await changeGuestUsecase.call(isGuest: intent.isGuest);
    if (success) {
      return _checkGuest();
    } else {
      log("Failed to change guest status");
      emit(CeckGuestState(isguest ?? false)); // ❌ إبقاء الحالة كما هي دون تغيير
    }
  }
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

