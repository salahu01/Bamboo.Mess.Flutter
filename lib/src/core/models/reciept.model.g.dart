// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reciept.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecieptProductAdapter extends TypeAdapter<RecieptProduct> {
  @override
  final int typeId = 0;

  @override
  RecieptProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecieptProduct(
      name: fields[0] as String?,
      price: fields[1] as num?,
      count: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RecieptProduct obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecieptProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
