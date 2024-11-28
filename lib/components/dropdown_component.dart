import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_assist/utils/labelkeys.dart';

import '../theme_data/palette.dart';
import '../theme_data/fonts.dart';

class DropdownComponent<T> extends StatelessWidget {
  final String? title;
  final String Function(T label) labelBuilder;
  final String? hint;
  final T? value;
  final List<T> items;
  final String? prefixIcon;
  final bool isExpanded;
  final double horizontalPadding;
  final double verticalPadding;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final Color? fillColor;
  final Color? borderColor;

  const DropdownComponent({
    super.key,
    this.title,
    required this.items,
    this.hint,
    required this.value,
    required this.labelBuilder,
    this.prefixIcon,
    this.horizontalPadding = 10,
    this.verticalPadding = 0,
    this.isExpanded = true,
    this.validator,
    required this.onChanged,
    this.fillColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: CustomFontStyle.regularText
                .copyWith(fontWeight: FontWeight.w400),
          ),
        if (title != null) const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: fillColor ?? Colors.white,
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(width: 1, color: borderColor ?? Palette.border),
          ),
          child: DropdownButtonFormField<T>(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            // underline: Container(
            //   height: 0,
            //   decoration: const BoxDecoration(color: Colors.transparent),
            // ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: prefixIcon == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        prefixIcon!,
                        fit: BoxFit.contain,
                      ),
                    ),
              prefixIconConstraints:
                  const BoxConstraints(maxWidth: 31, maxHeight: 21),
            ),
            value: value,
            isDense: true,
            onChanged: onChanged,
            dropdownColor: Colors.white,
            padding: EdgeInsets.symmetric(
                vertical: verticalPadding, horizontal: horizontalPadding),
            isExpanded: isExpanded,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Palette.black,
            ),
            style: CustomFontStyle.regularText
                .copyWith(fontWeight: FontWeight.w400),
            hint: Text(
              hint ?? selectBusinessType.tr(),
              style: CustomFontStyle.regularText.copyWith(
                  fontWeight: FontWeight.w400,
                  color: value != null ? Colors.black : Palette.grey),
            ),
            borderRadius: BorderRadius.circular(10),
            focusColor: Colors.transparent,
            items: items
                .map<DropdownMenuItem<T>>((T item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        labelBuilder(item),
                        style: CustomFontStyle.regularText.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
