// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountDetailAdapter extends TypeAdapter<CountDetail> {
  @override
  final int typeId = 1;

  @override
  CountDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountDetail(
      id: fields[0] as String,
      counterId: fields[1] as String,
      attributes: (fields[3] as Map?)?.cast<String, dynamic>(),
    )..date = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, CountDetail obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.counterId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.attributes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
