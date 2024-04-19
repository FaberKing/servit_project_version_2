part of 'services_by_category_bloc.dart';

sealed class ServicesByCategoryState extends Equatable {
  const ServicesByCategoryState();

  @override
  List<Object> get props => [];
}

final class ServicesByCategoryInitial extends ServicesByCategoryState {}

final class ServicesByCategoryLoading extends ServicesByCategoryState {}

final class ServicesByCategoryFailure extends ServicesByCategoryState {
  final String message;

  const ServicesByCategoryFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class ServicesByCategoryLoaded extends ServicesByCategoryState {
  final List<ServicesEntity> data;

  const ServicesByCategoryLoaded(this.data);

  @override
  List<Object> get props => [data];
}
