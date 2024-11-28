import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:pharmacy_assist/main_barrel.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final repo = AuthRepo();

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final data = await repo.login(email, password);
      emit(AuthLoginSuccess(data));
    } catch (error) {
      emit(AuthLoginFailure(error.toString()));
    }
  }

  Future<SignupResponseModel?> signUp(
      Map<String, dynamic> formData, Function onSuccess, Function onFailed) {
    emit(AuthLoading());
    return repo.signup(formData, () {
      log('success state');
      onSuccess();
      emit(AuthIsRegistered(model: repo.signupResponseModel));
    }, () {
      onFailed();
      emit(AuthInitial());
      log('failure state');
    });
  }
}
