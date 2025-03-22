part of 'Login_cubit.dart';

sealed class LoginStates {}

final class LoginInitial extends LoginStates {}

final class LoginSuccessState extends LoginStates {
  UserModel? userModel;
  LoginSuccessState({required this.userModel});
}

final class LoginLoadingState extends LoginStates {}

final class LoginErrorState extends LoginStates {
  String? message;
  LoginErrorState({required this.message});
}
