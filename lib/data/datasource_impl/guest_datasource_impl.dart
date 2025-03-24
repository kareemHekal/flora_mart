import 'package:flora_mart/core/cache/shared_pref.dart';
import 'package:flora_mart/core/constant.dart';
import 'package:flora_mart/domain/common/result.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_manager.dart';
import '../datasource_contract/guest_datasource.dart';

@Injectable(as: GuestDatasource)
class GuestDatasourceImpl extends GuestDatasource {
  ApiManager apiManager;
  @factoryMethod
  GuestDatasourceImpl(
    this.apiManager,
  );

  @override
  Future<Result<bool>> checkGuest() async {
    try {
      var result = await CacheHelper.checkGuest();
      return Success(result);
    } catch (error) {
      return Error(Exception(error.toString()));
    }
  }

  @override
  Future<bool> changeGuest({required bool isGuest}) async {
    return await CacheHelper.setData(Constant.questCacheKey, isGuest);
  }
}
