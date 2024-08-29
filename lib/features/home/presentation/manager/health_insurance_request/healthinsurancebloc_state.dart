import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/health_insurance_model.dart';

sealed class HealthinsuranceblocState extends Equatable {
  const HealthinsuranceblocState();

  @override
  List<Object> get props => [];
}

final class HealthinsuranceblocInitial extends HealthinsuranceblocState {}

final class HealthinsuranceRequestLoadingState
    extends HealthinsuranceblocState {
  const HealthinsuranceRequestLoadingState();
}

final class HealthinsuranceRequestErrorState extends HealthinsuranceblocState {
  final String errorMessage;

  const HealthinsuranceRequestErrorState({required this.errorMessage});
}

final class HealthInsuranceSuccessState extends HealthinsuranceblocState {
  final Map<String, dynamic> healthInsuranceModel;

  const HealthInsuranceSuccessState({required this.healthInsuranceModel});
}
