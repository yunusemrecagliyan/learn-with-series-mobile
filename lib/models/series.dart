import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'episode.dart';
import 'helpermodels/avatarImage.dart';
import 'helpermodels/backgroundImage.dart';

part 'series.g.dart';

@HiveType(typeId: 2)
class Series {
  @HiveField(0)
  int id;
  @HiveField(1)
  BackgroundImage backgroundImage;
  @HiveField(2)
  AvatarImage avatarImage;
  @HiveField(3)
  String name;
  @HiveField(4)
  String genre;
  @HiveField(5)
  String difficulty;
  @HiveField(6)
  String description;
  @HiveField(7)
  int seasonCount;
  @HiveField(8)
  List<Episode> episodes;
  Series(
      {this.id,
      this.backgroundImage,
      this.avatarImage,
      this.name,
      this.genre,
      this.difficulty,
      this.seasonCount,
      this.episodes,
      this.description});

  Series copyWith({
    int id,
    BackgroundImage backgroundImage,
    AvatarImage avatarImage,
    String name,
    String genre,
    String difficulty,
    String description,
    int seasonCount,
    List<Episode> episodes,
  }) {
    return Series(
      id: id ?? this.id,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      avatarImage: avatarImage ?? this.avatarImage,
      name: name ?? this.name,
      genre: genre ?? this.genre,
      difficulty: difficulty ?? this.difficulty,
      description: description ?? this.description,
      seasonCount: seasonCount ?? this.seasonCount,
      episodes: episodes ?? this.episodes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'backgroundImage': backgroundImage?.toMap(),
      'avatarImage': avatarImage?.toMap(),
      'name': name,
      'genre': genre,
      'difficulty': difficulty,
      'description': description,
      'seasonCount': seasonCount,
      'episodes': episodes?.map((x) => x?.toMap())?.toList(),
    };
  }

  static Series fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Series(
      id: map['id'],
      backgroundImage: BackgroundImage.fromMap(map['backgroundImage']),
      avatarImage: AvatarImage.fromMap(map['avatarImage']),
      name: map['name'],
      genre: map['genre'],
      difficulty: map['difficulty'],
      description: map['description'],
      seasonCount: map['seasonCount'],
      episodes: map['episodes'] != null
          ? List<Episode>.from(map['episodes']?.map((x) => Episode.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  static Series fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Series(id: $id, backgroundImage: $backgroundImage, avatarImage: $avatarImage, name: $name, genre: $genre, difficulty: $difficulty,description: $description, seasonCount: $seasonCount, episodes: $episodes)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Series &&
        o.id == id &&
        o.backgroundImage == backgroundImage &&
        o.avatarImage == avatarImage &&
        o.name == name &&
        o.genre == genre &&
        o.difficulty == difficulty &&
        o.description == description &&
        o.seasonCount == seasonCount &&
        listEquals(o.episodes, episodes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        backgroundImage.hashCode ^
        avatarImage.hashCode ^
        name.hashCode ^
        genre.hashCode ^
        difficulty.hashCode ^
        description.hashCode ^
        seasonCount.hashCode ^
        episodes.hashCode;
  }
}
