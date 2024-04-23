part of 'search_services_bloc.dart';

sealed class SearchServicesEvent extends Equatable {
  const SearchServicesEvent();

  @override
  List<Object> get props => [];
}

class OnGetSearchServices extends SearchServicesEvent {}

class OnResetSearchServices extends SearchServicesEvent {}

class OnChangesQuery extends SearchServicesEvent {
  final String query;

  const OnChangesQuery(this.query);

  @override
  List<Object> get props => [query];
}
