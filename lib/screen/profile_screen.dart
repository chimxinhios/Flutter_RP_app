// import 'dart:convert';
// //import 'dart:js';
// //import 'dart:js';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:report_app/blocs/profile_bloc.dart';
// import 'package:report_app/change_profile.dart';
// import 'package:report_app/utilities/navigator.dart';
// import 'package:report_app/utilities/shared_preferences_manager.dart';

// import 'models/user.dart';

// class ChangeProflie extends StatefulWidget {
//   @override
//   _ChangeProflieState createState() => _ChangeProflieState();
// }

// class _ChangeProflieState extends State<ChangeProflie> {
//   ProfileBloc bloc;
//   @override
//   void initState() {
//     bloc = ProfileBloc();
//     bloc.getProfile();
//     super.initState();
//   }

//   final _textInputName = TextEditingController();
//   final _textInputPhoneNumber = TextEditingController();
//   final _textInputEmail = TextEditingController();

//   // var dataprofile = jsonDecode(sharedPreferencesManager.getString('profile'));
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('thay doi thong tin'),
//         ),
//         body:  StreamBuilder<User>(
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 final user = snapshot.data;
//                 if (user.avatar.length < 1) {
//                   print('ok');
//                 } else {
//                   print('avatar : ${user.email}');
//                 }
//                 //_textInputName.text = user.name;
//                 print('goi bloc thanh cong ${_textInputName.text}');
//                 //navigatorPush(context, MenuProflie());
//                 return SingleChildScrollView(
//               child: Container(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text('ten :      '),
//                           Container(
//                             width: 150,
//                             height: 40,
//                             child: TextField(
//                               controller: _textInputName,
                             
//                               //keyboardType: TextInputType.,
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   hintText: user.name,
//                                   hintStyle: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20)),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text('sdt :  '),
//                           Container(
//                             width: 150,
//                             height: 40,
//                             child: TextField(
//                               controller: _textInputPhoneNumber,
                             
//                               //keyboardType: TextInputType.,
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   hintText: user.phoneNumber,
//                                   hintStyle: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20)),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text('email :  '),
//                           Container(
//                             width: 180,
//                             height: 40,
//                             child: TextField(
//                               controller: _textInputEmail,
                             
//                               //keyboardType: TextInputType.,
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   //hintText: profile.email,
//                                   hintStyle: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20)),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     RaisedButton(
//                       onPressed: () {
//                         bloc.updateprofile(_textInputName.text, _textInputPhoneNumber.text, _textInputEmail.text,context);
//                       },
//                       child: Text('save'),
//                     )
//                   ],
//                 ),
//               ),
//             );
//               }
//               return Center(
//                 child: Text('not data'),
//               );
//             },
//             stream: bloc.stream,
          
//         )
//         //   child: Container(
//         //     padding: const EdgeInsets.all(15),
//         //     child: Column(
//         //       children: [
//         //         CircleAvatar(
//         //           radius: 50,
//         //         ),
//         //         SizedBox(
//         //           height: 20,
//         //         ),
//         //         Container(
//         //           child: Row(
//         //             mainAxisAlignment: MainAxisAlignment.center,
//         //             children: [
//         //               Text('ten :  '),
//         //               Container(
//         //                 width: 150,
//         //                 height: 40,
//         //                 child: TextField(
//         //                   controller: _textInputName,

//         //                   //keyboardType: TextInputType.,
//         //                   decoration: InputDecoration(
//         //                       border: OutlineInputBorder(),
//         //                       hintText: dataprofile['name'],
//         //                       hintStyle: TextStyle(
//         //                           color: Colors.black,
//         //                           fontWeight: FontWeight.bold,
//         //                           fontSize: 20)),
//         //                 ),
//         //               )
//         //             ],
//         //           ),
//         //         ),
//         //         SizedBox(
//         //           height: 20,
//         //         ),
//         //         Container(
//         //           child: Row(
//         //             mainAxisAlignment: MainAxisAlignment.center,
//         //             children: [
//         //               Text('sdt :  '),
//         //               Container(
//         //                 width: 150,
//         //                 height: 40,
//         //                 child: TextField(
//         //                   controller: _textInputPhoneNumber,

//         //                   //keyboardType: TextInputType.,
//         //                   decoration: InputDecoration(
//         //                       border: OutlineInputBorder(),
//         //                       hintText: dataprofile['phoneNumber'],
//         //                       hintStyle: TextStyle(
//         //                           color: Colors.black,
//         //                           fontWeight: FontWeight.bold,
//         //                           fontSize: 20)),
//         //                 ),
//         //               )
//         //             ],
//         //           ),
//         //         ),
//         //         SizedBox(
//         //           height: 20,
//         //         ),
//         //         Container(
//         //           child: Row(
//         //             mainAxisAlignment: MainAxisAlignment.center,
//         //             children: [
//         //               Text('email :  '),
//         //               Container(
//         //                 width: 180,
//         //                 height: 40,
//         //                 child: TextField(
//         //                   controller: _textInputEmail,

//         //                   //keyboardType: TextInputType.,
//         //                   decoration: InputDecoration(
//         //                       border: OutlineInputBorder(),
//         //                       hintText: dataprofile['email'],
//         //                       hintStyle: TextStyle(
//         //                           color: Colors.black,
//         //                           fontWeight: FontWeight.bold,
//         //                           fontSize: 20)),
//         //                 ),
//         //               ),
//         //             ],
//         //           ),
//         //         ),
//         //         SizedBox(
//         //           height: 20,
//         //         ),
//         //         RaisedButton(
//         //           onPressed: () {
//         //             // Saveprofile(inputName, inputPhoneNumber, inputEmail);
//         //           },
//         //           child: Text('save'),
//         //         )
//         //       ],
//         //     ),
//         //   ),
//         // ),
//         );
//   }
// }

// // Future Saveprofile(name, phone, email) async {
// //   Map data = {
// //     "phoneNumber": phone,
// //     'Email': email,
// //     'Name': name,
// //   };
// //   var toke = sharedPreferencesManager.getString('token');
// //   print("toke = $toke");
// //   var headers = {'Authorization': 'Bearer $toke'};
// //   final url = 'http://report.bekhoe.vn/api/accounts/update';
// //   final response = await http.post(url, body: data, headers: headers);
// //   if (response.statusCode >= 200 && response.statusCode <= 299) {
// //     final json = jsonDecode(response.body);
// //     print(json);
// //     if (json['code'] == 500) {
// //       print(json['message']);
// //     }
// //   }

// //  //return Navigator.pop(name);
// // }
