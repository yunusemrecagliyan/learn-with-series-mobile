import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:learnwithseries/_constants/app_contstants.dart';
import 'package:learnwithseries/models/user.dart';

class AuthService {
  Future<dynamic> register(
      {String username,
      String email,
      String password,
      String name,
      String lastname}) async {
    try {
      var res = await http.post('$baseUrl/auth/local/register', body: {
        'username': username,
        'email': email,
        'password': password,
        "firstname": name,
        "lastname": lastname
      });
      if (res.statusCode == 200) {
        (Hive.box("auth")).put("email", email);
        (Hive.box("auth")).put("password", password);
      }
      return res?.body;
    } finally {}
  }

  Future<dynamic> me() async {
    try {
      String token = Hive.box("auth").get("tokens");
      print(token);
      var response = await http.get('$baseUrl/users/me',
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      if (response.statusCode == 401) {
        reLogin();
        me();
      }
      if (response.statusCode == 200) {
        return User.fromJson(response.body);
      }
    } finally {}
  }

  Future<dynamic> login(String email, String password) async {
    try {
      var res = await http.post(
        '$baseUrl/auth/local',
        body: {
          'identifier': email,
          'password': password,
        },
      );
      if (res.statusCode == 200) {
        (Hive.box("auth")).put("email", email);
        (Hive.box("auth")).put("password", password);
      }
      return res?.body;
    } finally {
      // you can do somethig here
    }
  }

  Future<dynamic> update(Map<String, dynamic> fields) async {
    int id = Hive.box("user").get("me").id;
    String token = Hive.box("auth").get("tokens");
    Map<String, String> jsonHeader = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      "content-type": "application/json"
    };
    print(jsonEncode({"savedSeries": fields["savedSeries"]}));
    try {
      var res = await http
          .put('$baseUrl/users/$id',
              body: jsonEncode(fields), headers: jsonHeader)
          .catchError((e) => print(e));
      if (res.statusCode == 200) {
        Hive.box("user").put("me", User.fromJson(res?.body));
      }

      return res?.body;
    } finally {
      // you can do somethig here
    }
  }

  setToken(String token) async {
    await (Hive.box("auth")).put("tokens", token);
  }

  Future<Map<String, dynamic>> getToken() async {
    return await (Hive.box("auth")).get('tokens');
  }

  removeToken() async {
    await (Hive.box("auth")).delete('tokens');
  }
}
