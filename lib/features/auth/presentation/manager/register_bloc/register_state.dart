import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoadingState extends RegisterState {
  const RegisterLoadingState();
}

final class RegisterErrorState extends RegisterState {
  final String errorMessage;

  const RegisterErrorState({required this.errorMessage});
}

final class RegisterSuccessState extends RegisterState {
  final Unit authModelResponse;

  const RegisterSuccessState({required this.authModelResponse});
}
