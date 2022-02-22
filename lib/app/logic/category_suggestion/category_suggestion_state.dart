part of 'category_suggestion_cubit.dart';

abstract class CategorySuggestionState extends Equatable {
  const CategorySuggestionState();

  @override
  List<Object> get props => [];
}

class CategorySuggestionEmpty extends CategorySuggestionState {}

class CategorySuggestionSelected extends CategorySuggestionState {
  final Category category;

  CategorySuggestionSelected(this.category);
}

class CategorySuggestionNoIdeas extends CategorySuggestionState {}
