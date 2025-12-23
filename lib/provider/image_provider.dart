import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider with ChangeNotifier {
  File? _image;
  File? get image => _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      _image = File(pickFile.path);
      notifyListeners();
    }
  }

  void setImage(String? path) {
    if (path != null) {
      _image = File(path);
      notifyListeners();
    }
  }

  void clearImage() {
    _image = null;
    notifyListeners();
  }
}
