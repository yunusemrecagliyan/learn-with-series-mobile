import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:lernwithseries/_constants/app_contstants.dart';
import 'package:lernwithseries/models/episode.dart';

Future<Episode> fetchEpisode(String id) async {
  String token = Hive.box("auth").get("tokens");
  final response = await http.get('$baseUrl/episodes/$id',
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
  if (response.statusCode == 401) {
    reLogin();
    fetchEpisode(id);
  }

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Episode.fromJson(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
