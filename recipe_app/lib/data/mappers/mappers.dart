import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/app/extensions.dart';

extension RecipeVegetarianMapper on RecipeVegetarianOrDessert {
  RecipeVegetarianOrDessert elimnateNull() {
    return RecipeVegetarianOrDessert(
      healthScore: healthScore.replaceNullOfDoubles(),
      ingredient: ingredient.map((e) => e.elimnateNullOfIngredients()).toList(),
      title: title.replaceNullOfStrings(),
      id: id.replaceNullOfIntegers(),
      img: img.replaceNullOfStrings(),
      instructions: instructions.replaceNullOfStrings(),
      readyInMinutes: readyInMinutes.replaceNullOfIntegers(),
    );
  }
}

extension RecpiceIngredients on Ingredients {
  Ingredients elimnateNullOfIngredients() {
    return Ingredients(
      nameClean: nameClean.replaceNullOfStrings(),
      unit: unit.replaceNullOfStrings(),
      amount: amount.replaceNullOfDoubles(),
    );
  }
}
