import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../constant.dart';


@singleton
class ApiManager{
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: Constant.baseUrl,
          validateStatus: (status){
            if(status!<500){
              return true;
            }
            return false;
          }
      ),);
  }

  Future<Response> getRequest({required String Endpoint, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    var response = await dio.get(Endpoint, queryParameters: queryParameters, options: Options(
      headers: headers,
    ));
    return response;
  }

  Future<Response> postRequest({required String endpoint, Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    var response = await dio.post(endpoint, data: body, options: Options(
        headers: headers
    ));
    return response;
  }

  Future<Response> put({
    required String Endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data, // ✅ Add this parameter for the request body
  }) async {
    var response = await dio.put(
      Endpoint,
      queryParameters: queryParameters,
      data: data, // ✅ Pass the request body here
      options: Options(
        headers: headers,
      ),
    );
    return response;
  }


  Future<Response> delete({required String Endpoint, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    var response = await dio.delete(Endpoint, queryParameters: queryParameters, options: Options(
      headers: headers,
    ));
    return response;
  }

  Future<Response> patchRequest({required String endpoint, Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    var response = await dio.patch(endpoint, data: body, options: Options(
      headers: headers,
    ));
    return response;
  }
}