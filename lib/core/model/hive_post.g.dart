// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePostAdapter extends TypeAdapter<HivePost> {
  @override
  final int typeId = 0;

  @override
  HivePost read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePost()
      ..id = fields[0] as int?
      ..title = fields[1] as String?
      ..body = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, HivePost obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.body);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
