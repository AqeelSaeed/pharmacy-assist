import 'package:flutter/material.dart';
import 'package:pharmacy_assist/main_barrel.dart';

// ignore: must_be_immutable
class ScreenHeader extends StatefulWidget {
  final Widget? leading;
  final TextEditingController? controller;

  int? selectedButtonIndex;
  final void Function(String)? onChanged;

  ScreenHeader(
      {super.key,
      this.leading,
      this.controller,
      this.selectedButtonIndex = 2,
      this.onChanged});

  @override
  State<ScreenHeader> createState() => _ScreenHeaderState();
}

class _ScreenHeaderState extends State<ScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: Responsive.isMobile(context)
                  ? MediaQuery.sizeOf(context).width * 0.55
                  : 356,
            ),
            child: TextFieldComponent(
                hintText: searchPlaceholder.tr(),
                controller: widget.controller,
                onChanged: widget.onChanged,
                hideBorder: true,
                hideShadow: true,
                prefixIconPath: Assets.searchIcon),
          ),
        ],
      ),
    );
  }
}
