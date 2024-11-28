import 'dart:convert';
import 'dart:developer';
import 'package:pharmacy_assist/main_barrel.dart';
import 'package:http/http.dart' as http;

class DrugDepotRepo {
  static final instance = DrugDepotRepo();

  Future<List<DrugDepot>> fetchDepos() async {
    final url = Uri.parse('${baseUrl}auth/getAll/drugDepot');
    log('depo url: $url');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('deposResponse: $data');
        if (data['success'] == true) {
          List<dynamic> list = data['users']; // get the list of DrugDepots
          List<DrugDepot> depotList = list
              .map((e) => DrugDepot.fromJson(e))
              .toList(); // map raw data to DrugDepot model
          return depotList;
        } else {
          throw Exception(data['message'] ?? 'Failed to fetch DrugDepots');
        }
      } else {
        throw Exception('Failed to load DrugDepots: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
