// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EpisodeAdapter extends TypeAdapter<Episode> {
  @override
  final int typeId = 3;

  @override
  Episode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Episode(
      id: fields[0] as int,
      chapterNo: fields[1] as String,
      seasonNo: fields[2] as String,
      name: fields[3] as String,
      questions: (fields[4] as List)?.cast<Question>(),
    );
  }

  @override
  void write(BinaryWriter writer, Episode obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.chapterNo)
      ..writeByte(2)
      ..write(obj.seasonNo)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpisodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
