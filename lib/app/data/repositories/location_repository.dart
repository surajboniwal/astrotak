import 'package:astrotak/app/core/network_client.dart';
import 'package:astrotak/app/data/models/location.dart';
import 'package:astrotak/app/data/response.dart';

abstract class BaseLocationRepository {
  Future<ApiResponse<List<Location>>> fetchLocation(String query);
}

class LocationRepostirory extends BaseLocationRepository with NetworkClient {
  @override
  Future<ApiResponse<List<Location>>> fetchLocation(String query) async {
    try {
      Response response = await client.get('/location/place?inputPlace=$query');

      return ApiResponse.completed((response.data['data'] as List).map((e) => Location.fromMap(e)).toList());
    } on DioError catch (_) {
      return ApiResponse.error('Please try again after sometime');
    } catch (_) {
      return ApiResponse.error('Something went wrong');
    }
  }
}
