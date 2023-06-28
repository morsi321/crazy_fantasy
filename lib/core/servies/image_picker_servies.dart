import 'package:image_picker/image_picker.dart';

class ImagePickerServices {
  static final ImagePicker _picker = ImagePicker();
  static Future<String> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image!.path;
  }

  static Future getVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    return video;
  }

  static Future<List<String>> getManyImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    return images.map((e) => e.path).toList();
  }
}
