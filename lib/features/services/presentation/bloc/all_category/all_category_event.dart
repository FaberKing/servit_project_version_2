part of 'all_category_bloc.dart';

sealed class AllCategoryEvent extends Equatable {
  const AllCategoryEvent();

  @override
  List<Object> get props => [];
}

class OnGetAllCategory extends AllCategoryEvent {}
