import 'package:flutter/material.dart';
import 'package:report_app/services/api_service.dart';

class SeeIssue extends StatelessWidget {
  final Map issue;
  SeeIssue({Key key, this.issue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
        title: Text('${issue['title']}'),
        backgroundColor: Colors.green[600],
        elevation: 10,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.yellow[100],
        child: ListView(
          //shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Text(
                    '${issue['content']}',
                    style: TextStyle(fontSize: 21),
                  ),
                  buiPhoto()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buiPhoto() {
    List listphoto = issue['photos'];
    //print(listphoto);
    List<Widget> photo = [];
    for (int i = 0; i < listphoto.length; i++) {
      photo.add(SizedBox(
        height: 10,
      ));
      photo.add(ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(baseUrl + listphoto[i])));
    }
    if (listphoto.length > 0) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: photo,
        ),
      );
    }

    return Container();
  }
}
