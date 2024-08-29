import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

sealed class PropertyPolicyblocState extends Equatable {
  const PropertyPolicyblocState();

  @override
  List<Object> get props => [];
}

final class PropertyPolicyblocInitial extends PropertyPolicyblocState {}

final class PropertyPolicyRequestLoadingState extends PropertyPolicyblocState {
  const PropertyPolicyRequestLoadingState();
}

final class PropertyPolicyRequestErrorState extends PropertyPolicyblocState {
  final String errorMessage;

  const PropertyPolicyRequestErrorState({required this.errorMessage});
}

final class PropertyPolicySuccessState extends PropertyPolicyblocState {
  final Unit PropertyPolicyModel;

  const PropertyPolicySuccessState({required this.PropertyPolicyModel});
}
