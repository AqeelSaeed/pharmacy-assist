import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../main_barrel.dart';

class DashboardChartView extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<ChartDataModel> chartData;
  final double? width;
  final double borderRadius;
  final Color? graphColor;

  const DashboardChartView({
    super.key,
    required this.title,
    this.subtitle,
    this.width,
    this.borderRadius = 10,
    required this.graphColor,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    context.locale.languageCode;
    return SizedBox(
      width: width,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.03),
              offset: Offset(0, 100),
              blurRadius: 80,
            ),
          ],
          border: Border.all(color: Palette.border, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                Text(
                  subtitle ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w400, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SfCartesianChart(
              enableAxisAnimation: true,
              tooltipBehavior: TooltipBehavior(enable: true),
              plotAreaBorderWidth: 0,
              borderWidth: 0,
              // title: ChartTitle(
              //   text: widget.subtitle,
              //   textStyle: Theme.of(context).textTheme.bodySmall,
              // ),
              series: getDefaultData(),
              primaryXAxis: DateTimeAxis(
                rangePadding: chartData.isEmpty
                    ? ChartRangePadding.auto
                    : ChartRangePadding.auto,
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                dateFormat: DateFormat.Md(),
                majorGridLines: const MajorGridLines(width: 0),
                axisLine: const AxisLine(width: 2),
                majorTickLines: const MajorTickLines(size: 0),
                intervalType: DateTimeIntervalType.days,
                initialVisibleMinimum:
                    chartData.isEmpty ? DateTime.now() : null,
                labelStyle: const TextStyle(
                    color: Palette.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              primaryYAxis: NumericAxis(
                  initialVisibleMaximum: chartData.isEmpty ? 5 : null,
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  majorGridLines: const MajorGridLines(width: 0),
                  axisLine: const AxisLine(width: 2),
                  majorTickLines: const MajorTickLines(size: 0),
                  rangePadding: ChartRangePadding.auto,
                  labelStyle: const TextStyle(
                      color: Palette.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
            ),
          ]),
        ),
      ),
    );
  }

  List<SplineAreaSeries<ChartDataModel, DateTime>> getDefaultData() {
    return <SplineAreaSeries<ChartDataModel, DateTime>>[
      SplineAreaSeries<ChartDataModel, DateTime>(
        color: graphColor,
        animationDelay: 2,
        animationDuration: 3,
        markerSettings: MarkerSettings(
          isVisible: chartData.isEmpty ? false : true,
        ),
        dataSource: chartData,
        xValueMapper: (ChartDataModel sales, _) => sales.date,
        yValueMapper: (ChartDataModel sales, _) => sales.value,
      ),
    ];
  }
}
