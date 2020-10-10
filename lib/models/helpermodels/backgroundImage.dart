import 'dart:convert';

import 'package:hive/hive.dart';

part 'backgroundImage.g.dart';

@HiveType(typeId: 5)
class BackgroundImage {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String url;
  BackgroundImage({
    this.id,
    this.name,
    this.url,
  });

  BackgroundImage copyWith({
    int id,
    String name,
    String url,
  }) {
    return BackgroundImage(
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

  static BackgroundImage fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BackgroundImage(
      id: map['id'],
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  static BackgroundImage fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => 'BackgroundImage(id: $id, name: $name, url: $url)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BackgroundImage && o.id == id && o.name == name && o.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ url.hashCode;
}
