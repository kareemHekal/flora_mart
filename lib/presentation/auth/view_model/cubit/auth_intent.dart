sealed class AuthIntent {}

class CheckGuestIntent extends AuthIntent {}

class ChangeGuestIntent extends AuthIntent {
  final bool isGuest;

  ChangeGuestIntent({required this.isGuest});
}
