import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../blocs/profile_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_app/utilities/toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _textPhoneNumber = TextEditingController();
  final _textName = TextEditingController();
  final _textRegPass = TextEditingController();
  final _textEmail = TextEditingController();

  RegisterBloc bloc = RegisterBloc();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.green,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
            child: StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  String err;
                  if (snapshot.hasError) {
                    err = snapshot.error;
                  }
                  return buiBody(err);
                })),
      ),
    );
  }

  Widget buiBody(err) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 33),
      child: Column(
        children: [
          Container(
            child: Image.asset('images/logo.png'),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            height: 45,
            child: TextField(
              controller: _textName,

              onChanged: (value) {},

              //keyboardType: TextInputType.,

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Họ & tên',
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 45,

            //color: Colors.blue,

            //padding: const EdgeInsets.fromLTRB(0, 33, 0, 33),

            child: TextField(
              controller: _textPhoneNumber,
              onChanged: (value) {},
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),

                labelText: 'Số điện thoại',

                // enabledBorder: OutlineInputBorder(

                // )
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 45,

            //color: Colors.blue,

            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),

            child: TextField(
              controller: _textRegPass,
              onChanged: (value) {},
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),

                labelText: 'Mật khẩu',

                // enabledBorder: OutlineInputBorder(

                // )
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  return Container(
                    width: 130,
                    child: RaisedButton(
                      color: Colors.green[700],
                      onPressed: () {
                        if (snapshot.hasError) {
                         
                          ToastWidget(context)
                              .show(text: snapshot.error, toastType: ToastType.error);
                        }
                        if (_textName.text.isNotEmpty &&
                            _textPhoneNumber.text.isNotEmpty &&
                            _textRegPass.text.isNotEmpty) {
                          bloc.RegisterAcc(_textName.text, _textPhoneNumber.text,
                              _textRegPass.text);
                        } else {
                          ToastWidget(context).show(
                              text: 'Vui lòng nhập đủ dữ liệu',
                              toastType: ToastType.warning);

                          ;
                        }
                      },
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  );
                }
              )
            ],
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            // color: Colors.blue,

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
                  style: TextStyle(color: Colors.green[700], fontSize: 18),
                )
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}
