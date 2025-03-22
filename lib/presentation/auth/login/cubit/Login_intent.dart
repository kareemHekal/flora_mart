sealed class LoginIntent {}

class SignInIntent extends LoginIntent {
  final String email;
  final bool rememberMe;
  final String password;

  SignInIntent({
    required this.rememberMe,
    required this.email,
    required this.password,
  });
}
