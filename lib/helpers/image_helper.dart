import 'dart:io';
import 'package:image/image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelper {
  static Future<File> cropImage(
      File file, int widthImage, int widthScreen) async {
    Image? image = decodeImage(file.readAsBytesSync());
    print("Image width ${image?.width} ${image?.height}");
    double? ratio = widthScreen / (image!.height);
    Image? thumbnail =
        copyResizeCropSquare(image, size: (widthImage / ratio).round().toInt());
    print(
        "Image after crop width: ${thumbnail.width} height: ${thumbnail.width}");
    final path = join(
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.png',
    );
    // Save the thumbnail as a PNG.
    return File(path)..writeAsBytesSync(encodePng(bakeOrientation(thumbnail)));
  }
}
