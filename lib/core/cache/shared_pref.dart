import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _sharedPrefs;
  // we can save the keys over here
  // so that we can use them in the app like this 👇👇
  //  >>  static const String _tokenKey = 'auth_token';

  static Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  //========USAGE=========\\
  /// bool set = await CacheHelper.setData<String>("token", response.data['token']);
  static Future<bool> setData<T>(String key, T value) async {
    if (_sharedPrefs == null) await init();

    if (value is String) {
      return await _sharedPrefs!.setString(key, value);
    } else if (value is bool) {
      return await _sharedPrefs!.setBool(key, value);
    } else if (value is int) {
      return await _sharedPrefs!.setInt(key, value);
    } else if (value is double) {
      return await _sharedPrefs!.setDouble(key, value);
    } else if (value is List<String>) {
      return await _sharedPrefs!.setStringList(key, value);
    } else {
      throw Exception("Invalid type");
    }
  }

  //========USAGE=========\\
  /// String? token = CacheHelper.getData<String>("token");
  static T? getData<T>(String key) {
    if (_sharedPrefs == null) return null;

    if (T == String) {
      return _sharedPrefs!.getString(key) as T?;
    } else if (T == bool) {
      return _sharedPrefs!.getBool(key) as T?;
    } else if (T == int) {
      return _sharedPrefs!.getInt(key) as T?;
    } else if (T == double) {
      return _sharedPrefs!.getDouble(key) as T?;
    } else if (T == List<String>) {
      return _sharedPrefs!.getStringList(key) as T?;
    } else {
      throw Exception("Invalid type");
    }
  }

  static Future<bool> removeData(String key) async {
    if (_sharedPrefs == null) await init();
    return await _sharedPrefs!.remove(key);
  }
}
