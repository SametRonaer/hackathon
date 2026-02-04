import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class ExportImageservice {
   Future<Uint8List?> captureWidget(GlobalKey repaintKey) async {
  try {
    RenderRepaintBoundary boundary =
        repaintKey.currentContext!.findRenderObject()
            as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
print("object");
    return byteData?.buffer.asUint8List();
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
}