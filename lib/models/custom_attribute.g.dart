// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_attribute.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomAttributeAdapter extends TypeAdapter<CustomAttribute> {
  @override
  final int typeId = 2;

  @override
  CustomAttribute read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomAttribute(
      id: fields[0] as int,
      attributes: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, CustomAttribute obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.attributes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomAttributeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
