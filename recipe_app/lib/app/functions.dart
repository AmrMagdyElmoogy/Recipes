import 'package:camera/camera.dart';
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
        Icons.error_outline_rounded,
        color: Colors.blueGrey,
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
  s.replaceAll(RegExp(r'<'), 'p');
  s.replaceAll(RegExp(r">"), "");
  s.replaceAll(RegExp(r"/"), "");
  s.replaceAll(RegExp(r"ol"), "");
  s.replaceAll(RegExp(r"li"), "");
  s.replaceAll(RegExp(r"p"), "");
  s.replaceAll(RegExp(r"span"), "");
  return s;
}

Widget whiteSpaceWidth(double width) {
  return SizedBox(width: width);
}

Widget whiteSpaceHeight(double height) {
  return SizedBox(height: height);
}

String prepareInitialUrlWebView(List<String> a)
{ 
  String result = "";
  for(int i=0; i<a.length; i++)
  {
    result+= a[i];
  } 
  return result;
}

