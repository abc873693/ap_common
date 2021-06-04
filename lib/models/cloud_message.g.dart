// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CloudMessageAdapter extends TypeAdapter<CloudMessage> {
  @override
  final int typeId = 100;

  @override
  CloudMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CloudMessage(
      title: fields[0] as String,
      dateTime: fields[1] as DateTime?,
      content: fields[2] as String?,
      url: fields[3] as String?,
      imageUrl: fields[4] as String?,
      data: (fields[5] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, CloudMessage obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloudMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
