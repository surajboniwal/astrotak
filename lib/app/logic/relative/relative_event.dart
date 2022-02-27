part of 'relative_bloc.dart';

abstract class RelativeEvent extends Equatable {
  const RelativeEvent();
}

class LoadRelative extends RelativeEvent {
  @override
  List<Object?> get props => [];
}

class CreateRelative extends RelativeEvent {
  final Map<String, dynamic> data;

  CreateRelative(this.data);

  @override
  List<Object?> get props => [data];
}

class UpdateRelative extends RelativeEvent {
  final Map<String, dynamic> data;
  final String id;

  UpdateRelative(this.data, this.id);

  @override
  List<Object?> get props => [data, id];
}
