import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:palette_generator/palette_generator.dart';

class Name {
  Future<Color> useWhiteTextColor(String imageUrl) async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(imageUrl),

      // Images are square
      size: Size(300, 300),

      // I want the dominant color of the top left section of the image
      region: Offset.zero & Size(40, 40),
    );
    Color dominantColor = paletteGenerator.dominantColor!.color;
    // Here's the problem
    // Sometimes dominantColor returns null
    // With black and white background colors in my tests
    //if (dominantColor == null) print('Dominant Color null');

    return dominantColor;
  }
}
