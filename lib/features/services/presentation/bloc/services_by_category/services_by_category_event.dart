part of 'services_by_category_bloc.dart';

sealed class ServicesByCategoryEvent extends Equatable {
  const ServicesByCategoryEvent();

  @override
  List<Object> get props => [];
}

class OnGetServiceByCategory extends ServicesByCategoryEvent {
  final String category;

  const OnGetServiceByCategory(this.category);

  @override
  List<Object> get props => [category];
}

class OnResetServiceByCategory extends ServicesByCategoryEvent {}
