import 'dart:convert';
import 'dart:developer';

import 'package:pharmacy_assist/models/return_product_model.dart';

import '../main_barrel.dart';
import '../utils/shared_pref.dart';
import 'package:http/http.dart' as http;

class ReturnsRepo {
  static final instance = ReturnsRepo();

  Future<List<Return>> fetchAllReturns() async {
    final url = Uri.parse(
        '${baseUrl}pharmacy/sale/returns/${SharedPref.getString(key: 'uid')}');

    try {
      final response = await http.get(url, headers: headers);
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        List<dynamic> list = data['returns']; // get the list of products
        List<Return> products = list
            .map((e) => Return.fromJson(e))
            .toList(); // map raw data to Product model
        return products;
      } else {
        throw {"error": data['error']};
      }
    } catch (e) {
      throw {"Exception": e.toString()};
    }
  }

  Future<Map<String, dynamic>> returnAllSales(String saleId) async {
    final url = Uri.parse(
        '${baseUrl}pharmacy/sale/return-all/${SharedPref.getString(key: 'uid')}/$saleId');

    try {
      final response = await http.post(url);

      // Decode the JSON response
      var data = jsonDecode(response.body);

      log(data.toString()); // Log the data to debug

      // Check if 'success' exists and is true
      if (data['success'] == true) {
        return {
          "message": data['message'] ??
              "No message provided", // Provide default fallback
          "amountToBeReturned": data['amountToBeReturned'] ??
              0.0, // Ensure a default numeric value
        };
      } else {
        return {
          "error":
              data['error'] ?? "Unknown error", // Provide fallback for 'error'
          "success": false,
        };
      }
    } catch (e) {
      log(e.toString());
      return {
        "Exception": e.toString(),
      };
    }
  }
}
