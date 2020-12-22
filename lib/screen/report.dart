import 'package:flutter/material.dart';
import 'package:report_app/blocs/profile_bloc.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  SendReport bloc = SendReport();

  final _titleReport = TextEditingController();
  final _contentReport = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text('Báo cáo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Container(
                height: 60,
                child: TextField(
                  controller: _titleReport,
                  maxLength: 50,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400])),
                    labelText: 'Tiêu đề',
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _contentReport,
                  maxLength: 1000,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 11, top: 20, bottom: 50),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400])),
                    labelText: 'Nội dung',
                  ),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              Container(
                width: double.maxFinite,
                child: FlatButton(
                    onPressed: () {
                      bloc.Send(
                          _titleReport.text, _contentReport.text, context);
                    },
                    color: Colors.green[600],
                    child: Text('Gửi', style: TextStyle(color: Colors.white))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
