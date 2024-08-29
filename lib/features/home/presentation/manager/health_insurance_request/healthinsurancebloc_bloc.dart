import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:global_advice_new/features/home/data/model/health_insurance_model.dart';
import 'package:global_advice_new/features/home/domain/use_case/healthInsuranceUsecase.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_insurance_request/healthinsurancebloc_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_insurance_request/healthinsurancebloc_state.dart';

import 'package:global_advice_new/core/utils/api_helper.dart';

class HealthinsuranceBloc
    extends Bloc<HealthinsuranceblocEvent, HealthinsuranceblocState> {
  HealthInsuranceUseCase healthinsuranceblocUsecase;
  HealthinsuranceBloc({required this.healthinsuranceblocUsecase})
      : super(HealthinsuranceblocInitial()) {
    on<HealthinsuranceblocEvent>((event, emit) async {
      emit(const HealthinsuranceRequestLoadingState());
      final result = await healthinsuranceblocUsecase.call(HealthInsuranceModel(
        uid: event.uid,
        phone: event.phone,
        name: event.name,
        age: event.age,
        relation: event.relation,
        gender: event.gender,
        healthLimit: event.healthLimit,
      ));
      result.fold(
          (l) => emit(HealthInsuranceSuccessState(healthInsuranceModel: l)),
          (r) => emit(HealthinsuranceRequestErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
