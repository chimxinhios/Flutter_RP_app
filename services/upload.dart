// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:report_issue/utilities/shared_preferences_manager.dart';
// import 'api_service.dart';

// extension UploadService on ApiService {
// 	Future<void> upload(
// 			File image,
// 			Function(String) onSuccess,
// 			Function(String) onFailure,
// 			) async {
// 		final account = sharedPreferencesManager.getAccount();
// 		final accessToken = 'Bearer ${account?.token}';

// 		final headers = {
// 			'authorization': accessToken,
// 		};

// 		final request = http.MultipartRequest(
// 				'POST', Uri.parse(baseUrl + '/api/user/v2/upload'));
// 		request.headers.addAll(headers);
// 		request.files.add(http.MultipartFile.fromBytes(
// 			'file',
// 			await image.readAsBytes(),
// 			filename: image.path.split('/').last ?? 'hieutao.jpg',
// 		));

// 		final stream = await request.send();
// 		final response = await http.Response.fromStream(stream);

// 		if (response.statusCode >= 200 && response.statusCode < 300) {
// 			final json = jsonDecode(response.body);
// 			final code = json['code'];
// 			if (code == 0) {
// //				final photo = Photo.fromJson(json['data']);
// //				onSuccess(photo.url);
// 			} else {
// 				print(json['message']);
// 				onFailure(json['message']);
// 			}
// 		} else if (response.statusCode == 401) {
// 			onFailure("Phiên đăng nhập đã hết hạn!");
// 			logout();
// 		} else {
// 			print('upload avatar error');
// 			print('http status code: ${response.statusCode} \n ${response.body}');
// 			onFailure('${response.statusCode}: ${response.body}');
// 		}
// 	}
// }
