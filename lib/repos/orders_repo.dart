import 'dart:convert';
import 'dart:developer';
import '../main_barrel.dart';
import '../utils/shared_pref.dart';
import 'package:http/http.dart' as http;

class POSTransactionRepo {
  static final instance = POSTransactionRepo();

  Future<Map<String, dynamic>> checkoutOrder(
      {required String customerName,
      required List<ProductModel> list,
      required double totalAmount}) async {
    final url = Uri.parse(
        '${baseUrl}pharmacy/checkout/${SharedPref.getString(key: 'uid')}');
    log('apiUrl: $url');
    log('prdouctModel: ${list.first.toJson()}');

    try {
      final body = jsonEncode({
        "customerName": customerName,
        "cartItemList": list.map((item) => item.toJson()).toList(),
        "totalAmount": totalAmount,
      });

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log('apiSuccessResponse: $data');
        if (data['success'] == true) {
          log('dataTrue: ${data['message']}');
          return {
            'success': true,
            'message': data['message'],
            'sale': data['sale']
          };
        } else {
          log('dateFalse: $data');
          return {
            'success': false,
            'message': data['error'] ?? 'Failed to process order.'
          };
        }
      } else {
        log('apiErrorResponse: ${response.body}');
        return {'success': false, 'message': '${data['message']}'};
      }
    } catch (e) {
      log('Exception111: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}
