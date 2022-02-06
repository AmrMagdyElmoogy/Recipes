import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/app/functions.dart';
import 'package:recipe_app/domain/bloc/Cubits/main_activity_cubit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/presentation/resources/font_manager.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';
import 'package:recipe_app/presentation/resources/value_manager.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainActivityCubit, RecipeStates>(
      listener: (context, state) {
        if (MainActivityCubit().favorities.isEmpty) {
          noFavoritiesItem(context);
        }
      },
      builder: (context, state) {
        MainActivityCubit cubit = BlocProvider.of<MainActivityCubit>(context);
        return ListView.separated(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => FavoriteItem(
                  recipe: cubit.favorities[index],
                  index: index,
                  cubit: cubit,
                  state: state,
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  width: ValuesManager.v10,
                ),
            itemCount: cubit.favorities.length);
      },
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final RecipeVegetarianOrDessert recipe;
  final int index;
  final MainActivityCubit cubit;
  final RecipeStates state;
  const FavoriteItem(
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
        Padding(
          padding: const EdgeInsets.all(ValuesManager.v16),
          child: Container(
            width: double.infinity,
            height: ValuesManager.v200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ValuesManager.v16),
              image: DecorationImage(
                  image: NetworkImage(recipe.img), fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          bottom: ValuesManager.v5,
          child: Padding(
            padding: const EdgeInsets.all(ValuesManager.v30),
            child: Container(
              width: ValuesManager.v300,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringsManager.caloriesOfRecipe +
                              StringsManager.dot +
                              recipe.readyInMinutes.toString() +
                              StringsManager.plusMinutes,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.white),
                        ),
                        IconButton(
                          iconSize: ValuesManager.v30,
                          onPressed: () {
                            //Pass state and cubit as parameters
                            if (state.favoritiesRecipeVegColors![index] ==
                                StringsManager.falseString) {
                              cubit.settingFavoritiesItemsOfVegatarian(index);
                            } else if (state
                                    .favoritiesRecipeDesColors![index] ==
                                StringsManager.trueString) {
                              cubit.settingFavoritiesItemsOfDessert(index);
                            }
                            cubit.deleteFromFavorities(recipe);
                          },
                          icon: const Icon(
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
