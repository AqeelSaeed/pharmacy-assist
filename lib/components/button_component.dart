import 'package:flutter/material.dart';

import '../main_barrel.dart';

class ButtonComponent extends StatefulWidget {
  final String? iconPath;
  final Color? iconColor;
  final String text;
  final Function()? onPressed;
  final Future<void> Function()? asyncOnPressed;
  final double height;
  final double maxWidth;
  final String? buttonType;
  final bool isBorderedButton;
  final FontWeight fontWeight;
  final double fontSize;
  final Color fontColor;
  final Color? borderColor;
  final double horizontalPadding;
  final double borderRadius;
  final bool isLoading; // Add loading state
  final Color? backgroundColor;

  const ButtonComponent({
    super.key,
    this.iconPath,
    this.iconColor,
    required this.text,
    this.onPressed,
    this.asyncOnPressed,
    this.height = 46,
    this.maxWidth = double.infinity,
    this.borderRadius = 10.0,
    this.isBorderedButton = false,
    this.horizontalPadding = 0,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 16,
    this.fontColor = Colors.white,
    this.borderColor,
    this.backgroundColor,
    this.buttonType,
    this.isLoading = false, // Default value for loading
  });

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        constraints: BoxConstraints(maxWidth: widget.maxWidth),
        padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.backgroundColor ??
              (widget.buttonType == null
                  ? null
                  : widget.buttonType == 'delete'
                      ? Palette.error
                      : Palette.black),
          gradient: widget.backgroundColor != null
              ? null
              : widget.buttonType == null
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Palette.loginGradiant2,
                        Palette.primary,
                      ],
                    )
                  : null,
          borderRadius: BorderRadius.circular(widget.borderRadius - 2),
          border: widget.isBorderedButton
              ? Border.all(color: widget.borderColor ?? Colors.blueGrey)
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            highlightColor: Colors.transparent,
            onPressed: widget.isLoading
                ? null // Disable button when loading
                : widget.asyncOnPressed != null
                    ? () async {
                        await widget.asyncOnPressed!();
                      }
                    : widget.onPressed,
            elevation: 0,
            child: widget.isLoading
                ? const CircularProgressIndicator(
                    strokeWidth: 4.0,
                    strokeCap: StrokeCap.round,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.iconPath != null)
                        Image.asset(
                          widget.iconPath!,
                          width: 20,
                          color: widget.iconColor,
                        ),
                      if (widget.iconPath != null) const SizedBox(width: 10),
                      Text(
                        widget.text,
                        style: TextStyle(
                            color: widget.isBorderedButton
                                ? Colors.blueGrey
                                : widget.fontColor,
                            fontSize: widget.fontSize,
                            fontFamily: 'Nexa',
                            height: 1.3,
                            letterSpacing: 0.5,
                            fontWeight: widget.fontWeight),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
