import 'package:flutter/material.dart';
import 'package:report_app/blocs/profile_bloc.dart';
import 'package:report_app/screen/change_profile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:report_app/screen/pick.dart';
import 'package:report_app/services/api_service.dart';
import 'package:report_app/utilities/toast/toast.dart';

import 'change_pass.dart';
import 'contact.dart';
import 'login.dart';
import '../models/user.dart';
import 'profile_screen.dart';
import 'report.dart';
import '../utilities/navigator.dart';
import '../utilities/shared_preferences_manager.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  ProfileBloc bloc = ProfileBloc();
  var avatar;
  List data = [
    {'title': 'Sự cố', 'icon': Icons.list, 'ontap': PickImage()},
    {'title': 'Báo cáo', 'icon': Icons.report, 'ontap': Report()},
    {'title': 'Đổi mật khẩu', 'icon': Icons.security, 'ontap': ChangePass()},
    {'title': 'Điều khoản', 'icon': Icons.assignment, 'ontap': null},
    {'title': 'Liên hệ', 'icon': Icons.contacts, 'ontap': Contact()},
    {'title': 'Đăng xuất', 'icon': Icons.input, 'ontap': Login()}
  ];
  @override
  void initState() {
    // TODO: implement initState
    bloc.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String name = '';
    String phoneNumber = '';
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 130,
          child: DrawerHeader(
              child: StreamBuilder<User>(
                  stream: bloc.stream,
                  builder: (context, snapshot) {
                    final user = snapshot.data;
                    var backgroundAvatar = null;
                    var nameHint = ' ';

                    if (!snapshot.hasData) {
                      return Center();
                    } else {
                      print("avatar : ${user.avatar}");
                      if (user.avatar == null) {
                        print("avatar test");
                        if (user.name.length > 1) {
                          nameHint = user.name.substring(0, 1);
                        }
                        avatar = Text(nameHint);
                      } else {
                        backgroundAvatar = NetworkImage(baseUrl + user.avatar);
                        // avatar = Image.network(
                        //   'http://report.bekhoe.vn/${profile.avatar}',
                        //   fit: BoxFit.cover,
                        // );
                      }
                      name = user.name;

                      phoneNumber = user.phoneNumber;
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              navigatorPush(context, MenuProflie());
                            },
                            child: CircleAvatar(
                              backgroundImage: backgroundAvatar,
                              child: avatar,
                              radius: 32,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(children: [
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              name,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              phoneNumber,
                              style: TextStyle(color: Colors.white),
                            )
                          ]),
                        ],
                      );
                    }
                  })),
          decoration: BoxDecoration(
            color: Colors.green[600],
          ),
        ),
        ListTile(
          title: Container(
              height: double.maxFinite,
              color: Colors.blue,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      height: 40,
                      child: ListTile(
                        title: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            if (data[index]['ontap'] != null) {
                              if (data[index]['title'] == 'Đăng xuất') {
                                sharedPreferencesManager.remove('token');
                                ToastWidget(context).show(
                                    toastType: ToastType.success,
                                    text: 'Đăng xuất thành công');
                                print('dang xuat va xoa token');
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          data[index]['ontap'],
                                    ),
                                    ModalRoute.withName('/'));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          data[index]['ontap'],
                                    ));
                              }
                            }
                          },
                          child: Row(
                            children: [
                              Icon(data[index]['icon']),
                              SizedBox(
                                width: 8,
                              ),
                              Text(data[index]['title']),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        height: 22,
                      ),
                  itemCount: data.length)),
        ),
      ],
    );
  }

  Future checkAvatar(user) async {
    final url2 = 'http://report.bekhoe.vn${user.avatar}';
    final responseAvatar = await http.get(url2);
    print("status avatar : ${responseAvatar.statusCode}");
    if (responseAvatar.statusCode < 200 || responseAvatar.statusCode > 299) {
      avatar = Text('loi');
    }
  }
}
