import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servit_project_version_2/features/services/domain/entities/services_entity.dart';
import 'package:servit_project_version_2/features/services/domain/usecases/get_services_by_category_usecase.dart';

part 'services_by_category_event.dart';
part 'services_by_category_state.dart';

class ServicesByCategoryBloc extends Bloc<ServicesByCategoryEvent, ServicesByCategoryState> {
  final GetServicesByCategoryUseCase _useCase;
  ServicesByCategoryBloc(this._useCase) : super(ServicesByCategoryInitial()) {
    on<OnGetServiceByCategory>((event, emit) async {
      emit(ServicesByCategoryLoading());
      final result = await _useCase(category: event.category);
      result.fold(
        (failure) => emit(ServicesByCategoryFailure(failure.message)),
        (data) => emit(ServicesByCategoryLoaded(data)),
      );
    });
    on<OnResetServiceByCategory>((event, emit) {
      emit(ServicesByCategoryInitial());
    });
  }
}
