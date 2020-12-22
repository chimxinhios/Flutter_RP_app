import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:report_app/models/issue.dart';
import 'package:report_app/models/issue.dart';
import 'package:report_app/screen/home.dart';
import 'package:report_app/utilities/system.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:report_app/models/user.dart';
import 'package:report_app/utilities/navigator.dart';
import 'package:report_app/utilities/shared_preferences_manager.dart';
import 'package:report_app/utilities/toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screen/home.dart';

class ProfileBloc {
  var checkAvata;
  StreamController _streamController;
  StreamSink<User> get sink => _streamController.sink;
  Stream<User> get stream => _streamController.stream;
  ProfileBloc() {
    _streamController = StreamController<User>.broadcast();
  }
  StreamController man = new StreamController();
  Stream get gender => man.stream;
  void dispose() {
    _streamController.close();
  }

  Future<dynamic> updateprofile(
      name, email, address, dateOfBirth, String avatar, context) async {
    Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'address': address,
      'dateOfBirth': dateOfBirth,
      //'avatar' : avatar
      //'gender': true,
      'Avatar': avatar
    };

    var token = sharedPreferencesManager.getString('token');
    print("toke = $token");
    var headers = {'Authorization': 'Bearer $token'};
    final url = 'http://report.bekhoe.vn/api/accounts/update';
    final response = await http.post(url, body: data, headers: headers);
    print('status : ${response.statusCode}');
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final json = jsonDecode(response.body);
      print(json['code']);
      print(json['avatar']);
      if (json['code'] == 0) {
        ToastWidget(context).show(
            toastType: ToastType.success, text: 'Đổi thông tin thành công');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()),
            result: (route) => false);
      } else {
        print(json['message']);
        ToastWidget(context)
            .show(text: '${json['message']}', toastType: ToastType.error);
      }
    }

    //return Navigator.pop(name);
  }

  Future getProfile() async {
    final url = 'http://report.bekhoe.vn/api/accounts/profile';
    var token = sharedPreferencesManager.getString('token');
    //print("toke = $toke");
    var headers = {'Authorization': 'Bearer $token'};
    var json;
    final response = await http.get(
      url,
      headers: headers,
    );
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      json = jsonDecode(response.body);
      // print(json);
      print('get thanh cong');
      var data = json['data'];
      // print('avatar : ${data['avatar']}');
      final user = User.fromJson(data);
      sink.add(user);
    }
  }
}

class LoginBloc {
  StreamController _textInputId = new StreamController();
  StreamController _textInputPass = new StreamController();

  Stream get idStream => _textInputId.stream;
  Stream get passStream => _textInputPass.stream;

  Future CheckLogin(id, pass, context) async {
    Map data = {"phoneNumber": id, 'Password': pass};
    if (data['phoneNumber'].toString().length < 2) {
      print('id qua ngan');
    }
    final url = 'http://report.bekhoe.vn/api/accounts/login';
    final response = await http.post(url, body: data);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final json = jsonDecode(response.body);
      var token = json['data']['token'];

      if (json['code'] == 0) {
        sharedPreferencesManager.saveString('token', token);
        print('Login thanh cong');

        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Home()));
      } else {
        print(json['message']);
        ToastWidget(context)
            .show(text: '${json['message']}', toastType: ToastType.error);
      }
    } else {
      ToastWidget(context)
          .show(text: 'Lỗi ${response.statusCode}', toastType: ToastType.error);
    }
  }
}

class ChangePassBloc {
  Future ChangePassword(oldpass, newPass, context) async {
    Map dataPass = {'OldPassword': oldpass, 'NewPassword': newPass};
    final url = 'http://report.bekhoe.vn/api/accounts/changePassword';
    var token = sharedPreferencesManager.getString('token');
    //print("token = $token");
    var headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(url, headers: headers, body: dataPass);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final json = jsonDecode(response.body);

      if (json['code'] == 0) {
        print('Doi mat khau thanh cong');
        ToastWidget(context).show(
            toastType: ToastType.success, text: 'Đổi mật khẩu thành công');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()),
            result: (route) => false);
      } else {
        print(json['message']);
        ToastWidget(context)
            .show(text: '${json['message']}', toastType: ToastType.error);
      }
    } else {
      ToastWidget(context)
          .show(text: 'Lỗi ${response.statusCode}', toastType: ToastType.error);
    }
  }
}

class SendReport {
  Future Send(title, content, context) async {
    Map dataReport = {'Title': title, 'Content': content, 'Photos': ''};
    final url = 'http://report.bekhoe.vn/api/issues';
    var token = sharedPreferencesManager.getString('token');

    var headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(url, headers: headers, body: dataReport);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final json = jsonDecode(response.body);

      if (json['code'] == 0) {
        print('RP thanh cong ');
        ToastWidget(context)
            .show(toastType: ToastType.success, text: 'Đã gửi báo cáo');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()),
            result: (route) => false);
      } else {
        ToastWidget(context)
            .show(text: '${json['message']}', toastType: ToastType.error);
        print(json['message']);
      }
    } else {
      ToastWidget(context)
          .show(text: 'Lỗi ${response.statusCode}', toastType: ToastType.error);
    }
  }
}

class RegisterBloc {
  StreamController _homeController;
  StreamSink get sink => _homeController.sink;
  Stream get stream => _homeController.stream;
  RegisterBloc() {
    _homeController = StreamController.broadcast();
  }
  void dispose() {
    _homeController.close();
  }

  Future RegisterAcc(name, id, pass) async {
    Map data = {
      "phoneNumber": id,
      'Password': pass,
      'Name': name,
    };
    BuildContext context;

    final url = 'http://report.bekhoe.vn/api/accounts/Register';
    final response = await http.post(url, body: data);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final json = jsonDecode(response.body);
      print(json['message']);
      sink.addError(json['message']);
      ToastWidget(context).show(text: json['message'],toastType: ToastType.warning);
    } else {
      ToastWidget(context).show(text: "Lỗi ${response.statusCode}");
    }
  }
}

class HomeBloc {
  StreamController _homeController;
  StreamSink get sink => _homeController.sink;
  Stream get stream => _homeController.stream;
  HomeBloc() {
    _homeController = StreamController.broadcast();
  }
  void dispose() {
    _homeController.close();
  }

  Future getIssue(offset) async {
    final url = 'http://report.bekhoe.vn/api/issues?limit=3&offset=$offset';
    var token = sharedPreferencesManager.getString('token');
    var headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(
      url,
      headers: headers,
    );

    var json;
    BuildContext context;
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      json = jsonDecode(response.body);
      print('get thanh cong');

      final List data = json['data'];

      final issue = List.from(data);
      print('ok');
      sink.add(issue);

      print('add ok');
    } else {
      ToastWidget(context)
          .show(text: 'Lỗi ${response.statusCode}', toastType: ToastType.error);
    }
  }
}

class UploadFile {
  Future UploadFileImage(image, context) async {
    final url = 'http://report.bekhoe.vn/api/upload';
    final account = sharedPreferencesManager.getString('token');
    final accessToken = 'Bearer $account';

    final headers = {
      'authorization': accessToken,
    };

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.headers.addAll(headers);
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      await image.readAsBytes(),
      filename: image.path.split('/').last ?? 'pepe.jpg',
    ));

    final stream = await request.send();
    final response = await http.Response.fromStream(stream);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final json = jsonDecode(response.body);
      print(json);
      if (json['code'] == 0) {
        print('Upload thanh cong');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()),
            result: (route) => false);
      } else {
        print(json['message']);
      }
    }
  }
}
