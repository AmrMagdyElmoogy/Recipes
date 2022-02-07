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
                          width: 250,
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
                    whiteSpaceHeight(5),
                    Text(
                      StringsManager.descriptionOfReicpe,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.grey),
                    ),
                    whiteSpaceHeight(10),
                    // SizedBox(
                    //   width: 250,
                    //   child: ListView.separated(
                    //       scrollDirection: Axis.horizontal,
                    //       itemBuilder: (context, index) => NutrientsInfoItem(
                    //             items: items,
                    //             index: index,
                    //           ),
                    //       separatorBuilder: (context, indext) =>
                    //           whiteSpaceWidth(5),
                    //       itemCount: items.length),
                    // ),
                    whiteSpaceHeight(10),
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
                    whiteSpaceHeight(5),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => IngredientsItems(
                            ingredient: recipe.ingredient, index: index),
                        separatorBuilder: (context, index) =>
                            whiteSpaceHeight(10),
                        itemCount: recipe.ingredient.length),
                    whiteSpaceHeight(5),
                    Text(
                      StringsManager.instructions,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.black),
                    ),
                    whiteSpaceHeight(5),
                    Text(
                      removeUnWantedWords(recipe.instructions),
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

  Widget whiteSpaceWidth(double width) {
    return SizedBox(width: width);
  }

  Widget whiteSpaceHeight(double height) {
    return SizedBox(height: height);
  }
}

class BuildSliverAppBar extends StatelessWidget {
  final RecipeVegetarianOrDessert recipe;
  const BuildSliverAppBar({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 500,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        // title: Text(
        //   'Ingredients',
        //   style: Theme.of(context).textTheme.headline6,
        // ),
        background: Hero(
          tag: recipe.id,
          child: Image(image: NetworkImage(recipe.img), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class NutrientsInfoItem extends StatelessWidget {
  final List<NutrientInfo> items;
  final int index;
  const NutrientsInfoItem({Key? key, required this.items, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 100,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ValuesManager.v20),
              border: Border.all(
                color: Colors.blueGrey,
                width: 0.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    width: ValuesManager.v20,
                    height: ValuesManager.v20,
                    image: AssetImage(items[index].image),
                    fit: BoxFit.cover),
                Text(
                  items[index].value,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          Center(
            child: Text(items[index].kind,
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
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


