import 'package:flutter/material.dart';
import 'package:report_app/blocs/profile_bloc.dart';
import 'package:report_app/screen/webview_screen.dart';
import 'package:report_app/utilities/navigator.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  ProfileBloc bloc = ProfileBloc();
  @override
  void initState() {
    // TODO: implement initState
    bloc.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text('Liên hệ'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Container(
                    height: 25,
                    child: Row(
                      children: [
                        Text(
                          'Địa chỉ:  ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text('Vietnam'),
                      ],
                    ),
                  ),
                  Container(
                    height: 25,
                    child: Row(
                      children: [
                        Text(
                          'Hotline:  ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text('0123456789'),
                      ],
                    ),
                  ),
                  Container(
                    height: 25,
                    child: Row(
                      children: [
                        Text(
                          'Email:  ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text('Colucnatrat92@gmail.com'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              //color: Colors.blue,
              padding: const EdgeInsets.fromLTRB(25, 18, 25, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nội dung phản hồi'),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedButton(
                        color: Colors.green[600],
                        onPressed: () {
                          navigatorPush(context, WebViewScreen());
                          //_urlTest();
                        },
                        child:
                            Text('Gửi', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void urlTest() {
    print('ural');
  }

  _urlTest() async {
    const url = 'https://flutter.dev';
    print('ok');
    await launch(url);
  }
}
