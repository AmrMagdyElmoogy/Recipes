import 'package:equatable/equatable.dart';
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
enum IngredientSearchStatus { inital, loading, success, failure }

enum CameraTakenStatus { inital, loading, imageToken, success, failure }

class RecipeStates  {
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

  // @override
  // List<Object?> get props => [status,recipesOfDessert,recipesOfVegatrian,favoritiesRecipeDesColors,favoritiesRecipeVegColors];
}

class IngredientSearchStates {
  IngredientSearchStatus? status;
  List<IngredientSearch>? items;
  Exception? exception;

  IngredientSearchStates({
    this.status,
    this.items,
    this.exception,
  });

  IngredientSearchStates copyWith({
    IngredientSearchStatus? status,
    List<IngredientSearch>? items,
    Exception? exception,
  }) {
    return IngredientSearchStates(
        status: status ?? this.status,
        items: items ?? this.items,
        exception: exception ?? this.exception);
  }
}

class CameraStates {
  CameraTakenStatus? cameraTakenStatus;
  List<String>? lables;
  Exception? exception;

  CameraStates({this.cameraTakenStatus, this.lables, this.exception});

  CameraStates copyWith({
    CameraTakenStatus? cameraTakenStatus,
    List<String>? lables,
    Exception? exception,
  }) {
    return CameraStates(
      cameraTakenStatus: cameraTakenStatus ?? this.cameraTakenStatus,
      lables: lables ?? this.lables,
      exception: exception ?? this.exception,
    );
  }
}
