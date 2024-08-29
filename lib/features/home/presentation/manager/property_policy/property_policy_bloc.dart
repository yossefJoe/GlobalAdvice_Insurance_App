import 'package:bloc/bloc.dart';
import 'package:global_advice_new/features/home/domain/use_case/property_policy_uc.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_policy/property_policy_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_policy/property_policy_state.dart';

import 'package:global_advice_new/core/utils/api_helper.dart';
import 'package:global_advice_new/features/home/data/model/property_policy_request_model.dart';

class PropertyPolicyBloc
    extends Bloc<PropertyPolicyblocEvent, PropertyPolicyblocState> {
  PropertyPolicyUseCase propertypolicyblocUsecase;
  PropertyPolicyBloc({required this.propertypolicyblocUsecase})
      : super(PropertyPolicyblocInitial()) {
    on<PropertyPolicyblocEvent>((event, emit) async {
      emit(const PropertyPolicyRequestLoadingState());
      final result = await propertypolicyblocUsecase.call(PropertyPolicyRequestModel(
        address: event.address,
        uID: event.uID,
        organizationId: event.organizationId,
        planId: event.planId,
        building_price: event.building_price,
        content_price: event.content_price,
        tenant_price: event.tenant_price,
        type: event.type,
      ));
      result.fold(
          (l) => emit(PropertyPolicySuccessState(PropertyPolicyModel: l)),
          (r) => emit(PropertyPolicyRequestErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
