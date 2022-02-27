import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/app/app_perfs.dart';
import 'package:recipe_app/data/network/app_api.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/domain/repository/repository.dart';
import 'package:recipe_app/presentation/activity/activity.dart';
import 'package:recipe_app/presentation/favourites/favourites.dart';
import 'package:recipe_app/presentation/home/home.dart';
import 'package:recipe_app/presentation/search/search_ingredient.dart';

import '../../../app/constants.dart';

class RecipeCubit extends Cubit<RecipeStates> {
  RecipeCubit()
      : super(
          RecipeStates(status: RecipeStateStatus.inital),
        );
  final Repository _repository = RepositoryImplementation(AppClientManager());
  List<Widget> screens = [
    const HomeScreen(),
    const Activity(),
    const Favourites(),
    const SearchIngredient(),
  ];

  // Box<RecipeVegetarianOrDessert> dataBox = Hive.box(DBName);

  @override
  void onChange(Change<RecipeStates> change) {
    super.onChange(change);
    print(change.currentState.status);
  }

  int navBarIndex = 0;

  int navBarChangeIndex(int index) {
    navBarIndex = index;
    emit(state.copyWith(status: RecipeStateStatus.changeIndex));
    return navBarIndex;
  }
  
  void initalizeFavoritiesIndexesOfDessert() {
    List<String>? sharedList = List.filled(10, 'false');
    emit(state.copyWith(
        status: RecipeStateStatus.initalizeFavoritiesIndexes,
        favoritiesRecipeDesColors: sharedList));
  }

  void initalizeFavoritiesIndexesOfVegatarian() {
    List<String>? sharedList = List.filled(10, 'false');
    emit(state.copyWith(
        status: RecipeStateStatus.initalizeFavoritiesIndexes,
        favoritiesRecipeVegColors: sharedList));
  }

  Future<void> getRecipeVegetarianElements() async {
    emit(state.copyWith(status: RecipeStateStatus.vegatrianLoading));
    try {
      final recipe = await _repository.getRecipeVegetarian();
      emit(state.copyWith(
          status: RecipeStateStatus.vegatrianSuccess,
          recipesOfVegatrian: recipe));
    } on Exception catch (exception) {
      emit(state.copyWith(
          status: RecipeStateStatus.vegatrianFailure, exception: exception));
    }
  }

  Future<void> getRecipeDessertElements() async {
    emit(state.copyWith(status: RecipeStateStatus.dessertLoading));
    try {
      final recipe = await _repository.getDessert();
      emit(state.copyWith(
          status: RecipeStateStatus.dessertSuccess, recipesOfDessert: recipe));
    } on Exception catch (exception) {
      emit(state.copyWith(
          status: RecipeStateStatus.dessertFailure, exception: exception));
    }
  }

  void settingFavoritiesItemsOfVegatarian(int index) {
    if (state.favoritiesRecipeVegColors![index] == 'false') {
      state.favoritiesRecipeVegColors![index] = 'true';
    } else {
      state.favoritiesRecipeVegColors![index] = 'false';
    }

    emit(state.copyWith(
      status: RecipeStateStatus.changefavoritiesRecipeVegColor,
      favoritiesRecipeVegColors: state.favoritiesRecipeVegColors,
    ));
  }

  void settingFavoritiesItemsOfDessert(int index) {
    if (state.favoritiesRecipeDesColors![index] == 'false') {
      state.favoritiesRecipeDesColors![index] = 'true';
    } else {
      state.favoritiesRecipeDesColors![index] = 'false';
    }
    emit(state.copyWith(
      status: RecipeStateStatus.changefavoritiesRecipeDesColor,
    ));
  }

  void addToFavorities(RecipeVegetarianOrDessert recipe) {
    // dataBox.add(recipe);
    emit(state.copyWith(status: RecipeStateStatus.refreshFavoritiesItems));
  }

  void deleteFromFavorities(RecipeVegetarianOrDessert recipe) {
    // dataBox.delete(recipe);
    emit(state.copyWith(status: RecipeStateStatus.refreshFavoritiesItems));
  }
}
