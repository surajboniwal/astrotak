import 'package:astrotak/app/core/network_client.dart';
import 'package:astrotak/app/data/models/relative.dart';
import 'package:astrotak/app/data/response.dart';

abstract class BaseRelativeRepository {
  Future<ApiResponse<List<Relative>>> fetchRelatives();

  Future<ApiResponse<bool>> createRelative(Map<String, dynamic> data);

  Future<ApiResponse<bool>> deleteRelative(String id);
}

class RelativeRepository with NetworkClient implements BaseRelativeRepository {
  @override
  Future<ApiResponse<List<Relative>>> fetchRelatives() async {
    try {
      Response response = await client.get('/relative/all');

      if (response.data['data'] == null) {
        return ApiResponse.completed(List<Relative>.from([]));
      }

      return ApiResponse.completed(
          (response.data['data']['allRelatives'] as List).map((e) => Relative.fromMap(e)).toList());
    } on DioError catch (_) {
      return ApiResponse.error('Please try again after sometime');
    } catch (err) {
      print(err);
      return ApiResponse.error('Something went wrong');
    }
  }

  @override
  Future<ApiResponse<bool>> createRelative(Map<String, dynamic> data) async {
    try {
      await client.post('/relative', data: data);

      return ApiResponse.completed(true);
    } on DioError catch (_) {
      return ApiResponse.error('Please try again after sometime');
    } catch (_) {
      return ApiResponse.error('Something went wrong');
    }
  }

  @override
  Future<ApiResponse<bool>> deleteRelative(String id) async {
    try {
      await client.post('/relative/delete/$id');

      return ApiResponse.completed(true);
    } on DioError catch (_) {
      return ApiResponse.error('Please try again after sometime');
    } catch (_) {
      return ApiResponse.error('Something went wrong');
    }
  }
}
