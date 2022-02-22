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
