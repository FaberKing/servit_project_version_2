import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servit_project_version_2/features/services/domain/entities/services_entity.dart';
import 'package:servit_project_version_2/features/services/domain/usecases/search_services_usecase.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_services_event.dart';
part 'search_services_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class SearchServicesBloc extends Bloc<SearchServicesEvent, SearchServicesStateImpl> {
  final SearchServicesUseCase _useCase;
  SearchServicesBloc(this._useCase) : super(const SearchServicesStateImpl()) {
    on<OnGetSearchServices>(_getSearchedServices);
    on<OnResetSearchServices>(
      (event, emit) {
        emit(
          state.copyWith(
            status: SearchStatus.initial,
            hasReachedMax: false,
            message: '',
            query: '',
            services: <ServicesEntity>[],
          ),
        );
      },
    );
    on<OnChangesQuery>(
      (event, emit) {
        emit(
          state.copyWith(
            query: event.query,
          ),
        );
      },
    );
  }

  FutureOr<void> _getSearchedServices(
      OnGetSearchServices event, Emitter<SearchServicesStateImpl> emit) async {
    if (state.hasReachedMax) return;

    if (state.status == SearchStatus.initial) {
      final result = await _useCase(query: state.query);

      return result.fold(
        (failure) => emit(state.copyWith(status: SearchStatus.failure, message: failure.message)),
        (data) => data.length < 10
            ? emit(
                state.copyWith(status: SearchStatus.success, services: data, hasReachedMax: true),
              )
            : emit(
                state.copyWith(status: SearchStatus.success, services: data, hasReachedMax: false),
              ),
      );
    }

    final result = await _useCase(query: state.query, docId: state.services.last.id);

    result.fold(
      (failure) => emit(state.copyWith(status: SearchStatus.failure, message: failure.message)),
      (data) => data.isEmpty || data.length < 10
          ? emit(
              state.copyWith(hasReachedMax: true),
            )
          : emit(
              state.copyWith(
                  status: SearchStatus.success, services: List.of(state.services)..addAll(data)),
            ),
    );
  }
}
