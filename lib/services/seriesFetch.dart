import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:learnwithseries/_constants/app_contstants.dart';
import 'package:learnwithseries/models/series.dart';

Future<Series> fetchRandomSeries() async {
  var random = new Random();
  //  random number is generated based on the returned response
  String rndVal = random.nextInt(await fetchSeriesCount()).toString();
  // fetching series random value and 1 limit
  return (await fetchSeries(rndVal, 1))[0];
}

Future<int> fetchSeriesCount() async {
  String url = "$baseUrl/series/count";
  String token = Hive.box("auth").get("tokens");

  final response = await http
      .get(url, headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
  if (response.statusCode == 401) {
    reLogin();
    fetchSeriesCount();
  }
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return Series count
    return json.decode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Series Count');
  }
}

Future<Series> findSerie({id, episodeId}) async {
  String url = "$baseUrl/series";
  // ignore: unnecessary_statements
  // ignore: unnecessary_statements
  if (id != "" && id != null) url = url + "?id=$id";
  if (episodeId != "" && episodeId != null)
    url = url + "?episodes.id=$episodeId";

  String token = Hive.box("auth").get("tokens");
  final response = await http
      .get(url, headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

  if (response.statusCode == 401) {
    reLogin();
    findSerie(id: id);
  }

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return Series.fromMap(json.decode(response.body)[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Series');
  }
}

Future<List<Series>> fetchSeries([start = "", limit = ""]) async {
  String url = "$baseUrl/series?";
  // ignore: unnecessary_statements
  start != "" ? url = url + "_start=$start&" : null;
  // ignore: unnecessary_statements
  limit != "" ? url = url + "_limit=$limit&" : null;
  String token = Hive.box("auth").get("tokens");
  final response = await http
      .get(url, headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

  if (response.statusCode == 401) {
    reLogin();
    fetchSeries(start, limit);
    return null;
  }

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Series> parsedSeries = [];
    List body = json.decode(response.body);
    body.forEach((element) {
      parsedSeries.add(Series.fromMap(element));
    });

    return parsedSeries;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Series');
  }
}
