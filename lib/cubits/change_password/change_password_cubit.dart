import 'package:bloc/bloc.dart';
import 'package:pharmacy_assist/main_barrel.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
  final repo = AuthRepo();

  Future<void> changePassword(
      String newPass, String confrimPass, String uid) async {
    emit(ChangePasswordLoading());
    try {
      final result = await repo.changePassword(newPass, confrimPass, uid);
      if (result['success'] == true) {
        emit(ChangePasswordSuccess(message: result['message']));
      } else {
        emit(ChangePasswordFailed(errorMessage: result['message']));
      }
    } catch (error) {
      emit(ChangePasswordFailed(
          errorMessage: 'Failed to send OTP. Please try again.'));
    }
  }
}
