import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

sealed class LifeInsuranceBlocState extends Equatable {
  const LifeInsuranceBlocState();

  @override
  List<Object> get props => [];
}

final class LifeInsuranceBlocInitial extends LifeInsuranceBlocState {}

final class LifeInsuranceRequestLoadingState extends LifeInsuranceBlocState {
  const LifeInsuranceRequestLoadingState();
}

final class LifeInsuranceRequestErrorState extends LifeInsuranceBlocState {
  final String errorMessage;

  const LifeInsuranceRequestErrorState({required this.errorMessage});
}

final class LifeInsuranceSuccessState extends LifeInsuranceBlocState {
  final Unit LifeInsuranceModel;

  const LifeInsuranceSuccessState({required this.LifeInsuranceModel});
}
