import 'package:flutter/material.dart';

import '../../../../../main_barrel.dart';

class TotalRowWidget extends StatelessWidget {
  final String title;
  final double totalPrice;
  final double tax;
  final double discount;
  final bool requiresCalculatedTotal;

  const TotalRowWidget({
    super.key,
    required this.title,
    this.totalPrice = 0.0,
    this.tax = 0.0,
    this.discount = 0.0,
    this.requiresCalculatedTotal = false,
  });

  double get grandTotal {
    // Calculate grand total only if both tax and discount are available
    if (tax > 0.0 || discount > 0.0) {
      return totalPrice + tax - discount;
    }
    return 0.0; // If no tax or discount, return 0.0
  }

  @override
  Widget build(BuildContext context) {
    // Decide what amount to display based on widget title and parameters
    double displayedAmount;

    if (requiresCalculatedTotal) {
      // Show calculated amount after tax and discount deductions
      displayedAmount = grandTotal;
    } else if (title.toLowerCase() == 'tax' && tax > 0.0) {
      displayedAmount = tax;
    } else if (title.toLowerCase() == 'discount' && discount > 0.0) {
      displayedAmount = discount;
    } else {
      // Default case, just show the totalPrice if no tax or discount
      displayedAmount = totalPrice;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              CustomFontStyle.regularText.copyWith(fontWeight: FontWeight.bold),
        ),
        Text('IQR: ${displayedAmount.toStringAsFixed(2)}'),
      ],
    );
  }
}
