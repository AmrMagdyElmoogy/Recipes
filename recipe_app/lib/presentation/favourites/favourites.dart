import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/app/constants.dart';
import 'package:recipe_app/domain/bloc/Cubits/recipe_cubit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/main.dart';
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
    return ValueListenableBuilder(
      // Is it responsive to change to items in db?
        valueListenable: dataBox.listenable(),
        builder: (context, Box<RecipeVegetarianOrDessert> items, _) {
          return ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => FavoriteItem(
                    recipe: items.getAt(index)!,
                    index: index,
                    box : dataBox,
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    width: ValuesManager.v10,
                  ),
              itemCount: items.length);
        });
  }
}

class FavoriteItem extends StatelessWidget {
  final RecipeVegetarianOrDessert recipe;
  final int index;
  final Box box;
  const FavoriteItem({
    Key? key,
    required this.recipe,
    required this.index,
    required this.box,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(ValuesManager.v16),
              child: Hero(
                tag : recipe.id,
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

                                box.delete(recipe.id);
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
