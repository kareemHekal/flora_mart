import 'package:dartz/dartz.dart';
import 'package:flora_mart/data/datasource_contract/auth_datasource.dart';
import 'package:flora_mart/domain/entity/auth/auth_response_entity.dart';
import 'package:flora_mart/domain/repo_contract/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  @factoryMethod
  final AuthDatasource apiDatasource;

  AuthRepoImpl(this.apiDatasource);

  @override
  Future<Either<String, AuthResponseEntity>> postRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    required String gender,
  }) async {
    var response = await apiDatasource.postRegister(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
      gender: gender,
    );

    return response.fold(
          (err) => left(err),
          (authResponse) {
        AuthResponseEntity signupResponseEntity =
        authResponse.toLoginResponseEntity();
        return right(signupResponseEntity);
      },
    );

  }
}
