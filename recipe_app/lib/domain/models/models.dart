import 'package:recipe_app/presentation/resources/asset_manager.dart';

class RecipeVegetarianOrDessert {
  late double healthScore;
  late List<Ingredients> ingredient;
  late int id;
  late String title;
  late int readyInMinutes;
  late String img;
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

class Ingredients {
  late String nameClean;
  late String unit;
  late double amount;
  Ingredients(
      {required this.nameClean, required this.unit, required this.amount});
  Ingredients.fromJson(Map<String, dynamic> json) {
    nameClean = json['nameClean'] ?? "";
    unit = json['unit'] ?? "";
    amount = json['amount'] ?? 0.0;
  }
}

class NutrientInfo {
  late String image;
  late String value;
  late String kind;

  NutrientInfo({required this.image, required this.value, required this.kind});
}
