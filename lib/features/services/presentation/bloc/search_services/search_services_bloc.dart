import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servit_project_version_2/features/services/domain/entities/services_entity.dart';
import 'package:servit_project_version_2/features/services/domain/usecases/search_services_usecase.dart';

part 'search_services_event.dart';
part 'search_services_state.dart';

class SearchServicesBloc extends Bloc<SearchServicesEvent, SearchServicesState> {
  final SearchServicesUseCase _useCase;
  SearchServicesBloc(this._useCase) : super(SearchServicesInitial()) {
    on<OnGetSearchServices>(
      (event, emit) async {
        emit(SearchServicesLoading());
        final result = await _useCase(query: event.query);
        result.fold(
          (failure) => emit(SearchServicesFailure(failure.message)),
          (data) => emit(SearchServicesLoaded(data)),
        );
      },
    );
    on<OnResetSearchServices>(
      (event, emit) {
        emit(SearchServicesInitial());
      },
    );
  }
}
