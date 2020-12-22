// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// const baseUrl = 'http://report.bekhoe.vn';

// class ApiService {
//   static final ApiService _apiService = ApiService._internal();

//   factory ApiService() {
//     return _apiService;
//   }

//   ApiService._internal();

//   Future<void> request({
//     @required String path,
//     @required Method method,
//     Map<String, dynamic> parameters,
//     Map<String, String> headers,
//     Function(dynamic) onSuccess,
//     Function(String) onFailure,
//   }) async {
//     parameters ??= {};
//     headers ??= {};

// //		final token = sharedPreferencesManager.getToken();
//     final token = 'sharedPreferencesManager.getToken()';
//     final accessToken = 'Bearer $token';

//     final _headers = {
//       'authorization': accessToken,
//     }..addAll(headers);

//     print(baseUrl + path);
//     try {
//       http.Response response;

//       switch (method) {
//         case Method.get:
//           response = await http.get(baseUrl + path, headers: _headers);
//           break;
//         case Method.post:
//           response = await http.post(
//             baseUrl + path,
//             headers: _headers,
//             body: parameters,
//             encoding: utf8,
//           );
//           break;
//         case Method.put:
//           response = await http.put(
//             baseUrl + path,
//             headers: _headers,
//             body: parameters,
//             encoding: utf8,
//           );
//           break;
//         case Method.delete:
//           response = await http.delete(baseUrl + path, headers: _headers);
//           break;
//         default:
//           break;
//       }

//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         final json = jsonDecode(response.body);

//         final code = json['code'];
//         if (code == 0) {
//           onSuccess(json['data']);
//         } else {
//           print(json['message']);
//           onFailure(json['message']);
//         }
//       } else if (response.statusCode == 401) {
//         onFailure("Phiên đăng nhập đã hết hạn!");
//         logout();
//       } else {
//         print('api error: ${baseUrl + path}');
//         print('http status code: ${response.statusCode} \n ${response.body}');
//         onFailure('${response.statusCode}: ${response.body}');
//       }
//     } catch (e) {
//       print('api_service try catch: ${baseUrl + path}');
//       print(e);
//       onFailure(e.toString());
//     }
//   }

//   void logout() {
//     print('logout');
// //		myNavigatorKey.currentState.pushNamedAndRemoveUntil(login, (_) => false);
//   }
// }

// final ApiService apiService = ApiService();

// enum Method { get, post, put, delete }
