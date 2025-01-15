import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<bool> saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("userName", userName);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userName");
  }

  Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("userEmail", userEmail);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userEmail");
  }

  Future<bool> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("userId", userId);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userId");
  }

  Future<bool> saveFavoriteGenre(String favoriteGenre) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("favoriteGenre", favoriteGenre);
  }

  Future<String?> getFavoriteGenre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("favoriteGenre");
  }
}
