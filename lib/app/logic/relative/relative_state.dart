part of 'relative_bloc.dart';

abstract class RelativeState extends Equatable {
  const RelativeState();
}

class RelativeLoading extends RelativeState {
  @override
  List<Object?> get props => [];
}

class RelativeLoaded extends RelativeState {
  final List<Relative> data;

  RelativeLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class RelativeError extends RelativeState {
  final String message;

  RelativeError(this.message);
  @override
  List<Object?> get props => [message];
}

class RelativeAdded extends RelativeState {
  @override
  List<Object?> get props => [];
}
