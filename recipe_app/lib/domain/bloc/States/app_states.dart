import 'package:recipe_app/domain/models/models.dart';

enum RecipeStateStatus {
  inital,
  changeIndex,
  traversefromVegToDes,
  vegatrianLoading,
  vegatrianSuccess,
  vegatrianFailure,
  dessertLoading,
  dessertSuccess,
  dessertFailure,
  changefavoritiesRecipeVegColor,
  changefavoritiesRecipeDesColor,
  initalizeFavoritiesIndexes,
  refreshFavoritiesItems,
}

class RecipeStates {
  RecipeStateStatus? status;
  List<RecipeVegetarianOrDessert>? recipesOfVegatrian;
  List<RecipeVegetarianOrDessert>? recipesOfDessert;
  List<String>? favoritiesRecipeVegColors;
  List<String>? favoritiesRecipeDesColors;
  Exception? exception;

  
  RecipeStates(
      {this.status,
      this.recipesOfVegatrian,
      this.recipesOfDessert,
      this.favoritiesRecipeVegColors,
      this.favoritiesRecipeDesColors,
      this.exception});

  RecipeStates copyWith({
    RecipeStateStatus? status,
    List<RecipeVegetarianOrDessert>? recipesOfVegatrian,
    List<RecipeVegetarianOrDessert>? recipesOfDessert,
    List<String>? favoritiesRecipeVegColors,
    List<String>? favoritiesRecipeDesColors,
    Exception? exception,
  }) {
    return RecipeStates(
      status: status ?? this.status,
      recipesOfVegatrian: recipesOfVegatrian ?? this.recipesOfVegatrian,
      recipesOfDessert: recipesOfDessert ?? this.recipesOfDessert,
      favoritiesRecipeVegColors:
          favoritiesRecipeVegColors ?? this.favoritiesRecipeVegColors,
      exception: exception ?? this.exception,
      favoritiesRecipeDesColors:
          favoritiesRecipeDesColors ?? this.favoritiesRecipeDesColors,
    );
  }
}
