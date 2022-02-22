part of 'location_search_cubit.dart';

abstract class LocationSearchState extends Equatable {
  const LocationSearchState();
}

class LocationSearchEmpty extends LocationSearchState {
  @override
  List<Object?> get props => [];
}

class LocationSearchData extends LocationSearchState {
  final List<Location> data;

  LocationSearchData(this.data);

  @override
  List<Object?> get props => [data];
}
