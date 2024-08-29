import 'package:bloc/bloc.dart';
import 'package:global_advice_new/features/auth/data/model/login_model.dart';
import 'package:global_advice_new/features/auth/presentation/manager/register_bloc/register_event.dart';
import 'package:global_advice_new/features/auth/presentation/manager/register_bloc/register_state.dart';

import 'package:global_advice_new/core/utils/api_helper.dart';
import 'package:global_advice_new/features/auth/domain/use_case/register_uc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase}) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(const RegisterLoadingState());
      final result = await registerUseCase.call(LoginModel(
        email: event.email,
        password: event.password,
        telephone: event.telephone,
        name: event.name,
      ));

      result.fold(
          (l) => emit(RegisterSuccessState(
                authModelResponse: l,
              )),
          (r) => emit(RegisterErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
