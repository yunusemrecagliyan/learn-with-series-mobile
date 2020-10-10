import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:lernwithseries/models/episode.dart';
import 'package:lernwithseries/models/series.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String email;
  @HiveField(2)
  String firstname;
  @HiveField(3)
  Episode lastEpisode;
  @HiveField(4)
  String lastname;
  @HiveField(5)
  List<Series> savedSeries;
  @HiveField(6)
  int score;
  @HiveField(7)
  String username;
  User({
    this.id,
    this.email,
    this.firstname,
    this.lastEpisode,
    this.lastname,
    this.savedSeries,
    this.score,
    this.username,
  });

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      email: map['email'],
      firstname: map['firstname'],
      lastEpisode: Episode.fromMap(map['lastEpisode']),
      lastname: map['lastname'],
      savedSeries:
          List<Series>.from(map['savedSeries']?.map((x) => Series.fromMap(x))),
      score: int.tryParse(map['score']),
      username: map['username'],
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        firstname.hashCode ^
        lastEpisode.hashCode ^
        lastname.hashCode ^
        savedSeries.hashCode ^
        score.hashCode ^
        username.hashCode;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.id == id &&
        o.email == email &&
        o.firstname == firstname &&
        o.lastEpisode == lastEpisode &&
        o.lastname == lastname &&
        listEquals(o.savedSeries, savedSeries) &&
        o.score == score &&
        o.username == username;
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, firstname: $firstname, lastEpisode: $lastEpisode, lastname: $lastname, savedSeries: $savedSeries, score: $score, username: $username)';
  }

  User copyWith({
    int id,
    String email,
    String firstname,
    Episode lastEpisode,
    String lastname,
    List<Series> savedSeries,
    int score,
    String username,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastEpisode: lastEpisode ?? this.lastEpisode,
      lastname: lastname ?? this.lastname,
      savedSeries: savedSeries ?? this.savedSeries,
      score: score ?? this.score,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstname': firstname,
      'lastEpisode': lastEpisode?.toMap(),
      'lastname': lastname,
      'savedSeries': savedSeries?.map((x) => x?.toMap())?.toList(),
      'score': score,
      'username': username,
    };
  }

  String toJson() => json.encode(toMap());
}
