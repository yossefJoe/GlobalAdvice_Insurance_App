import 'package:bloc/bloc.dart';
import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/features/home/domain/use_case/property_data_uc.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_data_bloc/property_data_event.dart';
import 'package:global_advice_new/features/home/presentation/manager/property_data_bloc/property_data_state.dart';
import 'package:global_advice_new/core/utils/api_helper.dart';

class PropertyDataBloc extends Bloc<PropertyDataEvent, PropertyDataState> {
  PropertyDataUseCase propertyDataUseCase;

  PropertyDataBloc({required this.propertyDataUseCase})
      : super(PropertyDataInitial()) {
    on<PropertyDataEvent>((event, emit) async {
      emit(const PropertyDataLoadingState());
      final result = await propertyDataUseCase.call(const Noparamiter());
      result.fold(
          (l) => emit(PropertyDataSuccessState(l)),
          (r) => emit(PropertyDataErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
