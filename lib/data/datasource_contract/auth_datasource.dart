import 'package:dartz/dartz.dart';
import 'package:flora_mart/data/model/auth/auth_response.dart';

abstract class AuthDatasource {
  Future<Either<String, AuthResponse>> postRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    required String gender,
  });
}

