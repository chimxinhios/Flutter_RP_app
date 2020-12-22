import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:report_app/models/user.dart';
import 'package:report_app/utilities/shared_preferences_manager.dart';

class HomeBloc {
  StreamController _streamController;

  StreamSink<User> get sink => _streamController.sink;
  Stream<User> get stream => _streamController.stream;

  HomeBloc() {
    _streamController = StreamController<User>.broadcast();
  }
  void dispose() {
    _streamController.close();
  }

  Future getProfile() async {
    final url = 'http://report.bekhoe.vn/api/issues?limit=10&offset=0';
    var toke = sharedPreferencesManager.getString('token');
    print("toke = $toke");
    var headers = {'Authorization': 'Bearer $toke'};
    var json;
    final response = await http.get(
      url,
      headers: headers,
    );
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      json = jsonDecode(response.body);
      //print(json);

      print('get thanh cong');
      var data = json['data'];
      print('a : $data');
      // sharedPreferencesManager.save('profile', savedataprofile);
      print('object');
      final user = User.fromJson(data);
      print('----------------------------------------------------');
      sink.add(user);
    }
  }
}
