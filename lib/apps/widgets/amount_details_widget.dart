import 'package:flutter/material.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import 'package:sizer/sizer.dart';

class AmountDetailsWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String amount;
  final Color iconBackgroundColor;

  final Function onTap;
  final bool isSelected;

  const AmountDetailsWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.iconBackgroundColor,
    required this.onTap,
    required this.isSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AmountDetailsWidgetState createState() => _AmountDetailsWidgetState();
}

class _AmountDetailsWidgetState extends State<AmountDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    Color iconBackgroundColor = widget.iconBackgroundColor;
    Color backgroundColor =
        widget.isSelected ? const Color(0xff47A3FF) : Colors.white;

    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        width: 530,
        height: 175,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: iconBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: CustomFontStyle.regularText,
                        ),
                        Text(
                          widget.amount,
                          style: CustomFontStyle.regularText
                              .copyWith(color: Palette.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
