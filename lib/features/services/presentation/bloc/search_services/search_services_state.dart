part of 'search_services_bloc.dart';

enum SearchStatus { initial, success, failure }

sealed class SearchServicesState extends Equatable {
  const SearchServicesState();

  @override
  List<Object> get props => [];
}

final class SearchServicesStateImpl extends SearchServicesState {
  final SearchStatus status;
  final List<ServicesEntity> services;
  final bool hasReachedMax;
  final String query;
  final String message;

  const SearchServicesStateImpl({
    this.status = SearchStatus.initial,
    this.services = const <ServicesEntity>[],
    this.hasReachedMax = false,
    this.query = '',
    this.message = 'empty',
  });

  SearchServicesStateImpl copyWith({
    SearchStatus? status,
    List<ServicesEntity>? services,
    bool? hasReachedMax,
    String? query,
    String? message,
  }) {
    return SearchServicesStateImpl(
      status: status ?? this.status,
      services: services ?? this.services,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      query: query ?? this.query,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''AllServicesState { status: $status, hasReachedMax: $hasReachedMax, services: ${services.length} , query: $query}''';
  }

  @override
  List<Object> get props => [status, services, hasReachedMax, query, message];
}
