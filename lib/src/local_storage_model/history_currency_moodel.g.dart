// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_currency_moodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyLocalstorageModelAdapter
    extends TypeAdapter<CurrencyLocalstorageModel> {
  @override
  final int typeId = 0;

  @override
  CurrencyLocalstorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyLocalstorageModel()
      ..time = fields[0] as DateTime
      ..usdCode = fields[1] as String
      ..usdRate = fields[2] as String
      ..gbpCode = fields[3] as String
      ..gbpRate = fields[4] as String
      ..eurCode = fields[5] as String
      ..eurRate = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, CurrencyLocalstorageModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.usdCode)
      ..writeByte(2)
      ..write(obj.usdRate)
      ..writeByte(3)
      ..write(obj.gbpCode)
      ..writeByte(4)
      ..write(obj.gbpRate)
      ..writeByte(5)
      ..write(obj.eurCode)
      ..writeByte(6)
      ..write(obj.eurRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyLocalstorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
