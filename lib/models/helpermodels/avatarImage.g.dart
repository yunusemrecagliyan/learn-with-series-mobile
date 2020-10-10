// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatarImage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AvatarImageAdapter extends TypeAdapter<AvatarImage> {
  @override
  final int typeId = 4;

  @override
  AvatarImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AvatarImage(
      id: fields[0] as int,
      name: fields[1] as String,
      url: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AvatarImage obj) {
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
      other is AvatarImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
