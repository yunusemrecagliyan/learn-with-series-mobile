import 'dart:convert';

import 'package:hive/hive.dart';

part 'avatarImage.g.dart';

@HiveType(typeId: 4)
class AvatarImage {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String url;
  AvatarImage({
    this.id,
    this.name,
    this.url,
  });

  AvatarImage copyWith({
    int id,
    String name,
    String url,
  }) {
    return AvatarImage(
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

  static AvatarImage fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AvatarImage(
      id: map['id'],
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  static AvatarImage fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'AvatarImage(id: $id, name: $name, url: $url)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AvatarImage && o.id == id && o.name == name && o.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ url.hashCode;
}
