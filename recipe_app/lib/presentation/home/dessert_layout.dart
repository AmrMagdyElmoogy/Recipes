import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/domain/bloc/Cubits/recipe_cubit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/presentation/resources/routes_manager.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';
import 'package:recipe_app/presentation/resources/value_manager.dart';

import '../../app/constants.dart';

class DessertLayout extends StatefulWidget {
  const DessertLayout({Key? key}) : super(key: key);

  @override
  _DessertLayoutState createState() => _DessertLayoutState();
}

class _DessertLayoutState extends State<DessertLayout> {
 
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeStates>(
      listener: (context, state) {
        if (state.status == RecipeStateStatus.vegatrianLoading ||
            state.status == RecipeStateStatus.dessertLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      builder: (context, state) {
        RecipeCubit cubit = BlocProvider.of<RecipeCubit>(context);
        return state.recipesOfDessert!.isNotEmpty
            ? ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => DessertItem(
                      recipe: state.recipesOfDessert![index],
                      cubit: cubit,
                      state: state,
                      index: index,
                      box: dataBox,
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      width: ValuesManager.v10,
                    ),
                itemCount: state.recipesOfDessert!.length)
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class DessertItem extends StatelessWidget {
  final RecipeVegetarianOrDessert recipe;
  final int index;
  final RecipeCubit cubit;
  final RecipeStates state;
  final Box box;
  const DessertItem(
      {Key? key,
      required this.recipe,
      required this.index,
      required this.cubit,
      required this.state,
      required this.box})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(Routes.ingredient, arguments: recipe);
          },
          child: Hero(
            tag: recipe.id,
            child: Container(
              width: ValuesManager.v250,
              height: ValuesManager.v280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ValuesManager.v16),
                image: DecorationImage(
                    image: NetworkImage(recipe.img), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: ValuesManager.v10,
          child: Padding(
            padding: const EdgeInsets.all(ValuesManager.v10),
            child: Container(
              width: ValuesManager.v230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ValuesManager.v16),
                color: Colors.blueGrey.withOpacity(ValuesManager.vOpicity),
              ),
              child: Padding(
                padding: const EdgeInsets.all(ValuesManager.v16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: ValuesManager.v10),
                    Row(
                      children: [
                        Text(
                          StringsManager.caloriesOfRecipe,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          StringsManager.dot,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          recipe.readyInMinutes.toString() +
                              StringsManager.plusMinutes,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: ValuesManager.v5),
                        IconButton(
                          iconSize: ValuesManager.v30,
                          onPressed: () {
                            if (state.favoritiesRecipeDesColors![index] ==
                                StringsManager.trueString) {
                                  box.add(recipe);
                              cubit.settingFavoritiesItemsOfDessert(index);
                            } else {
                              box.delete(recipe);
                              cubit.settingFavoritiesItemsOfDessert(index);
                            }
                          },
                          icon: state.favoritiesRecipeDesColors![index] ==
                                  StringsManager.falseString
                              ? const Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.red,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
