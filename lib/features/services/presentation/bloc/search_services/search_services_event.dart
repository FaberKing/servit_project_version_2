part of 'search_services_bloc.dart';

sealed class SearchServicesEvent extends Equatable {
  const SearchServicesEvent();

  @override
  List<Object> get props => [];
}

class OnGetSearchServices extends SearchServicesEvent {
  final String query;

  const OnGetSearchServices(this.query);

  @override
  List<Object> get props => [query];
}

class OnResetSearchServices extends SearchServicesEvent {}
