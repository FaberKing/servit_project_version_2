import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servit_project_version_2/features/services/domain/entities/services_entity.dart';
import 'package:servit_project_version_2/features/services/domain/usecases/get_all_services_usecase.dart';
import 'package:stream_transform/stream_transform.dart';

part 'all_services_event.dart';
part 'all_services_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class AllServicesBloc extends Bloc<AllServicesEvent, AllServicesStateImpl> {
  final GetAllServicesUseCase _useCase;
  AllServicesBloc(this._useCase) : super(const AllServicesStateImpl()) {
    on<OnGetAllServices>(
      _onGetAllServices,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  FutureOr<void> _onGetAllServices(OnGetAllServices event, Emitter<AllServicesState> emit) async {
    if (state.hasReachedMax) return;

    if (state.status == ServicesStatus.initial) {
      final result = await _useCase();

      return result.fold(
        (failure) => emit(state.copyWith(status: ServicesStatus.failure, message: failure.message)),
        (data) => data.length < 10
            ? emit(
                state.copyWith(status: ServicesStatus.success, services: data, hasReachedMax: true),
              )
            : emit(
                state.copyWith(
                    status: ServicesStatus.success, services: data, hasReachedMax: false),
              ),
      );
    }

    final result = await _useCase(docId: state.services.last.id);

    result.fold(
      (failure) => emit(state.copyWith(status: ServicesStatus.failure, message: failure.message)),
      (data) => data.isEmpty || data.length < 10
          ? emit(
              state.copyWith(hasReachedMax: true),
            )
          : emit(
              state.copyWith(
                  status: ServicesStatus.success, services: List.of(state.services)..addAll(data)),
            ),
    );
  }
}
