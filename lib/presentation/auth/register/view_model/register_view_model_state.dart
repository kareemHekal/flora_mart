part of 'register_view_model_cubit.dart';

@immutable
sealed class RegisterViewModelState {}

final class RegisterViewModelInitial extends RegisterViewModelState {}

final class RegisterViewModelLoading extends RegisterViewModelState {}

final class RegisterViewModelSuccess extends RegisterViewModelState {
  final AuthResponseEntity response;

  RegisterViewModelSuccess(this.response);
}

final class RegisterViewModelFailure extends RegisterViewModelState {
  final String error;

  RegisterViewModelFailure(this.error);
}
