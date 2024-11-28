abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final String message;
  final String? uid;
  OtpSuccess(this.message, [this.uid]);
}

class OtpError extends OtpState {
  final String error;
  OtpError(this.error);
}
