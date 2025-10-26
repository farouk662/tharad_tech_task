import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tharad_flutter_task/core/services/logger_service.dart';

class ImagePickerService {
  // Singleton pattern
  static final ImagePickerService _instance = ImagePickerService._internal();

  factory ImagePickerService() => _instance;

  ImagePickerService._internal();

  final ImagePicker _picker = ImagePicker();
  // pick image from gallery or camera
  Future<File?> pickImage({bool fromGallery = true}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 80, // compress image quality
      );
      if (pickedFile == null) return null;
      File? tempImage = File(pickedFile.path);
      tempImage = await _cropImage(imageFile: tempImage);
      if (tempImage == null) return null;
      return File(tempImage.path);
    } catch (e) {
      rethrow;
    }
  }
    // crop image
  Future<File?> _cropImage({required File imageFile}) async {
    try {
      final CroppedFile? croppedImg = await ImageCropper()
          .cropImage(sourcePath: imageFile.path, compressQuality: 100);
      if (croppedImg == null) {
        return null;
      } else {
        return File(croppedImg.path);
      }
    } catch (e) {
      logger.error('$e');
    }
    return null;
  }
    // check file size if it is valid
  bool isFileSizeValid(File file, {int maxSizeMB = 5}) {
    final fileSizeInBytes = file.lengthSync();
    final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
    return fileSizeInMB <= maxSizeMB;
  }


}
