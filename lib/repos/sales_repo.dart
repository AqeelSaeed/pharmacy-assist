import 'dart:convert';
import 'dart:developer';
import '../main_barrel.dart';
import '../utils/shared_pref.dart';
import 'package:http/http.dart' as http;

class SalesRepo {
  static final instance = SalesRepo();

  Future<List<Sale>> fetchSales() async {
    final url = Uri.parse(
        '${baseUrl}pharmacy/sales/${SharedPref.getString(key: 'uid')}');
    log('apiUrl: $url');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          List<dynamic> list = data['sales'];
          List<Sale> sales = list.map((e) => Sale.fromJson(e)).toList();
          return sales;
        } else {
          log('success false: ${data['message']}');
          throw Exception(data['error'] ?? 'Failed to fetch products');
        }
      } else {
        log('errorREsponse: ${response.body}');
        throw Exception('Something went wrong.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void printCustomListDetails(List<ProductModel> products) {
    for (int i = 0; i < products.length; i++) {
      log('Index: $i, Product ID: ${products[i].id}, Type: ${products[i].runtimeType}');
    }
  }
}
