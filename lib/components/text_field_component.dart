import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme_data/fonts.dart';
import '../theme_data/palette.dart';

class TextFieldComponent extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? infoLabel;
  final bool centerInfoLabel;
  final String? infoLabelImage;
  final IconData? infoLabelIconData;
  final String? hintText;
  final String? labelText;
  final String? prefixIconPath;
  final Color? prefixIconColor;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final bool obscureText;
  final TextAlign? textAlignment;
  final double radius;
  final double? leftSideRadius;
  final double? rightSideRadius;
  final double fontSize;
  final FontWeight? fontWeight;
  final double verticalPadding;
  final int minLines;
  final int maxLines;
  final Color borderColor;
  final Color? backgroundColor;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final bool hideShadow;
  final bool hideBorder;
  final bool forceEnableTextColor;
  final Function(String query)? onChanged;
  final Function(String)? onFieldSubmitted;

  /// The text field will act as read-only if onTap is not null
  final Function()? onTap;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final double? height;
  final double? width;

  /// Adds support for text direction based on locale
  final TextDirection inputDirection; // Use Flutter's TextDirection here

  const TextFieldComponent({
    super.key,
    this.validator,
    this.infoLabel,
    this.controller,
    this.centerInfoLabel = false,
    this.infoLabelImage,
    this.infoLabelIconData,
    this.prefixIconPath,
    this.prefixIconColor,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.textInputAction,
    this.obscureText = false,
    this.hideShadow = false,
    this.hideBorder = false,
    this.forceEnableTextColor = false,
    this.radius = 10.0,
    this.leftSideRadius,
    this.textAlignment,
    this.rightSideRadius,
    this.verticalPadding = 12,
    this.fontSize = 15,
    this.fontWeight,
    this.minLines = 1,
    this.maxLines = 1,
    this.borderColor = Palette.border,
    this.backgroundColor,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.inputFormatters,
    this.height,
    this.width,
    this.inputDirection = TextDirection.ltr,
  });

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.infoLabel != null)
          widget.centerInfoLabel
              ? Center(
                  child: Text(
                    widget.infoLabel!,
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: 13,
                    ),
                  ),
                )
              : Row(
                  children: [
                    widget.infoLabelImage != null
                        ? Image.asset(widget.infoLabelImage!, height: 16)
                        : widget.infoLabelIconData == null
                            ? const SizedBox.shrink()
                            : Icon(widget.infoLabelIconData,
                                color: Colors.black, size: 16),
                    if (widget.infoLabelImage != null ||
                        widget.infoLabelIconData != null)
                      const SizedBox(width: 10),
                    Text(
                      widget.infoLabel!,
                      style: CustomFontStyle.regularText.copyWith(fontSize: 14),
                    )
                  ],
                ),
        if (widget.infoLabel != null) const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: (widget.leftSideRadius != null ||
                    widget.rightSideRadius != null)
                ? BorderRadius.only(
                    bottomLeft:
                        Radius.circular(widget.leftSideRadius ?? widget.radius),
                    topLeft:
                        Radius.circular(widget.leftSideRadius ?? widget.radius),
                    topRight: Radius.circular(
                        widget.rightSideRadius ?? widget.radius),
                    bottomRight: Radius.circular(
                        widget.rightSideRadius ?? widget.radius),
                  )
                : BorderRadius.circular(widget.radius),
            color: widget.backgroundColor ?? Colors.white,
            boxShadow: widget.hideShadow
                ? []
                : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 0), // Shadow position
                    ),
                  ],
          ),
          child: Directionality(
            textDirection: Localizations.localeOf(context) == const Locale('ar')
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: TextFormField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              readOnly: widget.onTap != null,
              validator: widget.validator,
              onChanged: widget.onChanged,
              textAlign: widget.textAlignment == null
                  ? (isArabic ? TextAlign.right : TextAlign.left)
                  : widget.textAlignment!, // Cursor position
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              textAlignVertical: TextAlignVertical.bottom,
              controller: widget.controller,
              onTap: widget.onTap,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                color: (!widget.forceEnableTextColor && widget.onTap != null)
                    ? Colors.grey
                    : Colors.black,
                letterSpacing: 0,
              ),
              textInputAction: widget.textInputAction,
              obscureText:
                  widget.obscureText ? obscureText : widget.obscureText,
              keyboardType: widget.keyboardType,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              inputFormatters: widget.inputFormatters,
              onFieldSubmitted: widget.onFieldSubmitted,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: widget.verticalPadding + 8,
                    bottom: widget.verticalPadding + 3),
                prefixIcon: widget.prefixIconPath == null
                    ? null
                    : Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 14.0,
                            end: 10,
                            bottom: widget.maxLines > 1 ? 135 : 0),
                        child: Image.asset(
                          widget.prefixIconPath!,
                          width: 18,
                          fit: BoxFit.contain,
                          color: widget.prefixIconColor,
                        ),
                      ),
                suffixIcon: widget.obscureText == true
                    ? IconButton(
                        icon: Icon(
                            !obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20),
                        onPressed: () =>
                            setState(() => obscureText = !obscureText),
                      )
                    : widget.suffixIcon == null
                        ? null
                        : Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10),
                            child: widget.suffixIcon,
                          ),
                hintText: widget.hintText,
                prefixText: widget.prefixText,
                suffixText: widget.suffixText,
                labelText: widget.labelText,
                labelStyle: CustomFontStyle.regularText
                    .copyWith(color: Palette.lightGrey),
                hintStyle: CustomFontStyle.regularText.copyWith(
                    color: Palette.grey,
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w400),
                floatingLabelStyle:
                    CustomFontStyle.regularText.copyWith(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
