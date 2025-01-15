import "dart:io";

import "package:flutter/material.dart";
import "package:image_cropper/image_cropper.dart";
import "package:image_picker/image_picker.dart";

abstract class ImageRepository {
  Future<File?> pickImage(ImageSource source);
  Future<File?> cropImage(String imagePath);
}

class DefaultImageRepository implements ImageRepository {
  final picker = ImagePicker();

  @override
  Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  @override
  Future<File?> cropImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Crop Photo",
          toolbarColor: const Color(0xFF022E64),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: "Crop Photo",
        ),
      ],
    );
    return croppedFile != null ? File(croppedFile.path) : null;
  }
}
