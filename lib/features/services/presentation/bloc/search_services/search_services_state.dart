part of 'search_services_bloc.dart';

sealed class SearchServicesState extends Equatable {
  const SearchServicesState();

  @override
  List<Object> get props => [];
}

final class SearchServicesInitial extends SearchServicesState {}

final class SearchServicesLoading extends SearchServicesState {}

final class SearchServicesFailure extends SearchServicesState {
  final String message;

  const SearchServicesFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class SearchServicesLoaded extends SearchServicesState {
  final List<ServicesEntity> data;

  const SearchServicesLoaded(this.data);

  @override
  List<Object> get props => [data];
}
