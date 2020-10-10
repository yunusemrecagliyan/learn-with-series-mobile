// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backgroundImage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BackgroundImageAdapter extends TypeAdapter<BackgroundImage> {
  @override
  final int typeId = 5;

  @override
  BackgroundImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BackgroundImage(
      id: fields[0] as int,
      name: fields[1] as String,
      url: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BackgroundImage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackgroundImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
