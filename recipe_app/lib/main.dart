import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/app/app_perfs.dart';
import 'package:recipe_app/domain/bloc/Cubits/main_activity_cubit.dart';
import 'package:recipe_app/domain/bloc/bloc_observer.dart';
import 'package:recipe_app/presentation/home/home.dart';
import 'package:recipe_app/presentation/resources/routes_manager.dart';
import 'package:recipe_app/presentation/resources/theme_manager.dart';
import 'package:recipe_app/presentation/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPerfs.init();
  // BlocOverrides.runZoned(
  //   () {
  //     // Use cubits...
  //   },
  //   blocObserver: MyBlocObserver(),
  // );
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
            create: (_) => MainActivityCubit()
              ..getRecipeVegetarianElements()
              ..getRecipeDessertElements()
              ..initalizeFavoritiesIndexesOfVegatarian()
              ..initalizeFavoritiesIndexesOfDessert(),
            child: const HomeScreen(),
          ),
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
