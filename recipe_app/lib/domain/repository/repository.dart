import 'package:dio/dio.dart';
import 'package:recipe_app/data/network/app_api.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/data/mappers/mappers.dart';

abstract class Repository {
  Future<List<RecipeVegetarianOrDessert>> getRecipeVegetarian();
  Future<List<RecipeVegetarianOrDessert>> getDessert();
  Future<List<IngredientSearch>> searchIngredient(String item);
}

class RepositoryImplementation extends Repository {
  final AppClientManager _appClientManager;
  RepositoryImplementation(this._appClientManager);
  @override
  Future<List<RecipeVegetarianOrDessert>> getRecipeVegetarian() async {
    final response = await _appClientManager.getALlRecipesVegetarian();
    return response
        .map((e) => RecipeVegetarianOrDessert.fromJson(e).elimnateNull())
        .toList();
  }

  @override
  Future<List<RecipeVegetarianOrDessert>> getDessert() async {
    final response = await _appClientManager.getALlRecipesDessert();
    return response
        .map((i) => RecipeVegetarianOrDessert.fromJson(i).elimnateNull())
        .toList();
  }

  @override
  Future<List<IngredientSearch>> searchIngredient(String item) async {
    final response = await _appClientManager.getAllIngredientsMatches(item);
    return response.map((e) => IngredientSearch.fromJson(e)).toList();
  }
}
