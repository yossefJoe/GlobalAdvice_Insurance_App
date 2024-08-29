import 'package:bloc/bloc.dart';
import 'package:global_advice_new/features/home/domain/use_case/health_data_uc.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_data/health_data_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/health_data/health_data_state.dart';
import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/utils/api_helper.dart';

class HealthDataBloc extends Bloc<HealthDataEvent, HealthDataState> {
  FetchingHealthDataUseCase HealthDataUseCase;

  HealthDataBloc({required this.HealthDataUseCase})
      : super(HealthDataInitial()) {
    on<HealthDataEvent>((event, emit) async {
      emit(const HealthDataLoadingState());
      final result = await HealthDataUseCase.call(const Noparamiter());
      result.fold(
          (l) => emit(HealthDataSuccessState(l)),
          (r) => emit(HealthDataErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
