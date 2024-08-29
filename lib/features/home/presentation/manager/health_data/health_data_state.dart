import 'package:equatable/equatable.dart';
import 'package:global_advice_new/features/home/data/model/health_dependinces_model.dart';

abstract class HealthDataState extends Equatable {
  const HealthDataState();

  @override
  List<Object> get props => [];
}

final class HealthDataInitial extends HealthDataState {}

final class HealthDataLoadingState extends HealthDataState {
  const HealthDataLoadingState();
}

final class HealthDataErrorState extends HealthDataState {
  final String errorMessage;

  const HealthDataErrorState({required this.errorMessage});
}

final class HealthDataSuccessState extends HealthDataState {
  final List<HealthDependincesModel> HealthDependinces;
  const HealthDataSuccessState(this.HealthDependinces);
}
