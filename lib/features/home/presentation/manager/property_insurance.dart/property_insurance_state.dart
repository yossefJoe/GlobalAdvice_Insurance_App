import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

sealed class PropertyInsuranceBlocState extends Equatable {
  const PropertyInsuranceBlocState();

  @override
  List<Object> get props => [];
}

final class PropertyInsuranceBlocInitial extends PropertyInsuranceBlocState {}

final class PropertyInsuranceBlocRequestLoadingState
    extends PropertyInsuranceBlocState {
  const PropertyInsuranceBlocRequestLoadingState();
}

final class PropertyInsuranceRequestErrorState
    extends PropertyInsuranceBlocState {
  final String errorMessage;

  const PropertyInsuranceRequestErrorState({required this.errorMessage});
}

final class PropertyInsuranceSuccessState extends PropertyInsuranceBlocState {
  final Map<String, dynamic> PropertyModel;

  const PropertyInsuranceSuccessState({required this.PropertyModel});
}
