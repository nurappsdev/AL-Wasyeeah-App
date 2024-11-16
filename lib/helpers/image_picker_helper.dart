
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  //==================================> Gallery <===============================
  static Future<List<int>?> pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      return await File(returnImage.path).readAsBytes();
    }
  }

  //==================================> Camera <===============================
  static Future<List<int>?> pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage != null) {
      return await File(returnImage.path).readAsBytes();
    }
  }

  static Future<File?> pickImage(ImageSource imageSource) async {
    final returnImage =
    await ImagePicker().pickImage(source:imageSource);
    if (returnImage != null) {
      return File(returnImage.path);
    }
    return null;
  }
}