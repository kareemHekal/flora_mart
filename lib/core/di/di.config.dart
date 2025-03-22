// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flora_mart/domain/usecase/login_Usecase.dart';
import 'package:flora_mart/presentation/auth/login/cubit/Login_cubit.dart';
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasource_contract/Login_Data_Source_Repo.dart' as _i557;
import '../../data/datasource_contract/auth_datasource.dart' as _i214;
import '../../data/datasource_impl/Login_Data_Source_Repo_Impl.dart' as _i878;
import '../../data/datasource_impl/auth_datasource_impl.dart' as _i422;
import '../../data/repo_impl/Login_Repo_Impl.dart' as _i722;
import '../../data/repo_impl/auth_repo_impl.dart' as _i540;
import '../../domain/repo_contract/Login_Repo.dart' as _i831;
import '../../domain/repo_contract/auth_repo.dart' as _i233;
import '../../domain/usecase/login_Usecase.dart' as _i181;
import '../api/api_manager.dart' as _i1047;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.factory<_i214.AuthDatasource>(
        () => _i422.AuthDatasourceImpl(gh<_i1047.ApiManager>()));
    gh.factory<_i233.AuthRepo>(
        () => _i540.AuthRepoImpl(gh<_i214.AuthDatasource>()));
    gh.factory<_i557.LoginDataSourceRepo>(
        () => _i878.LoginDatasourceImpl(gh<_i1047.ApiManager>()));
    gh.factory<LoginCubit>(() => LoginCubit(signinUsecase: gh<LoginUsecase>()));
    gh.factory<_i831.LoginRepo>(
        () => _i722.SigninRepoImpl(gh<_i557.LoginDataSourceRepo>()));
    gh.factory<_i181.LoginUsecase>(
        () => _i181.LoginUsecase(loginRepo: gh<_i831.LoginRepo>()));
    return this;
  }
}
