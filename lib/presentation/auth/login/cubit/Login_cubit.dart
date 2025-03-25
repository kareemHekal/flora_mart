import 'package:flora_mart/core/api/api_result.dart';
import 'package:flora_mart/core/cache/shared_pref.dart';
import 'package:flora_mart/data/model/UserModel.dart';
import 'package:flora_mart/domain/usecase/login_Usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'Login_intent.dart';

part 'Login_states.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit({
    required this.signinUsecase,
  }) : super(LoginInitial());
  @factoryMethod
  LoginUsecase signinUsecase;

  void doIntent(LoginIntent intent) {
    switch (intent) {
      case SignInIntent():
        _SignIn(intent: intent);
        break;
    }
  }

  _SignIn({required SignInIntent intent}) async {
    emit(LoginLoadingState());
    final result = await signinUsecase.invoke(
      email: intent.email,
      rememberMe: intent.rememberMe,
      password: intent.password,
    );
    switch (result) {
      case SuccessApiResult():
        emit(LoginSuccessState(userModel: result.data));
        break;
      case ErrorApiResult():
        print("${result.exception.toString()} Error ⛔⛔");
        emit(LoginErrorState(message: result.exception.toString()));
        break;
    }
  }
}
