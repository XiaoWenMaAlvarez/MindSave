import 'package:mindsave/home/infrastructure/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServiceImpl implements LocalStorageService {

  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final SharedPreferences sharedPreferences = await getSharedPreferences();
    if(value.runtimeType == String) {
      sharedPreferences.setString(key, value as String);
      return;
    }
    if(value.runtimeType == bool) {
      sharedPreferences.setBool(key, value as bool);
      return;
    }
    throw UnimplementedError("Método no implementado para. ${value.runtimeType}");
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final SharedPreferences sharedPreferences = await getSharedPreferences();
    if(T == String) {
      return sharedPreferences.getString(key) as T?;
    }
    if(T == bool) {
      return sharedPreferences.getBool(key) as T?;
    }
    throw UnimplementedError("Método no implementado para. $T");
  }

  @override
  Future<bool> removeKey(String key) async {
    final SharedPreferences sharedPreferences = await getSharedPreferences();
    return await sharedPreferences.remove(key);
  }

  

}