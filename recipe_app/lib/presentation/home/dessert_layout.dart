import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/domain/bloc/Cubits/main_activity_cubit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';
import 'package:recipe_app/presentation/resources/value_manager.dart';

class DessertLayout extends StatefulWidget {
  const DessertLayout({Key? key}) : super(key: key);

  @override
  _DessertLayoutState createState() => _DessertLayoutState();
}

class _DessertLayoutState extends State<DessertLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainActivityCubit, RecipeStates>(
      listener: (context, state) {
        if (state.status == RecipeStateStatus.vegatrianLoading ||
            state.status == RecipeStateStatus.dessertLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      builder: (context, state) {
        MainActivityCubit cubit = BlocProvider.of<MainActivityCubit>(context);
        return state.recipesOfDessert!.isNotEmpty
            ? ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => DessertItem(
                      recipe: state.recipesOfDessert![index],
                      cubit: cubit,
                      state: state,
                      index: index,
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
  final MainActivityCubit cubit;
  final RecipeStates state;
  const DessertItem(
      {Key? key,
      required this.recipe,
      required this.index,
      required this.cubit,
      required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: ValuesManager.v250,
          height: ValuesManager.v280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ValuesManager.v16),
            image: DecorationImage(
                image: NetworkImage(recipe.img), fit: BoxFit.cover),
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
                            cubit.settingFavoritiesItemsOfDessert(index);
                            if (state.favoritiesRecipeDesColors![index] ==
                                StringsManager.trueString) {
                              cubit.addToFavorities(recipe);
                            } else {
                              cubit.deleteFromFavorities(recipe);
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
