import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main_barrel.dart';
import '../utils/shared_pref.dart';

class AuthRepo {
  static final instance = AuthRepo();

  late LoginModel loginModel;
  late ErrorResponseModel errorModel;
  late SignupResponseModel signupResponseModel;
  String uid = '';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Uri url = Uri.parse('${baseUrl}auth/login');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await SharedPref.saveString(key: 'uid', value: data['user']['uid']);
      await SharedPref.saveString(key: 'role', value: data['user']['role']);
      await SharedPref.saveString(
        key: 'user',
        value: jsonEncode(data['user']),
      );
      return data;
    } else {
      throw data['error'];
    }
  }

  Future<Map<String, dynamic>> getAuthUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    String? role = prefs.getString('role');
    log('uid: $uid');
    String? userInfoString = prefs.getString('user');
    if (uid == null || role == null || userInfoString == null) {
      throw Exception('No user info saved.');
    }
    Map<String, dynamic> userInfo = jsonDecode(userInfoString);
    return {'uid': uid, 'role': role, 'user': userInfo};
  }

  Future<SignupResponseModel?> signup(Map<String, dynamic> formData,
      Function onSuccess, Function onFailed) async {
    String apiUrl = '${baseUrl}auth/register';
    log('message: signup caleed');
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      log('message: $request');
      formData.forEach((key, value) {
        if (value is! File) {
          request.fields[key] = value.toString();
        }
      });

      if (formData['profilePicture'] != null &&
          formData['profilePicture'] is File) {
        File profilePicture = formData['profilePicture'];
        request.files.add(
          http.MultipartFile.fromBytes(
            'profilePicture',
            await profilePicture.readAsBytes(),
            filename: 'profilePicture.png',
            contentType: MediaType('image', 'png'),
          ),
        );
      }

      if (formData['certificate'] != null && formData['certificate'] is File) {
        File certificate = formData['certificate'];
        request.files.add(
          http.MultipartFile.fromBytes(
            'certificate',
            await certificate.readAsBytes(),
            filename: 'certificate.pdf',
            contentType: MediaType('application', 'pdf'),
          ),
        );
      }

      var response = await request.send();

      var responseData = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        var jsonData = json.decode(responseData.body);
        log('json data check kr lety h kya ata h? $jsonData');
        signupResponseModel = SignupResponseModel.fromJson(jsonData);

        if (signupResponseModel.success) {
          log('Signup successful: ${signupResponseModel.message}');
          onSuccess();
          return signupResponseModel;
        } else {
          onFailed();
          return null;
        }
      } else {
        errorModel = ErrorResponseModel.fromJson(jsonDecode(responseData.body));
        log('apiREsponse: ${responseData.body}');
        onFailed();
        return null;
      }
    } catch (e) {
      log('Error occurred during signup: $e');
      onFailed();
      return null;
    }
  }

  Future<Map<String, dynamic>> verficationEmail(String otp) async {
    final url = Uri.parse('${baseUrl}auth/verify');

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({'otp': otp}),
      );
      log(response.body);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (data['success'] == true) {
          String? uid = data.containsKey('uid') ? data['uid'] : null;
          log('uid....: $uid');
          return {
            'success': true,
            'message': data['message'],
            if (uid != null) 'uid': uid,
          };
        } else {
          return {
            'success': false,
            'message': data['error'] ?? 'Unknown error occurred'
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> forgotPassowrd(String email) async {
    final url = Uri.parse('${baseUrl}auth/forgotPassword');
    log('forgotUrl: $url');
    try {
      final response = await http.post(url,
          headers: headers, body: jsonEncode({'email': email}));
      log('forgotPasswordApiResponse: ${response.body}');
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (data['success'] == true) {
          return {'success': true, 'message': data['message']};
        } else {
          return {
            'success': false,
            'message': data['error'] ?? 'Unknown error occurred'
          };
        }
      } else {
        log('message: ${data['error']}');
        return {'success': false, 'message': 'Server error: ${data['error']}'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> changePassword(
      String newPassword, String confirmPassword, String uid) async {
    final url = Uri.parse('${baseUrl}auth/changePassword/$uid');
    try {
      final response = await http.post(url,
          headers: headers,
          body: jsonEncode({
            'password': newPassword,
            'password_confirmation': confirmPassword,
          }));
      log('forgotPasswordApiResponse: ${response.body}');
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (data['success'] == true) {
          return {'success': true, 'message': data['message']};
        } else {
          return {
            'success': false,
            'message': data['error'] ?? 'Unknown error occurred'
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
