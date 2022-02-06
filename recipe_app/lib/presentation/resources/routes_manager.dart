import 'package:flutter/material.dart';
import 'package:recipe_app/presentation/main%20screen/main_activity_screen.dart';

import 'package:recipe_app/presentation/splash/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String home = '/home';
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const MainActivityScreen());

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
