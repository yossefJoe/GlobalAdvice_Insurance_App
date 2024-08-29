import 'package:bloc/bloc.dart';
import 'package:global_advice_new/core/utils/api_helper.dart';
import 'package:global_advice_new/features/auth/data/model/login_model.dart';
import 'package:global_advice_new/features/auth/domain/use_case/login_uc.dart';
import 'package:global_advice_new/features/auth/presentation/manager/login_bloc/login_event.dart';
import 'package:global_advice_new/features/auth/presentation/manager/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(const LoginLoadingState());
      final result = await loginUseCase
          .call(LoginModel(email: event.email, password: event.password));
      print(result);
      result.fold(
          (l) => emit(LoginSuccessState(
                loginAuthModelResponse: l,
              )), (r) {
        emit(LoginErrorState(errorMessage: DioHelper().getTypeOfFailure(r)));
      });
    });
  }
}
