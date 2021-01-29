import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function(File) onSelectedImage;

  ImageInput(this.onSelectedImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storeImage;

  _takePicture() async {
    try {
      final ImagePicker _picker = ImagePicker();
      PickedFile imageFile = await _picker.getImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );

      if (imageFile == null) return;

      setState(() {
        _storeImage = File(imageFile.path);
      });

      persistImage(_storeImage);

    } catch (error) {
      print(error);
    }
  }

  void persistImage(File storeImage) async {
    final appDir = await syspath.getApplicationSupportDirectory();
    final fileName = path.basename(storeImage.path);
    final savedImage = await storeImage.copy('${appDir.path}/$fileName');
    widget.onSelectedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          alignment: Alignment.center,
          child: _storeImage != null
              ? Image.file(
                  _storeImage,
                  width: double.infinity,
                  fit: BoxFit.cover
                )
              : Text('Nenhuma Imagem!'),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePicture,
            textColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.camera),
            label: Text('Tirar Foto'),
          ),
        ),
      ],
    );
  }
}
