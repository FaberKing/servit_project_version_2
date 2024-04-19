part of 'all_services_bloc.dart';

enum ServicesStatus { initial, success, failure }

sealed class AllServicesState extends Equatable {
  const AllServicesState();

  @override
  List<Object> get props => [];
}

final class AllServicesStatePro extends AllServicesState {
  final ServicesStatus status;
  final List<ServicesEntity> services;
  final bool hasReachedMax;
  final String message;

  const AllServicesStatePro({
    this.status = ServicesStatus.initial,
    this.services = const <ServicesEntity>[],
    this.hasReachedMax = false,
    this.message = 'empty',
  });

  AllServicesStatePro copyWith({
    ServicesStatus? status,
    List<ServicesEntity>? services,
    bool? hasReachedMax,
    String? message,
  }) {
    return AllServicesStatePro(
        status: status ?? this.status,
        services: services ?? this.services,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        message: message ?? this.message);
  }

  @override
  String toString() {
    return '''AllServicesState { status: $status, hasReachedMax: $hasReachedMax, services: ${services.length} }''';
  }

  @override
  List<Object> get props => [status, services, hasReachedMax, message];
}

// final class AllServicesLoading extends AllServicesState {}

// final class AllServicesFailure extends AllServicesState {
//   final String message;

//   const AllServicesFailure(this.message);

//   @override
//   List<Object> get props => [message];
// }

// final class AllServicesLoaded extends AllServicesState {
//   final List<ServicesEntity> data;

//   const AllServicesLoaded(this.data);

//   @override
//   List<Object> get props => [data];
// }
