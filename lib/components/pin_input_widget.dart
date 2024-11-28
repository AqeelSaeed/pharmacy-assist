import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../main_barrel.dart';

class PinInputWidget extends StatelessWidget {
  final int pinLength;
  final double gap;
  final double boxWidth;
  final double boxHeight;
  final Color borderColor;
  final Color backgroundColor;
  final bool obscureText;
  final bool hideBorder;
  final bool hideShadow;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String value)? onCompleted;

  const PinInputWidget(
      {super.key,
      this.pinLength = 6,
      required this.controller,
      this.onCompleted,
      this.boxHeight = 60,
      this.boxWidth = 46,
      this.borderColor = Colors.black,
      this.backgroundColor = const Color(0xFFF2F2F2),
      this.gap = 14,
      this.obscureText = false,
      this.hideBorder = true,
      this.hideShadow = true,
      this.validator});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      height: boxHeight,
      width: boxWidth,
      textStyle: CustomFontStyle.regularText
          .copyWith(fontSize: 22, fontWeight: FontWeight.w500),
      decoration: BoxDecoration(
        border: hideBorder ? null : Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
        boxShadow: [
          if (!hideShadow)
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 3), // Shadow position
            ),
        ],
      ),
    );

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 2,
        height: 30,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
    return Pinput(
      length: pinLength,
      autofocus: false,
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.none,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      defaultPinTheme: defaultPinTheme,
      separatorBuilder: (int index) => SizedBox(width: gap),
      validator: validator,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 200),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            if (hideShadow)
              const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.06),
                offset: Offset(0, 3),
                blurRadius: 16,
              )
          ],
        ),
      ),
      obscuringWidget: const Padding(
        padding: EdgeInsets.only(top: 1),
        child: Icon(
          Icons.circle,
          size: 17,
          color: Palette.primary,
        ),
      ),
      showCursor: true,
      cursor: cursor,
      isCursorAnimationEnabled: false,
      onChanged: (value) {
        if (value.length == pinLength) {
          onCompleted!(value);
        }
      },
    );
  }
}
