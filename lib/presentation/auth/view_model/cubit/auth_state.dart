part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class CeckGuestState extends AuthState {
  final bool isGuest;
  CeckGuestState(this.isGuest);
}
