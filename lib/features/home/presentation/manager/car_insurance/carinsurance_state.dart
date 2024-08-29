import 'package:equatable/equatable.dart';

sealed class CarInsuranceBlocState extends Equatable {
  const CarInsuranceBlocState();

  @override
  List<Object> get props => [];
}

final class CarInsuranceBlocInitial extends CarInsuranceBlocState {}

final class CarInsuranceRequestLoadingState extends CarInsuranceBlocState {
  const CarInsuranceRequestLoadingState();
}

final class CarInsuranceRequestErrorState extends CarInsuranceBlocState {
  final String errorMessage;

  const CarInsuranceRequestErrorState({required this.errorMessage});
}

final class CarInsuranceSuccessState extends CarInsuranceBlocState {
  final Map<String, dynamic> CarInsuranceModel;

  const CarInsuranceSuccessState({required this.CarInsuranceModel});
}
