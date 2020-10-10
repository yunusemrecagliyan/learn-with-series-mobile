import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:learnwithseries/models/question.dart';

part 'episode.g.dart';

@HiveType(typeId: 3)
class Episode {
  @HiveField(0)
  int id;
  @HiveField(1)
  String chapterNo;
  @HiveField(2)
  String seasonNo;
  @HiveField(3)
  String name;
  @HiveField(4)
  List<Question> questions;

  Episode({this.id, this.chapterNo, this.seasonNo, this.name, this.questions});

  Episode copyWith({
    int id,
    String chapterNo,
    String seasonNo,
    String name,
    List<Question> questions,
  }) {
    return Episode(
      id: id ?? this.id,
      chapterNo: chapterNo ?? this.chapterNo,
      seasonNo: seasonNo ?? this.seasonNo,
      name: name ?? this.name,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chapterNo': chapterNo,
      'seasonNo': seasonNo,
      'name': name,
      'questions': questions?.map((x) => x?.toMap())?.toList(),
    };
  }

  static Episode fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Episode(
      id: map['id'],
      chapterNo: map['chapterNo'],
      seasonNo: map['seasonNo'],
      name: map['name'],
      questions: map['questions'] != null
          ? List<Question>.from(
              map['questions']?.map((x) => Question.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  static Episode fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Episode(id: $id, chapterNo: $chapterNo, seasonNo: $seasonNo, name: $name, questions: $questions)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Episode &&
        o.id == id &&
        o.chapterNo == chapterNo &&
        o.seasonNo == seasonNo &&
        o.name == name &&
        listEquals(o.questions, questions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        chapterNo.hashCode ^
        seasonNo.hashCode ^
        name.hashCode ^
        questions.hashCode;
  }
}
