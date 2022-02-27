import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/presentation/resources/asset_manager.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';

final List<NutrientInfo> items = [
    NutrientInfo(
        image: AssetManager.carbs, value: '65g', kind: StringsManager.carbs),
    NutrientInfo(
        image: AssetManager.protein,
        value: '27g',
        kind: StringsManager.protein),
    NutrientInfo(
      image: AssetManager.calories,
      value: '120',
      kind: StringsManager.calories,
    ),
    NutrientInfo(
      image: AssetManager.fat,
      value: '91g',
      kind: StringsManager.fat,
    ),
  ];

const String DBName = "FavoritiesDB";
