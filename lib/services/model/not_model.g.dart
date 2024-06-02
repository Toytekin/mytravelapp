// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'not_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotModelAdapter extends TypeAdapter<NotModel> {
  @override
  final int typeId = 1;

  @override
  NotModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotModel(
      notID: fields[0] as String,
      notTitle: fields[1] as String,
      ani: fields[2] as String,
      score: fields[3] as double,
      imgURL: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.notID)
      ..writeByte(1)
      ..write(obj.notTitle)
      ..writeByte(2)
      ..write(obj.ani)
      ..writeByte(3)
      ..write(obj.score)
      ..writeByte(4)
      ..write(obj.imgURL);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
