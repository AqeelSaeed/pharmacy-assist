part of 'forgot_cubit.dart';

sealed class ForgotState {}

final class ForgotCubitInitial extends ForgotState {}

final class ForgotLoading extends ForgotState {}

final class ForgotSuccess extends ForgotState {
  final String message;
  ForgotSuccess({required this.message});
}

final class ForgotFaild extends ForgotState {
  final String error;
  ForgotFaild({required this.error});
}
