import 'package:bloc/bloc.dart';
import 'package:global_advice_new/features/home/data/model/car_insurance_request_model.dart';
import 'package:global_advice_new/features/home/domain/use_case/car_inurance_uc.dart';

import 'package:global_advice_new/core/utils/api_helper.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_insurance/carinsurance_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/car_insurance/carinsurance_state.dart';

class CarinsuranceBloc
    extends Bloc<CarInsuranceBlocEvent, CarInsuranceBlocState> {
  CarInsuranceUseCase healthinsuranceblocUsecase;
  CarinsuranceBloc({required this.healthinsuranceblocUsecase})
      : super(CarInsuranceBlocInitial()) {
    on<CarInsuranceBlocEvent>((event, emit) async {
      emit(const CarInsuranceRequestLoadingState());
      final result = await healthinsuranceblocUsecase.call(CarInusranceRequest(
        uid: event.uid,
        isLicensed: event.isLicensed,
        motorBrands: event.motorBrands,
        motorDeductibles: event.motorDeductibles,
        motorManufactureYear: event.motorManufactureYear,
        phone: event.phone,
        price: event.price,
      ));
      result.fold(
          (l) => emit(CarInsuranceSuccessState(CarInsuranceModel: l)),
          (r) => emit(CarInsuranceRequestErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
