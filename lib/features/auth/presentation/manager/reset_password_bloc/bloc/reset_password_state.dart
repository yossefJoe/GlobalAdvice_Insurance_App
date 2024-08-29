import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

final class ResetPasswordInitial extends ResetPasswordState {}

final class LoadingChangingPasswordState extends ResetPasswordState {
  const LoadingChangingPasswordState();
}

final class ResetPasswordSuccess extends ResetPasswordState {
  final Unit resetPasswordModel;

  const ResetPasswordSuccess({required this.resetPasswordModel});
}

class ChangingFailedState extends ResetPasswordState {
  final String errorMessage;

  ChangingFailedState({required this.errorMessage});
}
