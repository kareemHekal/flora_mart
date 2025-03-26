sealed class AuthIntent {}
class SignInIntent extends AuthIntent {
  final String email;
  final bool rememberMe;
  final String password;

  SignInIntent({
    required this.rememberMe,
    required this.email,
    required this.password,
  });
}

class CheckGuestIntent extends AuthIntent {}

class ChangeGuestIntent extends AuthIntent {
  final bool isGuest;

  ChangeGuestIntent({required this.isGuest});
}
