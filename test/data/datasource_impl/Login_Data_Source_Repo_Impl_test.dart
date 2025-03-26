import 'package:flora_mart/core/api/api_manager.dart';
import 'package:flora_mart/core/api/api_result.dart';
import 'package:flora_mart/core/api/endpoints.dart';
import 'package:flora_mart/core/cache/shared_pref.dart';
import 'package:flora_mart/core/constant.dart';
import 'package:flora_mart/data/datasource_impl/login_data_source_repo_impl.dart';
import 'package:flora_mart/data/model/UserModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([ApiManager, SharedPreferences])
import 'login_data_source_repo_impl_test.mocks.dart';

void main() {
  late LoginDatasourceImpl loginDatasource;
  late MockApiManager mockApiManager;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() async {
    mockApiManager = MockApiManager();
    mockSharedPreferences = MockSharedPreferences();

    // Initialize with mock preferences
    CacheHelper.initForTest(mockSharedPreferences);

    loginDatasource = LoginDatasourceImpl(mockApiManager);
  });

  tearDown(() {
    reset(mockApiManager);
    reset(mockSharedPreferences);
  });

  group('login', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testToken = 'test_token';
    final testUserModel = UserModel(token: testToken);

    test('should return UserModel when login is successful', () async {
      // Arrange
      when(mockApiManager.postRequest(
        endpoint: EndPoint.signInEndpoint,
        body: {'email': testEmail, 'password': testPassword},
      )).thenAnswer((_) async => Response(
        data: {'token': testToken},
        requestOptions: RequestOptions(path: EndPoint.signInEndpoint),
        statusCode: 200,
      ));

      when(mockSharedPreferences.setString('auth_token', testToken))
          .thenAnswer((_) async => true);
      when(mockSharedPreferences.setBool(Constant.isRememberMe, true))
          .thenAnswer((_) async => true);

      // Act
      final result = await loginDatasource.login(
        email: testEmail,
        password: testPassword,
        rememberMe: true,
      );

      // Assert
      expect(result, isA<SuccessApiResult<UserModel>>());
      expect((result as SuccessApiResult).data?.token, testToken);

      verify(mockApiManager.postRequest(
        endpoint: EndPoint.signInEndpoint,
        body: {'email': testEmail, 'password': testPassword},
      )).called(1);

      verify(mockSharedPreferences.setString('auth_token', testToken)).called(1);
      verify(mockSharedPreferences.setBool(Constant.isRememberMe, true)).called(1);
    });

    test('should handle empty response from API', () async {
      // Arrange
      when(mockApiManager.postRequest(
        endpoint: EndPoint.signInEndpoint,
        body: {'email': testEmail, 'password': testPassword},
      )).thenAnswer((_) async => Response(
        data: null,
        requestOptions: RequestOptions(path: EndPoint.signInEndpoint),
        statusCode: 200,
      ));

      // Act
      final result = await loginDatasource.login(
        email: testEmail,
        password: testPassword,
        rememberMe: false,
      );

      // Assert
      expect(result, isA<SuccessApiResult<UserModel>>());
      expect((result as SuccessApiResult).data?.token, isNull);

      verifyNever(mockSharedPreferences.setString(any, any));
      verifyNever(mockSharedPreferences.setBool(any, any));
    });

    test('should handle malformed response from API', () async {
      // Arrange
      when(mockApiManager.postRequest(
        endpoint: EndPoint.signInEndpoint,
        body: {'email': testEmail, 'password': testPassword},
      )).thenAnswer((_) async => Response(
        data: {'invalid': 'response'},
        requestOptions: RequestOptions(path: EndPoint.signInEndpoint),
        statusCode: 200,
      ));

      // Act
      final result = await loginDatasource.login(
        email: testEmail,
        password: testPassword,
        rememberMe: false,
      );

      // Assert
      expect(result, isA<SuccessApiResult<UserModel>>());
      expect((result as SuccessApiResult).data?.token, isNull);
    });


    test('should handle rememberMe save failure', () async {
      // Arrange
      when(mockApiManager.postRequest(
        endpoint: EndPoint.signInEndpoint,
        body: {'email': testEmail, 'password': testPassword},
      )).thenAnswer((_) async => Response(
        data: {'token': testToken},
        requestOptions: RequestOptions(path: EndPoint.signInEndpoint),
        statusCode: 200,
      ));

      when(mockSharedPreferences.setString('auth_token', testToken))
          .thenAnswer((_) async => true);
      when(mockSharedPreferences.setBool(Constant.isRememberMe, true))
          .thenAnswer((_) async => false);

      // Act
      final result = await loginDatasource.login(
        email: testEmail,
        password: testPassword,
        rememberMe: true,
      );

      // Assert
      expect(result, isA<SuccessApiResult<UserModel>>());
      expect((result as SuccessApiResult).data?.token, testToken);

      verify(mockSharedPreferences.setString('auth_token', testToken)).called(1);
      verify(mockSharedPreferences.setBool(Constant.isRememberMe, true)).called(1);
    });

  });
}