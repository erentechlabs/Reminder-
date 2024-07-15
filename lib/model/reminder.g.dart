// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderAdapter extends TypeAdapter<Reminder> {
  @override
  final int typeId = 0;

  @override
  Reminder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reminder(
      firstDate: fields[1] as DateTime?,
      lastChange: fields[0] as DateTime?,
      title: fields[3] as String,
      frequency: fields[4] as String,
      count: fields[5] as int,
      goal: fields[6] as int,
      colorsId: fields[7] as int,
      selectedOption: fields[8] as String,
    )..nextDate = fields[2] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Reminder obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.lastChange)
      ..writeByte(1)
      ..write(obj.firstDate)
      ..writeByte(2)
      ..write(obj.nextDate)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.frequency)
      ..writeByte(5)
      ..write(obj.count)
      ..writeByte(6)
      ..write(obj.goal)
      ..writeByte(7)
      ..write(obj.colorsId)
      ..writeByte(8)
      ..write(obj.selectedOption);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
