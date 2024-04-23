part of 'all_services_bloc.dart';

enum ServicesStatus { initial, success, failure }

sealed class AllServicesState extends Equatable {
  const AllServicesState();

  @override
  List<Object> get props => [];
}

final class AllServicesStateImpl extends AllServicesState {
  final ServicesStatus status;
  final List<ServicesEntity> services;
  final bool hasReachedMax;
  final String message;

  const AllServicesStateImpl({
    this.status = ServicesStatus.initial,
    this.services = const <ServicesEntity>[],
    this.hasReachedMax = false,
    this.message = 'empty',
  });

  AllServicesStateImpl copyWith({
    ServicesStatus? status,
    List<ServicesEntity>? services,
    bool? hasReachedMax,
    String? message,
  }) {
    return AllServicesStateImpl(
      status: status ?? this.status,
      services: services ?? this.services,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''AllServicesState { status: $status, hasReachedMax: $hasReachedMax, services: ${services.length} }''';
  }

  @override
  List<Object> get props => [status, services, hasReachedMax, message];
}
