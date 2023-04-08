import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicePreferences {
  Future createCache(String fireBaseUID) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.setString("fireBaseUID", fireBaseUID);
  }

  Future createUserData(
    String firstName,
    String? lastName,
    String phonenumber,
    String email,
  ) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.setString("firstName", firstName);
    if (lastName != null) _preferences.setString("lastName", lastName);
    _preferences.setString("phonenumber", phonenumber);
    _preferences.setString("email", email);
  }

  Future createCompletedProfile(bool completedProfile) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.setBool("completedProfile", completedProfile);
  }

  Future readCache(String fireBaseUID) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    String? cache =  _preferences.getString("fireBaseUID");
     
    return cache;
  }

  Future readUserDataCache(String whatDataYouWantTypeInString) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString(whatDataYouWantTypeInString);
    return cache;
  }

  Future readCompletedProfile() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    var cache = _preferences.getBool("completedProfile");
    return cache;
  }

  Future removeAllCache() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.remove("fireBaseUID");
    _preferences.remove("completedProfile");
    _preferences.remove("firstname");
    _preferences.remove("lastname");
    _preferences.remove("phonenumber");
    _preferences.remove("email");
  }
}
