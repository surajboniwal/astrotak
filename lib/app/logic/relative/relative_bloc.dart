import 'package:astrotak/app/app.dart';
import 'package:astrotak/app/data/models/relative.dart';
import 'package:astrotak/app/data/repositories/relative_repository.dart';
import 'package:astrotak/app/data/response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'relative_event.dart';
part 'relative_state.dart';

class RelativeBloc extends Bloc<RelativeEvent, RelativeState> {
  final RelativeRepository relativeRepository;

  RelativeBloc(this.relativeRepository) : super(RelativeLoading()) {
    on<RelativeEvent>((event, emit) async {
      if (event is LoadRelative) {
        ApiResponse<List<Relative>> _relatives = await relativeRepository.fetchRelatives();

        if (_relatives.status == Status.ERROR) {
          emit(RelativeError(_relatives.message));
          return;
        }

        emit(RelativeLoaded(_relatives.data));
      }

      if (event is CreateRelative) {
        ApiResponse<bool> _response = await relativeRepository.createRelative(event.data);

        if (_response.status == Status.ERROR) {
          return;
        }

        ScaffoldMessenger.of(navigationKey.currentContext!).showSnackBar(SnackBar(content: Text('Relative added')));

        add(LoadRelative());
      }
    });
  }
}
