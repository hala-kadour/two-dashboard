// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_sprint.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectSprintAdapter extends TypeAdapter<ProjectSprint> {
  @override
  final int typeId = 4;

  @override
  ProjectSprint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectSprint(
      id: fields[0] as int,
      name: fields[1] as String,
      projectId: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectSprint obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.projectId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectSprintAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
