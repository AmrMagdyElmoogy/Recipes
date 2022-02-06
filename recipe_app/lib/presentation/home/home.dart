import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/domain/bloc/Cubits/main_activity_cubit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/presentation/home/vegetarian_layout.dart';
import 'package:recipe_app/presentation/resources/asset_manager.dart';
import 'package:recipe_app/presentation/resources/color_manager.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';
import 'package:recipe_app/presentation/resources/value_manager.dart';

import 'dessert_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ValuesManager.v16),
      child: BlocConsumer<MainActivityCubit, RecipeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringsManager.yourName,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black),
              ),
              spacer(),
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.selectedColor,
                  borderRadius: BorderRadius.circular(ValuesManager.v20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(ValuesManager.v16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringsManager.feelingBetter,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(
                              width: ValuesManager.v200,
                              child: Text(
                                StringsManager.encouragePhase,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      StringsManager.proteinGrames,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      StringsManager.protein,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: ValuesManager.v15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      StringsManager.noOfCalories,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      StringsManager.calories,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Image(
                          image: AssetImage(AssetManager.food),
                          fit: BoxFit.cover,
                          width: ValuesManager.v90,
                          height: ValuesManager.v90,
                        ),
                      ]),
                ),
              ),
              spacer(),
              Text(
                StringsManager.category,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black),
              ),
              spacer(),
              Expanded(
                child: DefaultTabController(
                  length: ValuesManager.vElevation.toInt(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonsTabBar(
                        backgroundColor: Colors.black,
                        buttonMargin: const EdgeInsets.all(ValuesManager.v10),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: ValuesManager.v15),
                        height: ValuesManager.v60,
                        unselectedBackgroundColor:
                            Colors.grey[ValuesManager.v200.toInt()],
                        unselectedLabelStyle:
                            Theme.of(context).textTheme.headline5,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white),
                        radius: ValuesManager.v100,
                        tabs: const [
                          Tab(
                            text: StringsManager.vegetarianTab,
                          ),
                          Tab(
                            text: StringsManager.dessertTab,
                          ),
                        ],
                      ),
                      Text(
                        StringsManager.popularRecipes,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black),
                      ),
                      const Expanded(
                        child: TabBarView(children: [
                          VegetarianLayout(),
                          DessertLayout(),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget spacer() {
    return const SizedBox(
      height: ValuesManager.v10,
    );
  }
}
// (RenderFlex children have non-zero flex but incoming height constraints are unbounded.
// When a column is in a parent that does not provide a finite height constraint, for example if it is in a vertical scrollable, it will try to shrink-wrap its children along the vertical axis. Setting a flex on a child (e.g. using Expanded)
