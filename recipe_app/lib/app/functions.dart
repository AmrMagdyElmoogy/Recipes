import 'package:flutter/material.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';
import 'package:recipe_app/presentation/resources/value_manager.dart';

Widget noFavoritiesItem(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(
        Icons.favorite_outlined,
        color: Colors.red,
        size: ValuesManager.v50,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(StringsManager.noFavFirst,
          style: Theme.of(context).textTheme.headline5),
      const SizedBox(
        height: 5,
      ),
      Text(StringsManager.noFavSecond,
          style: Theme.of(context).textTheme.caption),
    ],
  );
}

String removeUnWantedWords(String s) {
  s.replaceAll(RegExp("<p>|</p>|<span>|</span>|<li>|</li>|<ol>|</ol>|"), "");
  return s;
}