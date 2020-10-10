// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeriesAdapter extends TypeAdapter<Series> {
  @override
  final int typeId = 2;

  @override
  Series read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Series(
      id: fields[0] as int,
      backgroundImage: fields[1] as BackgroundImage,
      avatarImage: fields[2] as AvatarImage,
      name: fields[3] as String,
      genre: fields[4] as String,
      difficulty: fields[5] as String,
      seasonCount: fields[7] as int,
      episodes: (fields[8] as List)?.cast<Episode>(),
      description: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Series obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.backgroundImage)
      ..writeByte(2)
      ..write(obj.avatarImage)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.genre)
      ..writeByte(5)
      ..write(obj.difficulty)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.seasonCount)
      ..writeByte(8)
      ..write(obj.episodes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
