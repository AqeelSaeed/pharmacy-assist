import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../main_barrel.dart';

class PharmacyOverviewCard extends StatelessWidget {
  const PharmacyOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale.languageCode;
    return SizedBox(
      width: double.infinity,
      height: 306,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color(0xffD9ECFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.8.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '${goodMorning.tr()} ',
                            style: CustomFontStyle.regularText.copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                            ), // Normal style
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Mr. Herald',
                                style: CustomFontStyle.regularText.copyWith(
                                  fontSize: 20,
                                  color: Palette.primary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          stayUpdated.tr(),
                          style: CustomFontStyle.regularText,
                        ),
                        SizedBox(
                          height: 1.8.h,
                        ),
                        _CounterWidget(
                          iconPath: Assets.ordersIcon,
                          counterValue: 20,
                          title: totalOrders.tr(),
                        ),
                        SizedBox(
                          height: 1.8.h,
                        ),
                        _CounterWidget(
                          iconPath: Assets.expiriesIcon,
                          counterValue: 10,
                          title: totalExpirations.tr(),
                        ),
                      ],
                    ),
                  ),
                  if (!Responsive.isExtraSmallDevice(context))
                    Image.asset(
                      Assets.dummyParmacy1,
                      height:
                          Responsive.isExtraSmallDevice(context) ? 100 : 200,
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CounterWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final double counterValue;
  const _CounterWidget({
    required this.iconPath,
    required this.title,
    required this.counterValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 62,
          width: 62,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xffADD6FF)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              iconPath,
              color: Palette.primary,
            ),
          ),
        ),
        SizedBox(
          width: 1.5.h,
        ),
        Padding(
          padding: EdgeInsets.only(top: 1.2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: CustomFontStyle.regularText,
              ),
              Text(
                counterValue.toString(),
                style: CustomFontStyle.regularText.copyWith(
                    fontWeight: FontWeight.bold, color: Palette.primary),
              ),
            ],
          ),
        )
      ],
    );
  }
}
