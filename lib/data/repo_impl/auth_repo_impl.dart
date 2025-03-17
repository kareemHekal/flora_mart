import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo_contract/auth_repo.dart';
import '../datasource_contract/auth_datasource.dart';


@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo{
  @factoryMethod
  AuthDatasource apiDatasource;
  AuthRepoImpl(this.apiDatasource);




/*
  Future<ApiResult<ForgetPasswordEntity>> ForgetPassword({required String email}) async{
    var response=await apiDatasource.ForgetPassword(email: email);
    return response;
  }
*/


}