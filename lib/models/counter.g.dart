// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounterAdapter extends TypeAdapter<Counter> {
  @override
  final int typeId = 0;

  @override
  Counter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Counter(
      id: fields[0] as int,
      name: fields[1] as String,
      detailCount: fields[2] as dynamic,
      properties: (fields[4] as List)
          .map((dynamic e) => (e as Map).cast<dynamic, dynamic>())
          .toList(),
    )..requiredAdditionalData = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, Counter obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.detailCount)
      ..writeByte(3)
      ..write(obj.requiredAdditionalData)
      ..writeByte(4)
      ..write(obj.properties);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
