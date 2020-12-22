import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_app/blocs/profile_bloc.dart';
import 'package:report_app/screen/home.dart';
import 'package:report_app/models/user.dart';
import 'package:report_app/screen/reg.dart';
import 'package:http/http.dart' as http;
import 'package:report_app/services/api_service.dart';
import 'package:report_app/utilities/shared_preferences_manager.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc bloc = LoginBloc();
  // File _image;
  // final picker = ImagePicker();

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  bool login = false;
  final _textInputId = TextEditingController();
  final _textInputPass = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    //bloc.CheckLogin(_textInputId, _textInputPass, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(28, 80, 28, 33),
            child: Column(
              children: [
                Container(
                  child: Image.asset('images/logo.png'),
                ),
                SizedBox(
                  height: 44,
                ),
                StreamBuilder<Object>(
                    stream: bloc.idStream,
                    builder: (context, snapshot) {
                      return Container(
                        height: 45,
                        child: TextField(
                          controller: _textInputId,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Số điện thoại',
                              errorText: snapshot.data),
                        ),
                      );
                    }),
                SizedBox(
                  height: 18,
                ),
                StreamBuilder<Object>(
                    stream: bloc.passStream,
                    builder: (context, snapshot) {
                      return Container(
                        height: 45,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: TextField(
                          controller: _textInputPass,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Mật khẩu',
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Register()));
                      },
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 130,
                      child: RaisedButton(
                        color: Colors.green[700],
                        onPressed: () {
                          bloc.CheckLogin(
                              _textInputId.text, _textInputPass.text, context);
                          //loginAction();
                          // var inputId = _textInputId.text;
                          // var inputPass = _textInputPass.text;
                          // if (inputId.isNotEmpty && inputPass.isNotEmpty) {
                          //   CheckLogin(inputId, inputPass, context);
                          // }
                        },
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 150,
                  // child: RaisedButton(
                  //   onPressed: getImage,
                  //   child: Text('data'),
                  // ),
                ),
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hotline :  ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '0123456789',
                        style:
                            TextStyle(color: Colors.green[700], fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Future CheckLogin(id, pass, context) async {
//   Map data = {"phoneNumber": id, 'Password': pass};

//   final url = 'http://report.bekhoe.vn/api/accounts/login';
//   final response = await http.post(url, body: data);
//   if (response.statusCode >= 200 && response.statusCode <= 299) {
//     final json = jsonDecode(response.body);
//     var token = json['data']['token'];

//     if (json['code'] == 0) {
//       sharedPreferencesManager.saveString('token', token);
//       //print('token : ${sharedPreferencesManager.getString('token')}');
//       //await Saveprofile(context);
//       Navigator.push(context,
//           MaterialPageRoute(builder: (BuildContext context) => Home()));
//     }
//     if (json['code'] == 500) {
//       print(json['message']);
//     }
//   }
// }

// Future Saveprofile(context) async {
//   final url = 'http://report.bekhoe.vn/api/accounts/profile';
//   var token = sharedPreferencesManager.getString('token');

//   var headers = {'Authorization': 'Bearer $token'};
//   var json;
//   final response = await http.get(
//     url,
//     headers: headers,
//   );
//   print(response.statusCode);
//   if (response.statusCode >= 200 && response.statusCode <= 299) {
//     json = jsonDecode(response.body);
//     print(json);

//     print('get thanh cong');
//     var savedataprofile = json['data'];
//     print('a : $savedataprofile');
//     // sharedPreferencesManager.save('profile', savedataprofile);

//     final user = User.fromJson(savedataprofile);

//   }
// }
