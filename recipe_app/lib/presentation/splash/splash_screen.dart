import 'package:flutter/material.dart';
import 'package:recipe_app/presentation/resources/asset_manager.dart';

import 'package:recipe_app/presentation/resources/routes_manager.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';
import 'package:recipe_app/presentation/resources/value_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(ValuesManager.vOpicity),
                    BlendMode.dstATop),
                image: const AssetImage(AssetManager.splashImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: ValuesManager.v16),
                child: Text(
                  StringsManager.splashTextHeadline,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ValuesManager.v30, vertical: ValuesManager.v10),
                child: Text(
                  StringsManager.splashSubtitle,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 70, top: 30),
                child: Container(
                  width: ValuesManager.v200,
                  height: ValuesManager.v60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(ValuesManager.v50),
                        ),
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(Routes.home);
                      },
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: ValuesManager.v20,
                            child: Image(
                                image: AssetImage(AssetManager.splashArrow),
                                width: ValuesManager.v20,
                                height: ValuesManager.v20),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            StringsManager.splashTextGetStarting,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
