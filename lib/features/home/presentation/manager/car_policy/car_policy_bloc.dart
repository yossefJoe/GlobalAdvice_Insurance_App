import 'package:bloc/bloc.dart';
import 'package:global_advice_new/features/home/data/model/car_policy_request_model.dart';
import 'package:global_advice_new/features/home/domain/use_case/car_policy_uc.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_policy/car_policy_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_policy/car_policy_state.dart';

import 'package:global_advice_new/core/utils/api_helper.dart';

class CarPolicyBloc extends Bloc<CarPolicyBlocEvent, CarPolicyBlocState> {
  CarPolicyUseCase carPolicyBlocUseCase;
  CarPolicyBloc({required this.carPolicyBlocUseCase})
      : super(CarPolicyBlocInitial()) {
    on<CarPolicyBlocEvent>((event, emit) async {
      emit(const CarPolicyRequestLoadingState());
      final result = await carPolicyBlocUseCase.call(CarPolicyrequest(
        isLicensed: event.isLicensed,
        motorBrands: event.motorBrands,
        motorDeductibles: event.motorDeductibles,
        motorManufactureYear: event.motorManufactureYear,
        organizationId: event.organizationId,
        planId: event.planId,
        price: event.price,
        uID: event.uID,
      ));
      result.fold(
          (l) => emit(CarPolicySuccessState(CarPolicyModel: l)),
          (r) => emit(CarPolicyRequestErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
