import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/shared_views/auth_views/email_verification.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundComponent(
        showBackButton: true,
        imagePath: Assets.passwordCheck,
        gradientColors: const [
          Palette.forgotPasswordGradiant1,
          Palette.forgotPasswordGradiant2,
        ],
        containerFlex1: 1,
        containerFlex2: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot Password",
              style: CustomFontStyle.boldText
                  .copyWith(fontSize: 30, color: Palette.primary),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldComponent(
                    controller: emailController,
                    backgroundColor: Colors.white,
                    borderColor: Colors.transparent,
                    infoLabel: 'Email',
                    hideBorder: true,
                    hideShadow: true,
                    prefixIconPath: Assets.emailIcon,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
                    onChanged: (emailInput) {
                      setState(() {
                        emailController.text = emailInput;
                      });
                      _formKey.currentState!.validate();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            BlocConsumer<ForgotCubit, ForgotState>(
              listener: (context, state) {
                if (state is ForgotSuccess) {
                  replace(
                      context,
                      EmailVerificationView(
                        email: emailController.text,
                        forgotPassword: true,
                      ));
                }
                if (state is ForgotFaild) {
                  alert(info: false, context, state.error);
                }
              },
              builder: (context, state) {
                return ButtonComponent(
                  isLoading: state is ForgotLoading,
                  text: 'Send',
                  onPressed: () {
                    final bool isEmailValid = emailVerify(emailController.text);
                    log('email: $isEmailValid');
                    if (emailController.text.isEmpty) {
                      snack(context, 'Email is empty');
                      return;
                    }
                    if (!isEmailValid) {
                      snack(context, 'Invalid Email');
                      return;
                    }
                    context
                        .read<ForgotCubit>()
                        .forgotPassword(emailController.text);
                  },
                  fontWeight: FontWeight.w400,
                  fontColor: Colors.white,
                  fontSize: 12.sp,
                  height: 60,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
