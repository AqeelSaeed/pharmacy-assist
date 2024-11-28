import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../main_barrel.dart';

class BackgroundComponent extends StatefulWidget {
  final String? imagePath;
  final bool? showSideMenu;
  final List<Color> gradientColors;
  final int containerFlex1;
  final int containerFlex2;
  final Widget child;
  final Widget? sideMenuWidget;
  final bool showBackButton;
  const BackgroundComponent({
    super.key,
    this.imagePath,
    this.showSideMenu = false,
    this.showBackButton = false,
    required this.gradientColors,
    required this.containerFlex1,
    required this.containerFlex2,
    required this.child,
    this.sideMenuWidget,
  });

  @override
  State<BackgroundComponent> createState() => _BackgroundComponentState();
}

class _BackgroundComponentState extends State<BackgroundComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: widget.showBackButton
          ? Padding(
              padding: EdgeInsets.only(top: 3.h, left: 0.8.w),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return InkWell(
                      onTap: () {
                        if (state is! AuthIsLoggingIn) {
                          pop(context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(1.2.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.rectangle,
                            color: widget.imagePath == Assets.phoneAuth
                                ? Palette.otpBackColor
                                : widget.imagePath == Assets.pharmacyBoard
                                    ? Palette.signUpBackColor
                                    : Palette.forgotBackColor),
                        child: const Icon(
                          Icons.keyboard_backspace_rounded,
                          color: Colors.white,
                        ),
                      ));
                },
              ),
            )
          : const SizedBox.shrink(),
      body: Row(
        children: [
          Expanded(
            flex: widget.containerFlex1,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: widget.gradientColors)),
              child: widget.showSideMenu != true
                  ? Center(
                      child: Image.asset(
                        widget.imagePath ?? '',
                        height: 50.h,
                        width: 50.w,
                        fit: BoxFit.contain,
                      ),
                    )
                  : widget.sideMenuWidget,
            ),
          ),
          Expanded(
            flex: widget.containerFlex2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 75.0, vertical: 25.0),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
