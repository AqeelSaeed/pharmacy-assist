import 'package:flutter/material.dart';
import 'package:pharmacy_assist/main_barrel.dart';

class PharmacyDashboard extends StatefulWidget {
  const PharmacyDashboard({super.key});

  @override
  State<PharmacyDashboard> createState() => _PharmacyDashboardState();
}

class _PharmacyDashboardState extends State<PharmacyDashboard> {
  List<Map<String, dynamic>> items = [
    {
      'icon': Icons.attach_money,
      'title': 'Net Sales',
      'amount': '0.00',
      'iconBackgroundColor': const Color(0xff47A3FF),
    },
    {
      'icon': Icons.monetization_on,
      'title': 'Total Revenue',
      'amount': '0.00',
      'iconBackgroundColor': const Color(0xffFFC107),
    },
    {
      'icon': Icons.monetization_on,
      'title': 'Total Revenue',
      'amount': '0.00',
      'iconBackgroundColor': const Color.fromARGB(255, 7, 255, 102),
    },
    {
      'icon': Icons.monetization_on,
      'title': 'Total Revenue',
      'amount': '0.00',
      'iconBackgroundColor': const Color.fromARGB(255, 73, 7, 255),
    },
  ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    context.locale.languageCode;
    return Responsive(
      desktop: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: PharmacyOverviewCard()),
                    if (Responsive.isLargeDesktop(context))
                      const SizedBox(width: 20),
                    if (Responsive.isLargeDesktop(context))
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: StatsCard(
                                      height: 130,
                                      iconBackgroundColor: Palette.blueColor,
                                      iconPath: Assets.netSales,
                                      title: totalSales.tr(),
                                      value: '29.0'),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: StatsCard(
                                      height: 130,
                                      iconBackgroundColor: Palette.parrotGreen,
                                      iconPath: Assets.netReturns,
                                      title: totalReturns.tr(),
                                      value: '29.0'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: StatsCard(
                                      height: 130,
                                      iconBackgroundColor: Palette.green,
                                      iconPath: Assets.netRevenue,
                                      title: totalRevenue.tr(),
                                      value: '29.0'),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: StatsCard(
                                      height: 130,
                                      iconBackgroundColor: Palette.orangeColor,
                                      iconPath: Assets.netProfit,
                                      title: totalProfit.tr(),
                                      value: '29.0'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                if (!Responsive.isLargeDesktop(context))
                  ResponsiveAligner(
                    rows: Responsive.isDesktopWithoutDrawer(context) ? 1 : 2,
                    children: [
                      DashboardChartView(
                        title: totalSales.tr(),
                        chartData: const [],
                        graphColor: Palette.blueColor,
                      ),
                      DashboardChartView(
                        title: totalReturns.tr(),
                        chartData: const [],
                        graphColor: Palette.parrotGreen,
                      ),
                      DashboardChartView(
                        title: totalRevenue.tr(),
                        chartData: const [],
                        graphColor: Palette.green,
                      ),
                      DashboardChartView(
                        title: totalProfit.tr(),
                        chartData: const [],
                        graphColor: Palette.orangeColor,
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                ResponsiveAligner(
                    rows: Responsive.isMobile(context) ? 4 : 2,
                    children: [
                      DashboardChartView(
                        title: totalSales.tr(),
                        chartData: const [],
                        graphColor: Palette.blueColor,
                      ),
                      DashboardChartView(
                        title: totalReturns.tr(),
                        chartData: const [],
                        graphColor: Palette.parrotGreen,
                      ),
                      DashboardChartView(
                        title: totalRevenue.tr(),
                        chartData: const [],
                        graphColor: Palette.green,
                      ),
                      DashboardChartView(
                        title: totalProfit.tr(),
                        chartData: const [],
                        graphColor: Palette.orangeColor,
                      ),
                    ]),
                const SizedBox(height: 30),
              ],
            ),
          )),
    );
  }
}
