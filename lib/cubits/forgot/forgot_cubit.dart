import 'package:bloc/bloc.dart';

import '../../main_barrel.dart';

part 'forgot_cubit_state.dart';

class ForgotCubit extends Cubit<ForgotState> {
  ForgotCubit() : super(ForgotCubitInitial());

  final AuthRepo authRepo = AuthRepo();

  Future<void> forgotPassword(String email) async {
    emit(ForgotLoading());

    final result = await authRepo.forgotPassowrd(email);
    if (result['success'] == true) {
      emit(ForgotSuccess(message: result['message']));
    } else {
      emit(ForgotFaild(error: result['message']));
    }
  }
}
