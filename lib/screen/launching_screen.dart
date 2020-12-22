import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:report_app/screen/home.dart';
import 'package:report_app/screen/home.dart';
import 'package:report_app/screen/login.dart';
import 'package:report_app/utilities/navigator.dart';
import 'package:report_app/utilities/shared_preferences_manager.dart';

class LaunchingScreen extends StatefulWidget {
  @override
  _LaunchingScreenState createState() => _LaunchingScreenState();
}

class _LaunchingScreenState extends State<LaunchingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    gotoHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 96),
        child: Center(
          child: Image.asset('images/logo.png'),
        ),
      ),
    );
  }

  Future gotoHome() async {
    await SharedPreferencesManager().init();
    await Future.delayed(Duration(seconds: 1));
    var token = sharedPreferencesManager.getString('token');
    print('token : $token');
    if (token.length < 1 ) {
      navigatorPushAndRemoveUntil(context, Login());
    } else {
      navigatorPushAndRemoveUntil(context, Home());
    }
  }
}
