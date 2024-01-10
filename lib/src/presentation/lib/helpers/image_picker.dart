import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImageHelper {
  final ImagePicker _imagePicker;

  ImageHelper({ImagePicker? imagePicker})
      : _imagePicker = imagePicker ?? ImagePicker();

  Future<XFile?> pick(
      {ImageSource imageSource = ImageSource.gallery,
      int imageQuality = 100}) async {
    try {
      return await _imagePicker.pickImage(
          source: imageSource, imageQuality: imageQuality);
    } catch (e) {
      return null;
    }
  }

  Uint8List toBytes({required XFile file}) {
    return File(file.path).readAsBytesSync();
  }

  String toBase64({required Uint8List bytes}) {
    String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
    return base64Image;
  }
}
