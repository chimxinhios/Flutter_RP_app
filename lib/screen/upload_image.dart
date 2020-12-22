import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(PickImageTest());
}

class PickImageTest extends StatefulWidget {
  @override
  _PickImageTestState createState() => _PickImageTestState();
}

class _PickImageTestState extends State<PickImageTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Column(
        children: [
          Center(
            child: RaisedButton(
              onPressed: () {
                getImageInStorage();
              },
              child: Text('pick image in gallery'),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                getImageInCamera();
              },
              child: Text('pick image in camera'),
            ),
          ),
           Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image,width: 200,),
      ),
        ],
      ),
    );
  }

  File _image;
  final picker = ImagePicker();
  Future getImageInStorage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        //backgroundAvatar = Image.file(_image);
      }
    });
  }

  Future getImageInCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,preferredCameraDevice: CameraDevice.front,imageQuality: 20,);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        //backgroundAvatar = Image.file(_image);
      }
    });
  }
}
