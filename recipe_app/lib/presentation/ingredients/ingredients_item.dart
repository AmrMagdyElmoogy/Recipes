import 'package:flutter/material.dart';
import 'package:recipe_app/app/extensions.dart';
import 'package:recipe_app/app/functions.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/app/constants.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';
import 'package:recipe_app/presentation/resources/value_manager.dart';

class IngredientItem extends StatelessWidget {
  final RecipeVegetarianOrDessert recipe;
  const IngredientItem({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BuildSliverAppBar(recipe: recipe),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: ValuesManager.v20, horizontal: ValuesManager.v16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ValuesManager.v20),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: ValuesManager.v250,
                          child: Text(
                            recipe.title,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          recipe.readyInMinutes.toString() +
                              StringsManager.plusMinutes,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    whiteSpaceHeight(ValuesManager.v5),
                    Text(
                      StringsManager.descriptionOfReicpe,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.grey),
                    ),
                    whiteSpaceHeight(ValuesManager.v10),
                    SizedBox(
                      height: ValuesManager.v140,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => NutrientsInfoItem(
                                item: items[index],
                                index: index,
                              ),
                          separatorBuilder: (context, indext) =>
                              whiteSpaceWidth(ValuesManager.v5),
                          itemCount: items.length),
                    ),
                    whiteSpaceHeight(ValuesManager.v10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringsManager.ingredients,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          recipe.ingredient.length.toString() +
                              StringsManager.item,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => IngredientsItems(
                            ingredient: recipe.ingredient, index: index),
                        separatorBuilder: (context, index) =>
                            whiteSpaceHeight(ValuesManager.v10),
                        itemCount: recipe.ingredient.length),
                    whiteSpaceHeight(ValuesManager.v10),
                    Text(
                      StringsManager.instructions,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.black),
                    ),
                    whiteSpaceHeight(ValuesManager.v5),
                    Text(
                      recipe.instructions,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ])),
        ],
      ),
    );
  }
}

class BuildSliverAppBar extends StatelessWidget {
  final RecipeVegetarianOrDessert recipe;
  const BuildSliverAppBar({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: ValuesManager.v500,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: recipe.id,
          child: Image(image: NetworkImage(recipe.img), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class NutrientsInfoItem extends StatelessWidget {
  final NutrientInfo item;
  final int index;
  const NutrientsInfoItem({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   height: ValuesManager.v100,
        //   width: ValuesManager.v75,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(ValuesManager.v20),
        //     border: Border.all(
        //       color: Colors.blueGrey,
        //       width: ValuesManager.v75,
        //     ),
        //   ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Image(
        //         width: ValuesManager.v30,
        //         height: ValuesManager.v30,
        //         image: AssetImage(item.image),
        //         fit: BoxFit.cover),
        //     whiteSpaceHeight(ValuesManager.v10),
        //     Text(
        //       item.value,
        //       style: Theme.of(context). textTheme.headline6,
        //     ),
        //   ],
        // ),
        Text('Is error here?'),

        // Center(
        //   child: Text(item.kind, style: Theme.of(context).textTheme.bodyText1),
        // ),
      ],
    );
  }
}

class IngredientsItems extends StatelessWidget {
  final List<Ingredients> ingredient;
  final int index;
  const IngredientsItems(
      {Key? key, required this.ingredient, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          ingredient[index].nameClean.capitalize(),
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.w200),
        ),
        Text(
          ingredient[index].amount.toString() + " " + ingredient[index].unit,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
