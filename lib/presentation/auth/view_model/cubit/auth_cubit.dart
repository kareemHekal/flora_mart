import 'dart:developer';

import 'package:flora_mart/core/cache/shared_pref.dart';
import 'package:flora_mart/core/constant.dart';
import 'package:flora_mart/core/di/di.dart';
import 'package:flora_mart/core/utils/routes_manager.dart';
import 'package:flora_mart/domain/common/result.dart';
import 'package:flora_mart/domain/usecase/changeGuest_usecase.dart';
import 'package:flora_mart/domain/usecase/check_guest_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flora_mart/core/api/api_result.dart';
import 'package:flora_mart/data/model/UserModel.dart';
import 'package:flora_mart/domain/usecase/login_Usecase.dart';
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
  final CheckGuestUseCase checkGuestUseCase;
  final ChangeguestUsecase changeGuestUsecase;
  final LoginUsecase signInUsecase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final VerifyresetcodeUseCase verifyresetcodeUseCase;
  final ResetpasswordUsecase resetpasswordUsecase;
  String? startRoute;
  final cacheHelper = getIt<CacheHelper>();
  AuthCubit(
     this.verifyresetcodeUseCase,
    this.signInUsecase
     this.resetpasswordUsecase,
     this.forgetPasswordUseCase,
     this.checkGuestUseCase,
     this.changeGuestUsecase
  ) : super(AuthInitial());

  @factoryMethod
  final LoginUsecase signInUsecase;
  String? startRoute;
  final cacheHelper = getIt<CacheHelper>();

  AuthCubit(this.signInUsecase, this.checkGuestUseCase, this.changeGuestUsecase)
      : super(AuthInitial());

  void doIntent(AuthIntent authIntent) {
    switch (authIntent) {
      case SignInIntent():
        _SignIn(intent: authIntent);
        break;
      case CheckGuestIntent():
        _checkGuest();
        break;
      case ChangeGuestIntent():
        _changeGuest(intent: authIntent);
        break;
      case ForgetPassword():
        _ForgetPassword(intent: intent);
        break;
      case VerifyResetCode():
        _VerifyResetCode(intent: intent);
        break;
      case ResetPassword():
        _ResetPassword(intent: intent);
        break;
      case CheckAuthIntent():
        _CheekAuth();
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

  _SignIn({required SignInIntent intent}) async {
    emit(LoginLoadingState());
    final result = await signInUsecase.invoke(
      email: intent.email,
      rememberMe: intent.rememberMe,
      password: intent.password,
    );
    switch (result) {
      case SuccessApiResult():
        emit(LoginSuccessState(userModel: result.data));
        _changeGuest(intent: ChangeGuestIntent(isGuest: false));
        break;
      case ErrorApiResult():
        print("${result.exception.toString()} Error ⛔⛔");
        emit(LoginErrorState(message: result.exception.toString()));
        break;
    }
  }
  Future<bool> getRememberMe() async {
    return await cacheHelper.getData<bool>(Constant.isRememberMe);
  }
  _CheekAuth() async {
    bool rememberMe = await getRememberMe();
    if (rememberMe == true) {
      startRoute = RouteManager.homeScreen;
      log(startRoute.toString());
    } else {
      startRoute = RouteManager.loginScreen;
      log(startRoute.toString());
    }
    print("$startRoute ⭐⭐⭐  cubit");

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