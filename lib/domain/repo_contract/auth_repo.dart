import 'package:dartz/dartz.dart';
import 'package:flora_mart/domain/entity/auth/auth_response_entity.dart';

abstract class AuthRepo {
  Future<Either<String, AuthResponseEntity>> postRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    required String gender,
  });
}

