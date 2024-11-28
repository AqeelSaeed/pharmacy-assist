import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/apps/handle_view.dart';
import 'package:pharmacy_assist/apps/shared_views/auth_views/signup_view.dart';
import 'package:pharmacy_assist/main_barrel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      emailController.text = "ali.nextbyte@gmail.com";
      passwordController.text = "Lahore123@";
    }
    return Scaffold(
      body: BackgroundComponent(
        imagePath: Assets.medicineImage,
        showSideMenu: false,
        gradientColors: const [Palette.loginGradiant1, Palette.loginGradiant2],
        containerFlex1: 1,
        containerFlex2: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Image.asset(
                Assets.assist2,
                width: 170,
              ),
            ),
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    signIn.tr(),
                    style: CustomFontStyle.boldText
                        .copyWith(fontSize: 30, color: Palette.primary),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldComponent(
                          hideBorder: true,
                          hideShadow: true,
                          controller: emailController,
                          backgroundColor: Colors.white,
                          borderColor: Colors.transparent,
                          infoLabel: email.tr(),
                          prefixIconPath: Assets.emailIcon,
                          keyboardType: TextInputType.emailAddress,
                          hintText: email.tr(),
                        ),
                        const SizedBox(height: 20),
                        TextFieldComponent(
                          controller: passwordController,
                          backgroundColor: Colors.white,
                          borderColor: Colors.transparent,
                          infoLabel: password.tr(),
                          obscureText: true,
                          hideBorder: true,
                          hideShadow: true,
                          prefixIconPath: Assets.keyIcon,
                          keyboardType: TextInputType.text,
                          hintText: password.tr(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          push(context, const ForgotPasswordScreen());
                        },
                        child: Text(
                          forgotPassword.tr(),
                          style: CustomFontStyle.regularText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoginSuccess) {
                        // replace(context, const HandleLogin());
                        context.read<NavigationCubit>().replaceNavigation(
                            context,
                            NavigationModel('Login', const HandleLogin()));
                      } else if (state is AuthLoginFailure) {
                        alert(context, state.errorMessage);
                      }
                    },
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return ButtonComponent(
                          isLoading: state is AuthLoading,
                          text: login.tr(),
                          onPressed: () async {
                            if (emailController.text.isEmpty &&
                                passwordController.text.isEmpty) {
                              alert(context, emptyEmailPassword.tr());
                              return;
                            }
                            if (emailController.text.isEmpty) {
                              alert(context, emptyEmail.tr());
                              return;
                            }
                            if (!emailVerify(emailController.text)) {
                              alert(context, validEmail.tr());
                              return;
                            }
                            if (passwordController.text.isEmpty) {
                              alert(context, emptyPassword.tr());
                              return;
                            }
                            context.read<AuthCubit>().login(
                                  emailController.text,
                                  passwordController.text,
                                );
                          },
                          fontWeight: FontWeight.w400,
                          fontColor: Colors.white,
                          fontSize: 15,
                          height: 60,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dontHaveAccount.tr(),
                        style: CustomFontStyle.regularText,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            push(context, const SignupView());
                          },
                          child: Text(
                            signUp.tr(),
                            style: CustomFontStyle.regularText
                                .copyWith(color: Palette.primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
