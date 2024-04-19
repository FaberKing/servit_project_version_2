part of 'all_services_bloc.dart';

sealed class AllServicesEvent extends Equatable {
  const AllServicesEvent();

  @override
  List<Object> get props => [];
}

class OnGetAllServices extends AllServicesEvent {}
