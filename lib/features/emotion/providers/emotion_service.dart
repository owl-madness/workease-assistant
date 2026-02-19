import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class EmotionService {
  Interpreter? _interpreter;

  Future<void> loadModel() async {
    _interpreter =
        await Interpreter.fromAsset('assets/models/emotion_model.tflite');
    print("Model loaded");
  }

  Future<List<double>> runModel(Uint8List imageBytes) async {
    final image = img.decodeImage(imageBytes);

    if (image == null) {
      throw Exception("Image decode failed");
    }

    // resize to 96x96
    final resized = img.copyResize(image, width: 96, height: 96);

    // prepare input tensor [1,96,96,3]
    var input = List.generate(
      1,
      (b) => List.generate(
        96,
        (y) => List.generate(
          96,
          (x) {
            final pixel = resized.getPixel(x, y);

            return [
              pixel.r / 255.0,
              pixel.g / 255.0,
              pixel.b / 255.0,
            ];
          },
        ),
      ),
    );

    var output = List.generate(1, (_) => List.filled(7, 0.0));

    _interpreter!.run(input, output);

    return output[0];
  }
}
