
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_manager.dart';
import '../datasource_contract/auth_datasource.dart';

@Injectable(as:AuthDatasource )
class AuthDatasourceImpl extends AuthDatasource {
  @factoryMethod
  ApiManager apiManager;

  AuthDatasourceImpl(this.apiManager);


 /* Future<ApiResult<ForgetPasswordEntity>> ForgetPassword(
      {required String email}) async {
    try {
      var response = await apiManager.postRequest(
        endpoint: EndPoint.ForgetPasswordEndpoints,
        body: {"email": email},
      );

      ForgetPasswordResponse forgetResponse = ForgetPasswordResponse.fromJson(
          response.data);
      ForgetPasswordEntity forgetPasswordEntity = forgetResponse
          .toForgetPasswordEntity();

      // Ensure proper error handling
      if (forgetPasswordEntity.code != null) {
        return ErrorApiResult(Exception(
            forgetPasswordEntity.message ?? "Unknown error occurred"));
      }

      return SuccessApiResult(forgetPasswordEntity);
    } on DioException catch (e) {
      return ErrorApiResult(e);
    } catch (e) {
      return ErrorApiResult(Exception("Unexpected error: ${e.toString()}"));
    }
  }
*/



}