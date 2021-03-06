import 'package:hive/hive.dart';
import 'package:recipe_app/presentation/resources/asset_manager.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class RecipeVegetarianOrDessert {
  @HiveField(0)
  late double healthScore;
  @HiveField(1)
  late List<Ingredients> ingredient;
  @HiveField(2)
  late int id;
  @HiveField(3)
  late String title;
  @HiveField(4)
  late int readyInMinutes;
  @HiveField(5)
  late String img;
  @HiveField(6)
  late String instructions;
  RecipeVegetarianOrDessert(
      {required this.healthScore,
      required this.ingredient,
      required this.title,
      required this.id,
      required this.img,
      required this.instructions,
      required this.readyInMinutes});
  factory RecipeVegetarianOrDessert.fromJson(Map<String, dynamic> json) {
    var list = json['extendedIngredients'] as List;
    List<Ingredients> ing = list.map((i) => Ingredients.fromJson(i)).toList();
    return RecipeVegetarianOrDessert(
      id: json['id'],
      healthScore: json['healthScore'] ?? 0,
      ingredient: ing,
      title: json['title'] ?? "",
      readyInMinutes: json['readyInMinutes'] ?? 0,
      img: json['image'] ?? AssetManager.food,
      instructions: json['instructions'] ?? "",
    );
  }
}


// Here Problem : Where is the adapter for ingredients?!
@HiveType(typeId: 1)
class Ingredients {
  @HiveField(0)
  late String nameClean;
  @HiveField(1)
  late String unit;
  @HiveField(2)
  late double amount;
  Ingredients(
      {required this.nameClean, required this.unit, required this.amount});
  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(
      nameClean: json['nameClean'] ?? "",
      unit: json['unit'] ?? "",
      amount: json['amount'] ?? 0.0,
    );
  }
}

class IngredientList {
  late List<IngredientSearch> ingredient;
  IngredientList({required this.ingredient});

  factory IngredientList.formJson(List<dynamic> json) {
    return IngredientList(
        ingredient: json.map((e) => IngredientSearch.fromJson(e)).toList());
  }
}

class IngredientSearch {
  late int id;
  late String image;
  late List<IngredientUsed> items;
  late String title;

  IngredientSearch({
    required this.id,
    required this.image,
    required this.items,
    required this.title,
  });

  factory IngredientSearch.fromJson(Map<String, dynamic> json) {
    List list1 = json['missedIngredients'] as List;
    List list2 = json['unusedIngredients'] as List;
    List list3 = json['usedIngredients'] as List;

    List<IngredientUsed> items =
        list1.map((e) => IngredientUsed.fromJson(e)).toList();
    items = list2.map((e) => IngredientUsed.fromJson(e)).toList();
    items = list3.map((e) => IngredientUsed.fromJson(e)).toList();
    return IngredientSearch(
        id: json['id'] ?? 0,
        image: json['image'] ?? "",
        items: items,
        title: json['title'] ?? "");
  }
}

class IngredientUsed {
  late double amount;
  late String originalName;
  late String units;

  IngredientUsed({
    required this.amount,
    required this.originalName,
    required this.units,
  });
  factory IngredientUsed.fromJson(Map<String, dynamic> json) {
    return IngredientUsed(
        amount: json['amount'] ?? 0.0,
        originalName: json['originalName'] ?? "",
        units: json['unit'] ?? "");
  }
}

class NutrientInfo {
  late String image;
  late String value;
  late String kind;

  NutrientInfo({required this.image, required this.value, required this.kind});
}
