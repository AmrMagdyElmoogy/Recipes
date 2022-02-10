import 'package:dio/dio.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/app/extensions.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';

class AppClientManager {
  static Dio dio = Dio(BaseOptions(
    baseUrl: StringsManager.baseUrl,
  ));

  Future<List<dynamic>> getALlRecipesVegetarian() async {
    Response responce =
        await dio.get(StringsManager.endPointRandom, queryParameters: {
      'apiKey': StringsManager.apiKey,
      'tags': StringsManager.vegetarian,
      'number': StringsManager.numberOfRecipe,
    });
    //print(responce.data);
    return responce.data['recipes'];
  }

  Future<List<dynamic>> getALlRecipesDessert() async {
    Response responce =
        await dio.get(StringsManager.endPointRandom, queryParameters: {
      'apiKey': StringsManager.apiKey,
      'number': StringsManager.numberOfRecipe,
      'tags': StringsManager.dessert,
    });
    //print(responce.data);
    return responce.data['recipes'];
  }

  Future<List<dynamic>> getAllIngredientsMatches(String items) async {
    String searchedWords = "";
    searchedWords += items.toLower() + ",+";
    Response response = await dio
        .get(StringsManager.endPointFindByIngredient, queryParameters: {
      'apiKey': StringsManager.apiKey,
      'number': StringsManager.numberOfRecipe,
      'ranking': 1,
      'ingredients': searchedWords,
    });
    print(response.data);
    return response.data;
  }
}
