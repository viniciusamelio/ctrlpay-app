import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class IImageService {
  Future<File> get(ImageSource imageSource);
}

class AvatarService implements IImageService {
  Future<File> get(ImageSource imageSource) async {
    try {
      final response = await ImagePicker.pickImage(source: imageSource);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
