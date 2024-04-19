import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servit_project_version_2/features/services/domain/usecases/get_all_categories_usecase.dart';

part 'all_category_event.dart';
part 'all_category_state.dart';

class AllCategoryBloc extends Bloc<AllCategoryEvent, AllCategoryState> {
  final GetAllCategoriesUseCase _useCase;
  AllCategoryBloc(this._useCase) : super(AllCategoryInitial()) {
    on<OnGetAllCategory>((event, emit) async {
      emit(AllCategoryLoading());
      final result = await _useCase();
      result.fold(
        (failure) => emit(AllCategoryFailure(failure.message)),
        (data) => emit(AllCategoryLoaded(data)),
      );
    });
  }
}
