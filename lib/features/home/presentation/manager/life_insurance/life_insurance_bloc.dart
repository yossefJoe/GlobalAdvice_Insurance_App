import 'package:bloc/bloc.dart';
import 'package:global_advice_new/features/home/domain/use_case/life_insurance_uc.dart';
import 'package:global_advice_new/features/home/presentation/manager/life_insurance/life_insurance_state.dart';
import 'package:global_advice_new/core/utils/api_helper.dart';
import 'package:global_advice_new/features/home/data/model/life_insurance_model.dart';
import 'package:global_advice_new/features/home/presentation/manager/life_insurance/life_insurance_event.dart';

class LifeInsuranceBloc
    extends Bloc<LifeInsuranceBlocEvent, LifeInsuranceBlocState> {
  LifeInsuranceUseCase lifeInsuranceUseCase;
  LifeInsuranceBloc({required this.lifeInsuranceUseCase})
      : super(LifeInsuranceBlocInitial()) {
    on<LifeInsuranceBlocEvent>((event, emit) async {
      emit(const LifeInsuranceRequestLoadingState());
      final result = await lifeInsuranceUseCase.call(LifeInsuranceModel(
        email: event.email,
        name: event.name,
        phone: event.phone,
        body: event.body,
        uid: event.uid,
      ));
      result.fold(
          (l) => emit(LifeInsuranceSuccessState(LifeInsuranceModel: l)),
          (r) => emit(LifeInsuranceRequestErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
