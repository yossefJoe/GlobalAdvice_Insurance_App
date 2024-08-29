import 'package:equatable/equatable.dart';
import 'package:global_advice_new/features/home/data/model/property_dependinces_model.dart';

abstract class PropertyDataState extends Equatable {
  const PropertyDataState();

  @override
  List<Object> get props => [];
}

final class PropertyDataInitial extends PropertyDataState {}

final class PropertyDataLoadingState extends PropertyDataState {
  const PropertyDataLoadingState();
}

final class PropertyDataErrorState extends PropertyDataState {
  final String errorMessage;

  const PropertyDataErrorState({required this.errorMessage});
}

final class PropertyDataSuccessState extends PropertyDataState {
  final List<PropertyDependincesData> PropertyDependinces;
  const PropertyDataSuccessState(this.PropertyDependinces);
}
