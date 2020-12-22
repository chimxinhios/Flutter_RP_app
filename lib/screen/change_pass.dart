import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:report_app/blocs/profile_bloc.dart';
import 'package:report_app/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:report_app/utilities/shared_preferences_manager.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final _OldPass = TextEditingController();
  final _newPass = TextEditingController();
  final _rePass = TextEditingController();
  ChangePassBloc bloc = ChangePassBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đổi mật khẩu'),
        centerTitle: true,
        backgroundColor: Colors.green[600],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(32, 2, 30, 2),
              //color: Colors.blue,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 40,
                      // margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      //padding: const EdgeInsets.fromLTRB(11, 0, 11, 8),
                      child: TextField(
                        controller: _OldPass,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              //borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                            color: Colors.grey[400],
                          )),
                          labelText: "Mật khẩu cũ",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 40,
                      //margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      //padding: const EdgeInsets.fromLTRB(11, 0, 11, 8),
                      child: TextField(
                        controller: _newPass,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              //borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                            color: Colors.grey[400],
                          )),
                          labelText: "Mật khẩu mới",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      //color: Colors.blue,
                      height: 40,
                      //margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      // padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: TextField(
                        controller: _rePass,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                            color: Colors.grey[400],
                          )),
                          labelText: "Nhập lại mật khẩu mới",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                        width: double.maxFinite,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                //borderRadius: BorderRadius.circular(8)
                                ),
                            onPressed: () {
                              if (_OldPass.text.isNotEmpty &&
                                  _newPass.text.isNotEmpty &&
                                  _newPass.text == _rePass.text) {
                                bloc.ChangePassword(
                                    _OldPass.text, _newPass.text, context);
                              }
                            },
                            child: Text('Lưu',
                                style: TextStyle(color: Colors.white)),
                            color: Colors.green[600]))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
