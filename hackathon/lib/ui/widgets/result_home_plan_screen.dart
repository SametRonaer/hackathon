// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:hackathon/ui/models/added_room_model.dart';
import 'package:hackathon/ui/styles.dart';
import 'package:hackathon/ui/widgets/added_room_container.dart';
import 'package:hackathon/ui/widgets/divided_container.dart';
import 'dart:ui' as ui;


  final GlobalKey repaintKey = GlobalKey();
class ResultHomePlanScreen extends StatelessWidget {
final List<AddedRoomModel> addedRooms;
  const ResultHomePlanScreen({
    Key? key,
    required this.addedRooms,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: repaintKey,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  Stack(
                    children: addedRooms.map((e) => getRoomBox(e)).toList(),
                  ),
                   ...getWeakPoints(),
                ],
              )
                ),
          ],
        )),
    );
  }

  List<Widget> getWeakPoints() {
    List<Widget> points = [];
    addedRooms.forEach((room) {
      room.weakSignals.forEach((signal){
    points.add( Positioned(
            top: room.position.dy,
            left: room.position.dx,
            child: Container(
              height: room.scaledHeight,
              width: room.scaledWidth,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    left: ((signal.y.toDouble() / room.height) * room.height - 0.8) * AddedRoomModel.scaleFactor,
                    top: ((signal.x.toDouble() / room.width) * room.width - 0.8 )* AddedRoomModel.scaleFactor,
                    child: CircleAvatar(backgroundColor: Colors.red, radius: 5,)),
                ],
              ))));

      });
      
    },);
    return points;
  }

  Widget getRoomBox(AddedRoomModel room){
    return Stack(
      children: [
        Positioned(
          top: room.position.dy,
          left: room.position.dx,
          child: Container(
                width: room.scaledWidth,
                height: room.scaledHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    //   gradient:  LinearGradient(
                    //   begin: Alignment.centerRight, // sağdan
                    //   end: Alignment.centerLeft,     // sola
                    //   colors: [
                    //     appPurple,
                    //     appLightPurple,
                    //   ],
                    // ),
                    color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black45, width: 1),
                  boxShadow: const [
                    BoxShadow(blurRadius: 4, color: Colors.black12, spreadRadius: 2)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      room.roomName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                    ),
                    Text(
                      "${room.width}m x ${room.height}m",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
        ),
      
      ],
    );
  }
  Future<Uint8List?> captureWidget() async {
  try {
    RenderRepaintBoundary boundary =
        repaintKey.currentContext!.findRenderObject()
            as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData?.buffer.asUint8List();
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

}
