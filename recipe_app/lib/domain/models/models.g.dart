// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeVegetarianOrDessertAdapter
    extends TypeAdapter<RecipeVegetarianOrDessert> {
  @override
  final int typeId = 0;

  @override
  RecipeVegetarianOrDessert read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeVegetarianOrDessert(
      healthScore: fields[0] as double,
      ingredient: (fields[1] as List).cast<Ingredients>(),
      title: fields[3] as String,
      id: fields[2] as int,
      img: fields[5] as String,
      instructions: fields[6] as String,
      readyInMinutes: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeVegetarianOrDessert obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.healthScore)
      ..writeByte(1)
      ..write(obj.ingredient)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.readyInMinutes)
      ..writeByte(5)
      ..write(obj.img)
      ..writeByte(6)
      ..write(obj.instructions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeVegetarianOrDessertAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IngredientsAdapter extends TypeAdapter<Ingredients> {
  @override
  final int typeId = 1;

  @override
  Ingredients read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ingredients(
      nameClean: fields[0] as String,
      unit: fields[1] as String,
      amount: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Ingredients obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nameClean)
      ..writeByte(1)
      ..write(obj.unit)
      ..writeByte(2)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
