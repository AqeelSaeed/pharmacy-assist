import 'package:flutter/material.dart';
import '../../../../../main_barrel.dart';

class StaffRowWidget extends StatelessWidget {
  final bool isHeading;
  final bool isSelected;
  final Function()? onTap;

  const StaffRowWidget({
    super.key,
    this.isHeading = false,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    context.locale.languageCode;
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(tableRowPadding),
          width: double.infinity,
          decoration: BoxDecoration(
            color: isHeading ? Palette.primaryLight : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: isHeading
                ? null
                : Border.all(
                    width: 0.5,
                    color: isSelected ? Palette.secondary : Colors.white,
                  ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: isHeading
                    ? Align(
                        alignment: Alignment.center,
                        child: Text(
                          image.tr(),
                          style: CustomFontStyle.regularText.copyWith(
                            fontSize: isHeading ? 17 : 15,
                            fontWeight:
                                isHeading ? FontWeight.w500 : FontWeight.w400,
                            color: isHeading ? Palette.primary : Colors.black,
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: CachedImageWidget(
                                height: 40,
                                width: 40,
                                url:
                                    'https://lumiere-a.akamaihd.net/v1/images/pr_pixar_4kultrahdreleases_cars2_18095_81beddd3.png'),
                          ),
                        ),
                      ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading ? name.tr() : 'Ali',
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading ? email.tr() : 'user@gmail.com',
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading ? 'Role' : 'Salesman',
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading
                        ? date.tr()
                        : formatDateToMonth(DateTime.now()).toString(),
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 150,
                  child: isHeading
                      ? Align(
                          alignment: Alignment.center,
                          child: Text(
                            actions.tr(),
                            style: CustomFontStyle.regularText.copyWith(
                                fontSize: isHeading ? 17 : 15,
                                fontWeight: isHeading
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                                color:
                                    isHeading ? Palette.primary : Colors.black),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                  onTap: onTap,
                                  child: const Icon(Icons.more_horiz)),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
        if (!isHeading && isSelected)
          Positioned(
            left: context.locale == const Locale('ar') ? 80 : null,
            right: context.locale == const Locale('en') ? 10 : null,
            bottom: 10,
            child: ActionButtons(
              onTapReturn: () {},
            ),
          ),
      ],
    );
  }
}
