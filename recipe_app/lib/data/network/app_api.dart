import 'package:dio/dio.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';

class AppClientManager {
  static Dio dio = Dio(BaseOptions(
    baseUrl: StringsManager.baseUrl,
  ));

  Future<List<dynamic>> getALlRecipesVegetarian() async {
    Response responce =
        await dio.get(StringsManager.endPoint, queryParameters: {
      'apiKey': StringsManager.apiKey,
      'tags': StringsManager.vegetarian,
      'number': StringsManager.numberOfRecipe,
    });
    //print(responce.data);
    return responce.data['recipes'];
  }

  Future<List<dynamic>> getALlRecipesDessert() async {
    Response responce =
        await dio.get(StringsManager.endPoint, queryParameters: {
      'apiKey': StringsManager.apiKey,
      'number': StringsManager.numberOfRecipe,
      'tags': StringsManager.dessert,
    });
    //print(responce.data);
    return responce.data['recipes'];
  }
}
