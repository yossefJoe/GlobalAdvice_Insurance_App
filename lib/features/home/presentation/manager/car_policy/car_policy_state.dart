import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

sealed class CarPolicyBlocState extends Equatable {
  const CarPolicyBlocState();

  @override
  List<Object> get props => [];
}

final class CarPolicyBlocInitial extends CarPolicyBlocState {}

final class CarPolicyRequestLoadingState extends CarPolicyBlocState {
  const CarPolicyRequestLoadingState();
}

final class CarPolicyRequestErrorState extends CarPolicyBlocState {
  final String errorMessage;

  const CarPolicyRequestErrorState({required this.errorMessage});
}

final class CarPolicySuccessState extends CarPolicyBlocState {
  final Unit CarPolicyModel;

  const CarPolicySuccessState({required this.CarPolicyModel});
}
