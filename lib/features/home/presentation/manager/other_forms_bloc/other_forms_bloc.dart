import 'package:bloc/bloc.dart';
import 'package:global_advice_new/features/home/data/model/other_forms_model.dart';
import 'package:global_advice_new/features/home/domain/use_case/other_insurance_uc.dart';
import 'package:global_advice_new/features/home/presentation/manager/other_forms_bloc/other_forms_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/other_forms_bloc/other_forms_state.dart';

import 'package:global_advice_new/core/utils/api_helper.dart';

class OtherInsuranceBloc
    extends Bloc<OtherinsuranceblocEvent, OtherinsuranceblocState> {
  OtherInsuranceUseCase healthinsuranceblocUsecase;
  OtherInsuranceBloc({required this.healthinsuranceblocUsecase})
      : super(OtherinsuranceblocInitial()) {
    on<OtherinsuranceblocEvent>((event, emit) async {
      emit(const OtherinsuranceRequestLoadingState());
      final result = await healthinsuranceblocUsecase.call(OtherFormsModel(
        name: event.name,
        phoneNumber: event.phonenumber,
        type: event.type,
        message: event.message,
      ));
      result.fold(
          (l) => emit(OtherInsuranceSuccessState(OtherInsuranceModel: l)),
          (r) => emit(OtherinsuranceRequestErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
