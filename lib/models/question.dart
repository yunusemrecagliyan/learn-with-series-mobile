import 'dart:convert';

import 'package:flutter/foundation.dart';

class Question {
  int id;
  String englishSentence;
  String turkishSentence;
  Sound sound;
  List<Option> option;
  Question({
    this.id,
    this.englishSentence,
    this.turkishSentence,
    this.sound,
    this.option,
  });

  Question copyWith({
    int id,
    String englishSentence,
    String turkishSentence,
    Sound sound,
    List<Option> option,
  }) {
    return Question(
      id: id ?? this.id,
      englishSentence: englishSentence ?? this.englishSentence,
      turkishSentence: turkishSentence ?? this.turkishSentence,
      sound: sound ?? this.sound,
      option: option ?? this.option,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'englishSentence': englishSentence,
      'turkishSentence': turkishSentence,
      'sound': sound?.toMap(),
      'option': option?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Question(
      id: map['id'],
      englishSentence: map['englishSentence'],
      turkishSentence: map['turkishSentence'],
      sound: Sound.fromMap(map['sound']),
      option: List<Option>.from(map['option']?.map((x) => Option.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(id: $id, englishSentence: $englishSentence, turkishSentence: $turkishSentence, sound: $sound, option: $option)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Question &&
        o.id == id &&
        o.englishSentence == englishSentence &&
        o.turkishSentence == turkishSentence &&
        o.sound == sound &&
        listEquals(o.option, option);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        englishSentence.hashCode ^
        turkishSentence.hashCode ^
        sound.hashCode ^
        option.hashCode;
  }
}

class Option {
  int id;
  int key;
  String sentence;
  Option({
    this.id,
    this.key,
    this.sentence,
  });

  Option copyWith({
    int id,
    int key,
    String sentence,
  }) {
    return Option(
      id: id ?? this.id,
      key: key ?? this.key,
      sentence: sentence ?? this.sentence,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'sentence': sentence,
    };
  }

  static Option fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Option(
      id: map['id'],
      key: map['key'],
      sentence: map['sentence'],
    );
  }

  String toJson() => json.encode(toMap());

  static Option fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Option(id: $id, key: $key, sentence: $sentence)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Option && o.id == id && o.key == key && o.sentence == sentence;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode ^ sentence.hashCode;
}

class Sound {
  int id;
  String name;
  String url;
  Sound({
    this.id,
    this.name,
    this.url,
  });

  Sound copyWith({
    int id,
    String name,
    String url,
  }) {
    return Sound(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }

  factory Sound.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Sound(
      id: map['id'],
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Sound.fromJson(String source) => Sound.fromMap(json.decode(source));

  @override
  String toString() => 'Sound(id: $id, name: $name, url: $url)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Sound && o.id == id && o.name == name && o.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ url.hashCode;
}
