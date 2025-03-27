sealed class AuthIntent {}

class CheckGuestIntent extends AuthIntent {}

class ChangeGuestIntent extends AuthIntent {
  final bool isGuest;

  ChangeGuestIntent({required this.isGuest});
}

class RegisterUserIntent extends AuthIntent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;
  final String gender;

  RegisterUserIntent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
    required this.gender,
  });
}
