import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import 'package:sizer/sizer.dart';

class ChangePassword extends StatefulWidget {
  final String uid;
  const ChangePassword({super.key, required this.uid});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log('messageUid: ${widget.uid}');
    return Scaffold(
      body: BackgroundComponent(
        showBackButton: true,
        showSideMenu: false,
        imagePath: Assets.passwordCheck,
        gradientColors: const [
          Palette.changePasswordGradiant1,
          Palette.changePasswordGradiant2
        ],
        containerFlex1: 1,
        containerFlex2: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Change Password",
              style: CustomFontStyle.boldText
                  .copyWith(fontSize: 30, color: Palette.primary),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                TextFieldComponent(
                  controller: newPasswordController,
                  backgroundColor: Colors.white,
                  borderColor: Colors.transparent,
                  infoLabel: 'New Password',
                  hideBorder: true,
                  hideShadow: true,
                  prefixIconPath: Assets.keyIcon,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Password',
                  obscureText: true,
                  onChanged: (newPassword) {
                    setState(() {
                      newPasswordController.text = newPassword;
                    });
                  },
                ),
                SizedBox(height: 1.9.h),
                TextFieldComponent(
                  controller: confirmPasswordController,
                  backgroundColor: Colors.white,
                  borderColor: Colors.transparent,
                  infoLabel: 'Confirm Password',
                  hideBorder: true,
                  hideShadow: true,
                  prefixIconPath: Assets.keyIcon,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  hintText: 'Password',
                  onChanged: (password) {
                    setState(() {
                      confirmPasswordController.text = password;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 4.h),
            BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                builder: (context, state) {
              return state is ChangePasswordLoading
                  ? const CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                    )
                  : ButtonComponent(
                      text: 'Save',
                      onPressed: () {
                        validatePasswords(context);
                      },
                      fontWeight: FontWeight.w400,
                      fontColor: Colors.white,
                      fontSize: 12.sp,
                      height: 60,
                    );
            }, listener: (context, state) {
              if (state is ChangePasswordSuccess) {
                replace(context, const LoginView());
              }
            })
          ],
        ),
      ),
    );
  }

  void validatePasswords(BuildContext context) {
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (newPassword.isEmpty && confirmPassword.isEmpty) {
      snack(context, 'Both passwords are empty');
      return;
    }

    if (newPassword.isEmpty) {
      snack(context, 'New password is empty');
      return;
    }

    if (confirmPassword.isEmpty) {
      snack(context, 'Confirm Password is empty');
      return;
    }

    if (newPassword != confirmPassword) {
      snack(context, 'Passwords don\'t match.');
      return;
    }

    String? passwordError = validatePassword(newPassword);
    if (passwordError != null) {
      snack(context, passwordError);
      return;
    }

    context
        .read<ChangePasswordCubit>()
        .changePassword(newPassword, confirmPassword, widget.uid);
  }
}
