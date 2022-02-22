import 'package:astrotak/app/data/models/location.dart';
import 'package:astrotak/app/data/repositories/location_repository.dart';
import 'package:astrotak/app/data/response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'location_search_state.dart';

class LocationSearchCubit extends Cubit<LocationSearchState> {
  final LocationRepostirory locationRepostirory;

  LocationSearchCubit(this.locationRepostirory) : super(LocationSearchEmpty());

  Future<void> searchLocation(String query) async {
    ApiResponse<List<Location>> _location = await locationRepostirory.fetchLocation(query);

    if (_location.status == Status.ERROR) {
      emit(LocationSearchEmpty());
      return;
    }

    emit(LocationSearchData(_location.data));
  }
}
