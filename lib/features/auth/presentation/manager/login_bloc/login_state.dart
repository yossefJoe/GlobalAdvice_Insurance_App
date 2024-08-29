import 'package:equatable/equatable.dart';


abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

final class LoginErrorState extends LoginState {
  final String errorMessage;

  const LoginErrorState({required this.errorMessage});
}

final class LoginSuccessState extends LoginState {
  final Map<String, dynamic> loginAuthModelResponse;

  const LoginSuccessState({required this.loginAuthModelResponse});
}
