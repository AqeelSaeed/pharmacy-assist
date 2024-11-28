class ChartDataModel {
  final DateTime date;
  double value;

  ChartDataModel(this.date, this.value);

  // Dummy data generator
  static List<ChartDataModel> generateDummyData() {
    final startDate = DateTime.now().subtract(const Duration(days: 6));
    final List<ChartDataModel> dummyData = [];

    for (int i = 0; i < 7; i++) {
      final date = startDate.add(Duration(days: i));
      final value = i.toDouble() +
          1.0; // Replace this with your desired logic for generating the value
      final chartData = ChartDataModel(date, value);
      dummyData.add(chartData);
    }

    return dummyData;
  }
}
