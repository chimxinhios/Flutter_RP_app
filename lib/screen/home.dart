import 'package:flutter/material.dart';
import 'package:report_app/blocs/profile_bloc.dart';
import 'package:report_app/models/issue.dart';
import 'package:report_app/screen/issue_screen.dart';
import 'package:report_app/screen/menu_screen.dart';
import 'package:report_app/screen/pick.dart';
import 'package:report_app/utilities/navigator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc bloc = HomeBloc();
  List issue = [];
  final baseUrl = 'http://report.bekhoe.vn/';
  int offset = 0;
  @override
  void initState() { 
    // TODO: implement initState
    bloc.getIssue(offset);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[600],
          title: Text('Home'),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: MenuScreen(),
        ),
        body: StreamBuilder(
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('Loading...',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
              );
            }

            issue += snapshot.data;
            //print(issue);
            return buiBody();
          },
          stream: bloc.stream,
        ));
  }

  Widget buiBody() {
    return Container(
      color: Colors.grey[300],
      child: RefreshIndicator(
        onRefresh: () async {
          return await Future.delayed(Duration(seconds: 1));
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (index == issue.length - 1) {
              offset = issue.length;
              bloc.getIssue(offset);
            }
            return buiItem(index);
          },
          itemCount: issue.length,
          shrinkWrap: true,
        ),
      ),
    );
  }

  Widget buiItem(index) {
    return GestureDetector(
      onTap: () => navigatorPush(context, SeeIssue(issue: issue[index])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(48),
        child: Container(
          margin: const EdgeInsets.all(11),
          padding: const EdgeInsets.all(15),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(index),
              SizedBox(
                height: 12,
              ),
              content(index),
              SizedBox(
                height: 12,
              ),
              photo(index)
            ],
          ),
        ),
      ),
    );
  }

  header(index) {
    String hintName = issue[index]['accountPublic']['name']
        .toString()
        .substring(0, 1)
        .toUpperCase();
    Widget avatar = CircleAvatar(
      radius: 25,
      child: Text(hintName),
    );
    if (issue[index]['accountPublic']['avatar'].toString().length > 0) {
      avatar = Image.network(
        '${baseUrl + issue[index]['accountPublic']['avatar']}',
        height: 50,
      );
    }
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(25), child: avatar),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${issue[index]['createdBy']}'),
              Text('${issue[index]['createdAt']}')
            ],
          )),
          trangthai(issue[index]['status'])
        ],
      ),
    );
  }

  content(index) {
    String content = issue[index]['content'].toString();

    if (content.length > 100) {
      content = content.substring(0, 100) + '... Đọc tiếp';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${issue[index]['title']}',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        Text(
          content,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  photo(index) {
    List dataPhoto = issue[index]['photos'];
    List<Widget> buiPhoto = [];
    if (dataPhoto.length > 0) {
      for (int i = 0; i < dataPhoto.length; i++) {
        buiPhoto.add(
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              //width: 88,
              child: Image.network(
                baseUrl + dataPhoto[i],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }
    }
    var crossAxisCount = buiPhoto.length;
    if (buiPhoto.length > 3) {
      crossAxisCount = 3;
    }
    
    if (dataPhoto.length > 0) {
      return GridView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: buiPhoto.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1,
              mainAxisSpacing: 1,
              crossAxisSpacing: 2),
          itemBuilder: (context, index) {
            return buiPhoto[index];
          });
    }
    return Container();
  }
}

Widget trangthai(status) {
  switch (status) {
    case 0:
      return Text(
        'Đang chờ ',
        style: TextStyle(color: Colors.orange),
      );
      break;
    case 1:
      return Text(
        'Đang xử lí ',
        style: TextStyle(color: Colors.red),
      );
      break;
    case 2:
      return Text(
        'Đã xong ',
        style: TextStyle(color: Colors.green),
      );
      break;
    case 3:
      return Text(
        'Hủy bỏ ',
        style: TextStyle(color: Colors.grey),
      );
      break;
    case 4:
      return Text(
        'Không duyệt ',
        style: TextStyle(color: Colors.red),
      );
      break;
    default:
  }
}
