import 'package:bloc/bloc.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import 'otp_states.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepo authRepository = AuthRepo();
  // check it here

  OtpCubit() : super(OtpInitial());

  Future<void> verifyOtp(String otp) async {
    emit(OtpLoading());

    try {
      final result = await authRepository.verficationEmail(otp);

      if (result['success'] == true) {
        final String message = result['message'];
        final String? uid = result.containsKey('uid') ? result['uid'] : null;
        if (uid != null) {
          emit(OtpSuccess(message, uid));
        } else {
          emit(OtpSuccess(message));
        }
      } else {
        emit(OtpError(result['message']));
      }
    } catch (error) {
      emit(OtpError('Failed to verify OTP. Please try again.'));
    }
  }
}
