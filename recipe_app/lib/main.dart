import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app/app/app_perfs.dart';
import 'package:recipe_app/app/constants.dart';
import 'package:recipe_app/domain/bloc/Cubits/activity_cubit.dart';
import 'package:recipe_app/domain/bloc/Cubits/camera_cubit.dart';
import 'package:recipe_app/domain/bloc/Cubits/recipe_cubit.dart';
import 'package:recipe_app/domain/bloc/Cubits/search_cubit.dart';
import 'package:recipe_app/presentation/activity/activity.dart';
import 'package:recipe_app/presentation/home/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/presentation/resources/routes_manager.dart';
import 'package:recipe_app/presentation/resources/theme_manager.dart';
import 'package:recipe_app/presentation/search/search_ingredient.dart';
import 'package:recipe_app/presentation/splash/splash_screen.dart';
import 'package:recipe_app/presentation/take_picture/take_picture_view.dart';

import 'domain/models/models.dart';

late Box<RecipeVegetarianOrDessert> dataBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPerfs.init();
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeVegetarianOrDessertAdapter());
  Hive.registerAdapter(IngredientsAdapter());
  dataBox = await Hive.openBox(DBName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (_) => RecipeCubit()
              ..getRecipeVegetarianElements()
              ..getRecipeDessertElements()
              ..initalizeFavoritiesIndexesOfVegatarian()
              ..initalizeFavoritiesIndexesOfDessert(),
            child: const HomeScreen(),
          ),
          BlocProvider(
              create: (_) => SearchCubit(), child: const SearchIngredient()),
          BlocProvider(
              create: (_) => CameraCubit(), child: const TakePictureView()),
          BlocProvider(
            create: (_) => ActivityCubit(),
            child: const Activity(),
          )
        ],
        child: MaterialApp(
          theme: light,
          onGenerateRoute: RoutesGenerator.getRoute,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splashScreen,
          home: const SplashScreen(),
        ));
  }
}
