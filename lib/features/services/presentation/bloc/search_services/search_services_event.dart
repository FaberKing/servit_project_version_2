part of 'search_services_bloc.dart';

sealed class SearchServicesEvent extends Equatable {
  const SearchServicesEvent();

  @override
  List<Object> get props => [];
}

class OnGetSearchServices extends SearchServicesEvent {}

class OnResetSearchServices extends SearchServicesEvent {}

class OnChangesSearch extends SearchServicesEvent {
  final String query;

  const OnChangesSearch(this.query);

  @override
  List<Object> get props => [query];
}

class OnChangesCategory extends SearchServicesEvent {
  final String query;

  const OnChangesCategory(this.query);

  @override
  List<Object> get props => [query];
}

class OnChangesRating extends SearchServicesEvent {
  final String query;

  const OnChangesRating(this.query);

  @override
  List<Object> get props => [query];
}
