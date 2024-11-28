import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:pharmacy_assist/utils/shared_pref.dart';
import '../main_barrel.dart';

class ProductRepo {
  static final instance = ProductRepo();

  Future<List<ProductModel>> fetchProductList(String uid) async {
    log('uid: $uid');
    final url = Uri.parse('${baseUrl}products/$uid');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          List<dynamic> list = data['products'];
          List<ProductModel> products =
              list.map((e) => ProductModel.fromJson(e)).toList();

          return products;
        } else {
          throw Exception(data['message'] ?? 'Failed to fetch products');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      log('Exception: $e');
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> uploadCsvFile(
      String fileName, Uint8List bytes) async {
    final url = Uri.parse(
        '${baseUrl}product/bulkImport/${SharedPref.getString(key: 'uid')}');

    try {
      var request = http.MultipartRequest('POST', url);
      request.files
          .add(http.MultipartFile.fromBytes('file', bytes, filename: fileName));

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);
        if (data['success'] == true) {
          log('apiResponse: ${data['message']}');
          return {'success': true, 'message': data['message']};
        } else {
          return {
            'success': false,
            'message': data['error'] ?? 'Failed to upload CSV file.'
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Server Error: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> createProductWithImage({
    required String productName,
    required String barcode,
    required int boxQuantity,
    required int sheetInBox,
    required double costPrice,
    required double retailPrice,
    required String expiryDate,
    required String description,
    required String scientificName,
    required String source,
    required String orderNo,
    required int tableInSheet,
    required Uint8List imageBytes,
    required String uid,
  }) async {
    String apiUrl = '${baseUrl}product/create/$uid';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    request.fields['productName'] = productName;
    request.fields['barcode'] = barcode;
    request.fields['boxQuantity'] = boxQuantity.toString();
    request.fields['sheetInBox'] = sheetInBox.toString();
    request.fields['costPrice'] = costPrice.toString();
    request.fields['retailPrice'] = retailPrice.toString();
    request.fields['expiryDate'] = expiryDate;
    request.fields['description'] = description;
    request.fields['scientificName'] = scientificName;
    request.fields['source'] = source;
    request.fields['orderNo'] = orderNo;
    request.fields['tabletInSheet'] = tableInSheet.toString();

    request.files.add(
      http.MultipartFile.fromBytes(
        'productImage',
        imageBytes,
        filename: 'product_image.jpg',
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    request.headers['Content-Type'] = 'multipart/form-data';

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (data['success'] == true) {
          log('Product created successfully: ${response.body}');
          return {'success': true, 'message': data['message']};
        } else {
          log('Failed to create product: ${response.statusCode} ${response.body}');
          throw Exception(
              data['message'] ?? data['error'] ?? 'Unknown error occurred');
        }
      } else {
        throw Exception(
            data['message'] ?? data['error'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      log('Error occurred: $e');
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String productId) async {
    final url = Uri.parse(
        '${baseUrl}product/delete/${SharedPref.getString(key: 'uid')}/$productId');
    log('apiUrl: $url');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          log('Product deleted successfully: ${data['message']}');
          return {'success': true, 'message': data['message']};
        } else {
          return {
            'success': false,
            'message': data['error'] ?? 'Failed to delete product.'
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Server Error: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateProductWithImage({
    required String productId,
    required String productName,
    required String barcode,
    required double boxQuantity,
    required int sheetInBox,
    required double costPrice,
    required double retailPrice,
    required String expiryDate,
    required String description,
    required String scientificName,
    required String source,
    required String orderNo,
    required int tableInSheet,
    required Uint8List? imageBytes,
    required bool isPaid,
    required bool isBulkImport,
  }) async {
    String apiUrl =
        '${baseUrl}product/update/${SharedPref.getString(key: 'uid')}/$productId';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    request.fields['productName'] = productName;
    request.fields['barcode'] = barcode;
    request.fields['boxQuantity'] = boxQuantity.toString();
    request.fields['sheetInBox'] = sheetInBox.toString();
    request.fields['costPrice'] = costPrice.toString();
    request.fields['retailPrice'] = retailPrice.toString();
    request.fields['expiryDate'] = expiryDate;
    request.fields['description'] = description;
    request.fields['scientificName'] = scientificName;
    request.fields['source'] = source;
    request.fields['orderNo'] = orderNo;
    request.fields['tabletInSheet'] = tableInSheet.toString();
    request.fields['isPaid'] = isPaid ? '1' : '0';
    request.fields['isBulkImport'] = isBulkImport ? '1' : '0';
    if (imageBytes != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'productImage',
          imageBytes,
          filename: 'updated_product_image.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    request.headers['Content-Type'] = 'multipart/form-data';

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (data['success'] == true) {
          log('Product updated successfully: ${response.body}');
          return {'success': true, 'message': data['message']};
        } else {
          log('Failed to update product: ${response.statusCode} ${response.body}');
          throw Exception(
              data['message'] ?? data['error'] ?? 'Unknown error occurred');
        }
      } else {
        throw Exception(
            data['message'] ?? data['error'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      log('Error occurred: $e');
      throw Exception(e.toString());
    }
  }
}
