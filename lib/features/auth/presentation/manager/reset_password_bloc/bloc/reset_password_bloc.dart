import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_advice_new/features/auth/domain/use_case/reset_password_us.dart';
import 'package:global_advice_new/features/auth/presentation/manager/reset_password_bloc/bloc/reset_password_event.dart';
import 'package:global_advice_new/features/auth/presentation/manager/reset_password_bloc/bloc/reset_password_state.dart';
import 'package:global_advice_new/core/utils/api_helper.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordUseCase passwordUseCase;

  ResetPasswordBloc({required this.passwordUseCase})
      : super(ResetPasswordInitial()) {
    on<ResetPasswordEvent>((event, emit) async {
      emit(const LoadingChangingPasswordState());
      final result = await passwordUseCase.call(event.email);
      result.fold(
          (l) => emit(ResetPasswordSuccess(resetPasswordModel: l)),
          (r) => emit(ChangingFailedState(
                errorMessage: DioHelper().getTypeOfFailure(r),
              )));
    });
  }
}
