import 'package:shared_preferences/shared_preferences.dart';

class ServicePreferences {
  Future createCache(String fireBaseUID) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.setString("fireBaseUID", fireBaseUID);
  }

  Future readCache(String fireBaseUID) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    var cache = _preferences.getString("fireBaseUID");
    return cache;
  }

  Future removeCache(String fireBaseUID) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.remove("fireBaseUID");
  }
}
