import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/shared_views/auth_views/change_password.dart';
import 'package:pharmacy_assist/components/pin_input_widget.dart';
import 'package:pharmacy_assist/cubits/otp_cubit/otp_states.dart';
import 'package:sizer/sizer.dart';

import '../../../main_barrel.dart';

class EmailVerificationView extends StatefulWidget {
  final bool? forgotPassword;
  final String email;
  const EmailVerificationView(
      {super.key, required this.email, this.forgotPassword});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  final pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OtpCubit, OtpState>(listener: (context, state) {
        if (state is OtpSuccess) {
          if (widget.forgotPassword ?? false) {
            if (state.uid != null) {
              push(
                context,
                ChangePassword(
                  uid: state.uid!, // Pass the UID to ChangePassword screen
                ),
              );
            }
          } else {
            replace(context, const LoginView());
          }
        } else if (state is OtpError) {
          alert(context, state.error);
          return;
        }
      }, builder: (context, state) {
        return BackgroundComponent(
          showBackButton: true,
          imagePath: Assets.phoneAuth,
          gradientColors: const [Palette.otpGradiant1, Palette.otpGradiant2],
          containerFlex1: 1,
          containerFlex2: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  Assets.assist2,
                  height: 50,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Email Verification",
                      style: CustomFontStyle.boldText.copyWith(
                          fontSize: 30,
                          color: Palette.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6.h),
                    RichText(
                      text: TextSpan(
                        text: 'Enter the verification code sent to ',
                        style: CustomFontStyle.regularText
                            .copyWith(fontSize: 20), // Normal style
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.email,
                            style: CustomFontStyle.regularText.copyWith(
                              fontSize: 18,
                              color: Palette.primary,
                              fontWeight: FontWeight.w400,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                pop(context);
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.4.h),
                    Align(
                      alignment: Alignment.center,
                      child: PinInputWidget(
                        boxHeight: 60,
                        boxWidth: 60,
                        pinLength: 6,
                        gap: 26,
                        controller: pinController,
                        hideBorder: true,
                        backgroundColor: Colors.white,
                        borderColor: Palette.primary,
                        onCompleted: (String verificationCode) {},
                      ),
                    ),
                    SizedBox(height: 3.6.h),
                    ButtonComponent(
                      isLoading: state is OtpLoading,
                      text: 'Verify', // Updated action button text
                      onPressed: () {
                        context.read<OtpCubit>().verifyOtp(
                              pinController.text,
                            );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
