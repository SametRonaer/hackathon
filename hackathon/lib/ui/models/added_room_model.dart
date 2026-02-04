import 'dart:ui';

import 'package:hackathon/ui/models/grid_model.dart';


class AddedRoomModel {
  Offset position;
  final double width;
  final double height;
  final Color color;
  final String roomName;
List<GridModel> weakSignals = [];
List<GridModel> allSignals = [];
  
  static double scaleFactor = 22; 

  double get scaledWidth => width * scaleFactor;
  double get scaledHeight => height * scaleFactor;

  Offset? updatedPosition;

  AddedRoomModel({
    required this.position,
    required this.width,
    required this.height,
    required this.color,
    required this.roomName
  });

  Rect get rect =>
      Rect.fromLTWH(position.dx, position.dy, width, height);

        Rect get scaledRect => Rect.fromLTWH(
        position.dx,
        position.dy,
        scaledWidth,
        scaledHeight,
      );
}