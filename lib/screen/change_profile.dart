import 'dart:convert';
import 'dart:io';
import 'package:report_app/services/upload.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_app/blocs/profile_bloc.dart';
import 'package:report_app/models/user.dart';
import 'package:report_app/services/api_service.dart';
import 'package:report_app/utilities/shared_preferences_manager.dart';
import 'package:report_app/utilities/textfield.dart';

class MenuProflie extends StatefulWidget {
  @override
  _MenuProflieState createState() => _MenuProflieState();
}

File _image;
final picker = ImagePicker();
var backgroundAvatar = null;

class _MenuProflieState extends State<MenuProflie> {
  ProfileBloc bloc = ProfileBloc();
  final _textInputName = TextEditingController();
  final _textInputEmail = TextEditingController();
  final _textInputAddress = TextEditingController();
  final _textInputDateOfBirth = TextEditingController();
  final _textInputGender = TextEditingController();
  String avatar2 = '';
  var gender = 'Nam';
  var man = true;
  //var dataprofile = jsonDecode(sharedPreferencesManager.getString('profile'));
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
        title: Text("Thay đổi thông tin"),
        centerTitle: true,
      ),
      body: StreamBuilder<User>(
          stream: bloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('not'),
              );
            }
            final profile = snapshot.data;
            _textInputName.text = profile.name;
            _textInputEmail.text = profile.email;
            _textInputAddress.text = profile.address;
            _textInputDateOfBirth.text = profile.dateOfBirth;
            _textInputGender.text = profile.dateOfBirth;
            avatar2 = profile.avatar;
            var avatar;
            var nameHint = '';

            if (profile.avatar == null) {
              if (profile.name.length > 1) {
                nameHint = profile.name.substring(0, 1);
              }
              avatar = Text(
                nameHint.toUpperCase(),
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              );
            } else {
              backgroundAvatar = NetworkImage(baseUrl + profile.avatar);
              // avatar = Image.network(
              //   'http://report.bekhoe.vn/${profile.avatar}',
              //   fit: BoxFit.cover,
              // );
            }
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(22),
                //color: Colors.blue,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showMenuPick();
                          },
                          child: CircleAvatar(
                            backgroundImage: backgroundAvatar,
                            backgroundColor: Colors.green[600],
                            child: avatar,
                            radius: 50,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 33,
                            ),
                            Text(
                              profile.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '  ${profile.phoneNumber}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(profile.email != ''
                                ? profile.email
                                : 'email@example'),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            height: 45,
                            margin: const EdgeInsets.all(12),
                            child: TextField(
                              controller: _textInputName,
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: ' Tên'),
                            )),
                        Container(
                            height: 45,
                            margin: const EdgeInsets.all(12),
                            child: TextField(
                              controller: _textInputEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email'),
                            )),
                        Container(
                            height: 45,
                            margin: const EdgeInsets.all(12),
                            child: TextField(
                              controller: _textInputAddress,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Địa chỉ'),
                            )),
                        Container(
                            height: 45,
                            margin: const EdgeInsets.all(12),
                            child: TextField(
                              controller: _textInputDateOfBirth,
                              keyboardType: TextInputType.datetime,
                              inputFormatters: [DateFormatter()],
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Ngày sinh'),
                            )),
                        Container(
                            height: 45,
                            //color: Colors.blue,
                            margin: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      ' Nữ',
                                      style: TextStyle(fontSize: 21),
                                    ),
                                    Switch(
                                        value: man,
                                        onChanged: (value) {
                                          setState(() {
                                            man = value;
                                          });
                                          if (man == false) {
                                            gender = 'Nữ';
                                          }
                                        }),
                                    Text(
                                      'Nam',
                                      style: TextStyle(fontSize: 21),
                                    ),
                                  ],
                                ),
                                RaisedButton(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  color: Colors.green[600],
                                  onPressed: () {
                                    bloc.updateprofile(
                                        _textInputName.text,
                                        _textInputEmail.text,
                                        _textInputAddress.text,
                                        _textInputDateOfBirth.text,
                                       // _textInputGender.text,
                                        avatar2,
                                        context);
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ],
                            ))
                        // TextField(
                        //   controller: _textInputGender,
                        //   decoration: InputDecoration(
                        //       border: OutlineInputBorder(),
                        //       labelText: 'Giới tính'),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _showMenuPick() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.grey[200],
            height: 99,
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(55)),
                    height: 49,
                    width: 300,
                    child: RaisedButton(
                      elevation: 0,
                      color: Colors.white,
                      onPressed: () {
                        getImageInCamera();
                      },
                      child: Text('Camera'),
                    )),
                Container(
                    padding: const EdgeInsets.all(5),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(55)),
                    height: 49,
                    width: 300,
                    child: RaisedButton(
                      elevation: 0,
                      color: Colors.white,
                      onPressed: () {
                        getImageInStorage();
                      },
                      child: Text('Thư viện'),
                    )),
              ],
            ),
          );
        });
  }

  Future getImageInCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    // Widget a(context) {
    //   return Center(
    //     child: IconButton(icon: Icon(Icons.add), onPressed: () => getImage()),
    //   );
    // }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        //backgroundAvatar = Image.file(_image);
      }
    });
  }

  Future getImageInStorage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        backgroundAvatar = FileImage(_image);

        apiService.upload(
          image: _image,
          onSuccess: (data) {
            print('data : $data');
            avatar2 = data;
          },
          onFailure: (error) {
            print(error);
          },
        );
        // avatar =
      }
    });
  }
}
