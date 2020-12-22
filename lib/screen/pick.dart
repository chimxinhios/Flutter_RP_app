import 'dart:io';
import '../blocs/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  UploadFile bloc = UploadFile();
  List<File> images = [];
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    Widget a(context) {
      return Center(
        child: IconButton(icon: Icon(Icons.add), onPressed: () => getImage()),
      );
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('file : ${_image}');
        images.add(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: SingleChildScrollView(
        
        child: Column(
          children: [
            RaisedButton(
              onPressed: () => getImage(),
              child: Text('Pick'),
            ),
            Builder(
              builder: (context) {
                if (_image == null) {
                  return Container(
                    margin: const EdgeInsets.all(33),
                    
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Container(
                          height: double.infinity,
                          width: 90,
                          color: Colors.grey[300],
                          child: a(context),
                        )
                      ],
                    ),
                  );
                }
                if (images.length == 0) {
                  return Container();
                }
                var crossAxisCount = 3;
                if (images.length < 4) {
                  crossAxisCount = images.length;
                }
                return Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 3,
                    children: List.generate(
                        images.length , (index) {
                      return Container(
                          child: Image.file(
                        images[index],
                        fit: BoxFit.fill,
                      ));
                    }),
                  ),
                );
              },
            ),
            RaisedButton(
              onPressed: () => bloc.UploadFileImage(_image, context),
              child: Text('Upload'),
            )
          ],
        ),
      ),
    );
  }

  Widget a(context) {
    return Center(
      child: IconButton(icon: Icon(Icons.add), onPressed: () => getImage()),
    );
  }
}
