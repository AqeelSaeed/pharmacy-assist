import 'package:flutter/material.dart';
import '../../../../../main_barrel.dart';

class DrugDepoTableRowWidget extends StatelessWidget {
  final bool isHeading;
  final String? srNo;
  final DrugDepot? depoModel;
  final bool isSelected;
  final Function()? onTap;

  const DrugDepoTableRowWidget({
    super.key,
    this.isHeading = false,
    this.srNo,
    this.depoModel,
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
              // License Image Column
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: isHeading
                      ? Text(
                          licenseImage.tr(),
                          style: CustomFontStyle.regularText.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Palette.primary,
                          ),
                        )
                      : Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedImageWidget(
                            height: 40,
                            width: 40,
                            url:
                                '$storageBaseUrl${depoModel?.profilePicture ?? ''}',
                            // fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              // Name Column
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading ? name.tr() : depoModel?.name ?? name.tr(),
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              // Email Column
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading ? email.tr() : depoModel?.email ?? email.tr(),
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              // Phone Number Column
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading
                        ? phoneNumber.tr()
                        : depoModel?.phoneNumber ?? phoneNumber.tr(),
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              // Warehouse Column
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading
                        ? warehouse.tr()
                        : depoModel!.role ?? warehouse.tr(),
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              // Total Products Column
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isHeading
                        ? totalProducts.tr()
                        : depoModel!.totalProducts.toString(),
                    style: CustomFontStyle.regularText.copyWith(
                      fontSize: isHeading ? 17 : 15,
                      fontWeight: isHeading ? FontWeight.w500 : FontWeight.w400,
                      color: isHeading ? Palette.primary : Colors.black,
                    ),
                  ),
                ),
              ),
              // Action Column
              Expanded(
                child: SizedBox(
                  width: 150,
                  child: isHeading
                      ? Align(
                          alignment: Alignment.center,
                          child: Text(
                            actions.tr(),
                            style: CustomFontStyle.regularText.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Palette.primary,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: onTap,
                                child: Image.asset(
                                  Assets.greenPile,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
