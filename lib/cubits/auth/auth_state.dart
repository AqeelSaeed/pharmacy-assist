part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class AuthIsLoggingIn extends AuthState{}
// Login States
class AuthLoginSuccess extends AuthState {
  final Map<String, dynamic> data;
  AuthLoginSuccess(this.data);
}

class AuthLoginFailure extends AuthState {
  final String errorMessage;
  AuthLoginFailure(this.errorMessage);
}

final class AuthIsRegistered extends AuthState {
  final SignupResponseModel model;

  AuthIsRegistered({required this.model});
}

final class AuthFailed extends AuthState {
  final String errorMessage;

  AuthFailed({required this.errorMessage});
}
