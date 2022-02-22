import 'package:astrotak/app/data/models/category.dart';
import 'package:astrotak/app/data/repositories/question_repository.dart';
import 'package:astrotak/app/data/response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final QuestionRepository questionRepository;

  CategoryBloc(this.questionRepository) : super(CategoryLoading()) {
    on<CategoryEvent>((event, emit) async {
      //Initial event
      if (event is LoadCategories) {
        emit(CategoryLoading());
        ApiResponse<List<Category>> _categories = await questionRepository.fetchCategories();

        if (_categories.status == Status.ERROR) {
          emit(CategoryError(_categories.message));
          return;
        }

        emit(CategoryLoaded(_categories.data));
      }
    });
  }
}
