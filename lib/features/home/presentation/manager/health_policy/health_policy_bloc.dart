import 'package:bloc/bloc.dart';
import 'package:global_advice_new/features/home/domain/use_case/health_policy_uc.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_policy/health_policy_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_policy/health_policy_state.dart';

import 'package:global_advice_new/core/utils/api_helper.dart';
import 'package:global_advice_new/features/home/data/model/health_policy_request_model.dart';

class HealthPolicyBloc
    extends Bloc<HealthPolicyblocEvent, HealthPolicyblocState> {
  HealthPolicyUsecase healthpolicyblocUsecase;
  HealthPolicyBloc({required this.healthpolicyblocUsecase})
      : super(HealthPolicyblocInitial()) {
    on<HealthPolicyblocEvent>((event, emit) async {
      emit(const HealthPolicyRequestLoadingState());
      final result = await healthpolicyblocUsecase.call(HealthPolicyrequest(
        uID: event.uID,
        organizationId: event.organizationId,
        planId: event.planId,
        price: event.price,
        relations: event.relations,
        age: event.age,
        name: event.name,
        gender: event.gender,
      ));
      result.fold(
          (l) => emit(HealthPolicySuccessState(HealthPolicyModel: l)),
          (r) => emit(HealthPolicyRequestErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
