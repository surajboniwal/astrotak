import 'package:astrotak/app/data/models/category.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_suggestion_state.dart';

class CategorySuggestionCubit extends Cubit<CategorySuggestionState> {
  CategorySuggestionCubit() : super(CategorySuggestionEmpty());

  void selectCategory([Category? category]) {
    if (category == null) {
      emit(CategorySuggestionEmpty());
    } else {
      if (category.suggestions.length == 0) {
        emit(CategorySuggestionNoIdeas());
      } else {
        emit(CategorySuggestionSelected(category));
      }
    }
  }
}
