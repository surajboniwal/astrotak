import 'package:astrotak/app/core/network_client.dart';
import 'package:astrotak/app/data/models/category.dart';
import 'package:astrotak/app/data/response.dart';

abstract class BaseQuestionRepository {
  Future<ApiResponse<List<Category>>> fetchCategories();
}

class QuestionRepository with NetworkClient implements BaseQuestionRepository {
  @override
  Future<ApiResponse<List<Category>>> fetchCategories() async {
    try {
      Response response = await client.get('/question/category/all');

      return ApiResponse.completed((response.data['data'] as List).map((e) => Category.fromMap(e)).toList());
    } on DioError catch (_) {
      return ApiResponse.error('Please try again after sometime');
    } catch (_) {
      return ApiResponse.error('Something went wrong');
    }
  }
}
