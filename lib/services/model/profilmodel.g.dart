// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfilModelAdapter extends TypeAdapter<ProfilModel> {
  @override
  final int typeId = 2;

  @override
  ProfilModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfilModel(
      name: fields[0] as String,
      photoURL: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfilModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.photoURL);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfilModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
