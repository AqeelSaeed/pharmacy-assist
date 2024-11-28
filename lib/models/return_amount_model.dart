class ReturnAmountModel {
  String? customer;
  double? previousTotal;
  double? returnAmount;
  DateTime? date;
  String? actions;

  ReturnAmountModel({
    this.customer,
    this.previousTotal,
    this.returnAmount,
    this.date,
    this.actions,
  });

  // Encoder: Converts the ReturnAmountModel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'customer': customer,
      'previousTotal': previousTotal,
      'returnAmount': returnAmount,
      'date': date?.toIso8601String(), // DateTime encoded as ISO 8601 string
      'actions': actions,
    };
  }

  // Decoder: Converts a JSON map to a ReturnAmountModel object
  factory ReturnAmountModel.fromJson(Map<String, dynamic> json) {
    return ReturnAmountModel(
      customer: json['customer'],
      previousTotal: json['previousTotal']?.toDouble(),
      returnAmount: json['returnAmount']?.toDouble(),
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      actions: json['actions'],
    );
  }

  // toString method for debugging or logging purposes
  @override
  String toString() {
    return 'ReturnAmountModel(customer: $customer, previousTotal: $previousTotal, returnAmount: $returnAmount, date: $date, actions: $actions)';
  }
}
