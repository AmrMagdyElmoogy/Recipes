import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/presentation/ingredients/ingredients_item.dart';
import 'package:recipe_app/presentation/main%20screen/main_activity_screen.dart';

import 'package:recipe_app/presentation/splash/splash_screen.dart';
import 'package:recipe_app/presentation/take_picture/take_picture_view.dart';
import 'package:recipe_app/presentation/web_view_search/web_view_search.dart';

class Routes {
  static const String splashScreen = '/';
  static const String home = '/home';
  static const String ingredient = '/ingredient';
  static const String cameraView = '/camera';
  static const String searchWebView = '/webView';
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const MainActivityScreen());
      case Routes.cameraView:
        var args = settings.arguments as CameraDescription;
        return MaterialPageRoute(
            builder: (_) => TakePictureView(
                  camera: args,
                ));
      case Routes.ingredient:
        var args = settings.arguments as RecipeVegetarianOrDessert;
        return MaterialPageRoute(builder: (_) => IngredientItem(recipe: args));
      case Routes.searchWebView:
        var args = settings.arguments as List<String>;
        return MaterialPageRoute(
            builder: (_) => WebViewSearch(expectedLables: args));
      default:
        return unDefainedRoute();
    }
  }

  static Route<dynamic> unDefainedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Not Found!'),
              ),
              body: const Center(child: Text('Not Found!')),
            ));
  }
}
