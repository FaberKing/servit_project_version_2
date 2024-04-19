part of 'all_category_bloc.dart';

sealed class AllCategoryState extends Equatable {
  const AllCategoryState();

  @override
  List<Object> get props => [];
}

final class AllCategoryInitial extends AllCategoryState {}

final class AllCategoryLoading extends AllCategoryState {}

final class AllCategoryFailure extends AllCategoryState {
  final String message;

  const AllCategoryFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class AllCategoryLoaded extends AllCategoryState {
  final List<Map<String, dynamic>> data;

  const AllCategoryLoaded(this.data);
}
