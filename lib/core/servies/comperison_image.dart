import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class CompressionImagesService {
  static Future<Uint8List?> compressImage(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 5,
    );
    print(file.lengthSync());
    print(result?.length);
    return result;
  }

  static Future<List<Uint8List>> compressImages(List<String> photos) async {
    List<Uint8List>? result = [];
    for (int i = 0; i < photos.length; i++) {
      Uint8List bytes = (await compressImage(File(photos[i])))!;
      result.add(bytes);
    }
    return result;
  }
}
