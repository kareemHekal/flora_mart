part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class CeckGuestState extends AuthState {
  final bool isGuest;

  CeckGuestState(this.isGuest);
}

final class RegisterViewModelLoading extends AuthState {}

final class RegisterViewModelSuccess extends AuthState {
  final AuthResponseEntity response;

  RegisterViewModelSuccess(this.response);
}

final class RegisterViewModelFailure extends AuthState {
  final String error;

  RegisterViewModelFailure(this.error);
}
