import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

sealed class OtherinsuranceblocState extends Equatable {
  const OtherinsuranceblocState();

  @override
  List<Object> get props => [];
}

final class OtherinsuranceblocInitial extends OtherinsuranceblocState {}

final class OtherinsuranceRequestLoadingState extends OtherinsuranceblocState {
  const OtherinsuranceRequestLoadingState();
}

final class OtherinsuranceRequestErrorState extends OtherinsuranceblocState {
  final String errorMessage;

  const OtherinsuranceRequestErrorState({required this.errorMessage});
}

final class OtherInsuranceSuccessState extends OtherinsuranceblocState {
  final Unit OtherInsuranceModel;

  const OtherInsuranceSuccessState({required this.OtherInsuranceModel});
}
