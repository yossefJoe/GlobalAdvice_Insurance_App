import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

sealed class HealthPolicyblocState extends Equatable {
  const HealthPolicyblocState();

  @override
  List<Object> get props => [];
}

final class HealthPolicyblocInitial extends HealthPolicyblocState {}

final class HealthPolicyRequestLoadingState extends HealthPolicyblocState {
  const HealthPolicyRequestLoadingState();
}

final class HealthPolicyRequestErrorState extends HealthPolicyblocState {
  final String errorMessage;

  const HealthPolicyRequestErrorState({required this.errorMessage});
}

final class HealthPolicySuccessState extends HealthPolicyblocState {
  final Unit HealthPolicyModel;

  const HealthPolicySuccessState({required this.HealthPolicyModel});
}
