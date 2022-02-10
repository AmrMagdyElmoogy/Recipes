import 'package:bloc/bloc.dart';
import 'package:recipe_app/data/network/app_api.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/domain/repository/repository.dart';

class SearchCubit extends Cubit<IngredientSearchStates> {
  SearchCubit()
      : super(IngredientSearchStates(status: IngredientSearchStatus.inital));

  final RepositoryImplementation _repository =
      RepositoryImplementation(AppClientManager());

  Future<void> search(String items) async {
    emit(IngredientSearchStates(status: IngredientSearchStatus.loading));
    try {
      final list = await _repository.searchIngredient(items);
      emit(state.copyWith(status: IngredientSearchStatus.success, items: list));
    } on Exception catch (exception) {
      emit(state.copyWith(
          status: IngredientSearchStatus.failure, exception: exception));
    }
  }
}
