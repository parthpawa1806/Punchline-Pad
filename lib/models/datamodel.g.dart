// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datamodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BitsModelsAdapter extends TypeAdapter<BitsModels> {
  @override
  final int typeId = 1;

  @override
  BitsModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BitsModels(
      title: fields[0] as String?,
      body: fields[1] as String?,
      time: fields[2] as String?,
      notes: fields[3] as String?,
      kill_times: fields[4] == null ? 0 : fields[4] as int?,
    )..bomb_times = fields[5] == null ? 0 : fields[5] as int?;
  }

  @override
  void write(BinaryWriter writer, BitsModels obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.notes)
      ..writeByte(4)
      ..write(obj.kill_times)
      ..writeByte(5)
      ..write(obj.bomb_times);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BitsModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SetsModelAdapter extends TypeAdapter<SetsModel> {
  @override
  final int typeId = 2;

  @override
  SetsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SetsModel(
      title: fields[0] as String?,
      body: fields[1] as String?,
      title_list: (fields[2] as List?)?.cast<BitsModels>(),
      notes: fields[3] as String?,
      bitsofset: (fields[4] as List?)?.cast<String>(),
      kill_times: fields[5] == null ? 0 : fields[5] as int?,
      bomb_times: fields[6] == null ? 0 : fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SetsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.title_list)
      ..writeByte(3)
      ..write(obj.notes)
      ..writeByte(4)
      ..write(obj.bitsofset)
      ..writeByte(5)
      ..write(obj.kill_times)
      ..writeByte(6)
      ..write(obj.bomb_times);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LogsModelAdapter extends TypeAdapter<LogsModel> {
  @override
  final int typeId = 3;

  @override
  LogsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogsModel(
      date: fields[0] as String?,
      type: fields[1] as String?,
      venue: fields[2] as String?,
      sets_list: (fields[3] as List?)?.cast<SetsModel>(),
      notes: fields[4] as String?,
      performence: fields[5] as int?,
      time: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LogsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.venue)
      ..writeByte(3)
      ..write(obj.sets_list)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.performence)
      ..writeByte(6)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
