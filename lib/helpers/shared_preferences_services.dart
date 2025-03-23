import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefsService extends GetxService {
  late SharedPreferences _prefs;

  // Método para inicializar SharedPreferences
  Future<SharedPrefsService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  String? getString(String key) => _prefs.getString(key);
  int? getInt(String key) => _prefs.getInt(key);
  bool? getBool(String key) => _prefs.getBool(key);
  double? getDouble(String key) => _prefs.getDouble(key);

  // Método para guardar valores
  Future<void> setString(String key, String value) async => await _prefs.setString(key, value);
  Future<void> setInt(String key, int value) async => await _prefs.setInt(key, value);
  Future<void> setBool(String key, bool value) async => await _prefs.setBool(key, value);
  Future<void> setDouble(String key, double value) async => await _prefs.setDouble(key, value);

  // Método para eliminar un valor
  Future<void> remove(String key) async => await _prefs.remove(key);
}