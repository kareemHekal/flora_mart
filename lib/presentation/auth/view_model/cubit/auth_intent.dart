///  Auth Intent ///
sealed class AuthIntent {}

class CheckGuestIntent extends AuthIntent {}

class ChangeGuestIntent extends AuthIntent {
  final bool isGuest;

  ChangeGuestIntent({required this.isGuest});
}

///  FORGOT PASSWORD INTENT ///
class ForgetPassword extends AuthIntent {
  final String email;

  ForgetPassword({required this.email});
}

///  VERIFY RESET CODE INTENT ///
class VerifyResetCode extends AuthIntent {
  final String resetCode;

  VerifyResetCode({required this.resetCode});
}

///  RESET PASSWORD INTENT ///
class ResetPassword extends AuthIntent {
  final String email;
  final String NewPassword;

  ResetPassword({required this.email, required this.NewPassword});
}