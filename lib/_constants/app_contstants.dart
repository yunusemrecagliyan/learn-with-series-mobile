import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:learnwithseries/services/auth_service.dart';

class RoutePaths {
  static const String Login = 'login';
  static const String Register = 'register';
  static const String Auth = 'auth';
  static const String Home = '/';
  static const String Series = 'series';
  static const String NewSeries = "newSeries";
  static const String SavedSeries = "savedSeries";
  static const String RandomSeries = "randomSeries";
  static const String LastSeries = "lastSeries";
  static const String Episode = "episode";
  static const String Quiz = "quiz";
  static const String AllSeries = "allSeries";
}

const baseUrl = "http://192.168.1.104:1337";

reLogin() async {
  var email = Hive.box("auth").get("email");
  var password = Hive.box("auth").get("password");
  if (email != null || password != null) {
    var authService = new AuthService();
    var jwt = await json.decode(await authService.login(email, password));
    authService.setToken(jwt["jwt"]);
  }
}
