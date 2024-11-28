import 'package:flutter/material.dart';

import '../main_barrel.dart';

class ProductFeatureButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final bool isLoading;
  final Color iconColor;

  const ProductFeatureButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Palette.secondary,
                    strokeCap: StrokeCap.round,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      iconPath,
                      height: 21,
                      color: iconColor,
                    ),
                    isMobile
                        ? const SizedBox.shrink()
                        : const SizedBox(width: 15),
                    isMobile
                        ? const SizedBox.shrink()
                        : Text(
                            text,
                            style: CustomFontStyle.regularText
                                .copyWith(color: iconColor),
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
