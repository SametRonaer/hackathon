// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hackathon/services/export_imageService.dart';

import 'package:hackathon/ui/models/added_room_model.dart';
import 'package:hackathon/ui/styles.dart';
import 'package:hackathon/ui/widgets/added_room_container.dart';
import 'package:hackathon/ui/widgets/app_yellow_info_container.dart';
import 'package:hackathon/ui/widgets/divided_container.dart';
import 'package:hackathon/ui/widgets/primary_button.dart';



  final GlobalKey repaintKey = GlobalKey();
class ResultHomePlanScreen extends StatelessWidget {
final List<AddedRoomModel> addedRooms;
  const ResultHomePlanScreen({
    Key? key,
    required this.addedRooms,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
      backgroundColor: appBackgroundColor,
      centerTitle: true,
      title: Text("Measurement Preview", style: textStyle.copyWith(fontWeight: FontWeight.w600),),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Review your measurement points before analysis", style: textStyle.copyWith(color: Colors.grey),),
              ),
              RepaintBoundary(
                key: repaintKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
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
              ),
                  getWeakPointInfoBox(),
            ],
          ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(onTap: ()async{
                        await ExportImageservice().captureWidget(repaintKey);
                      }, label: "Generate AI Report"),
                    ),
                  ),
                ],
              )
        ],
      ));
  }

getWeakPointInfoBox(){
  int weakPoints = 0;
  addedRooms.forEach((room){
    weakPoints += room.weakSignals.length;
  });
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: AppYellowInfoContainer(label: "Total weak points are $weakPoints"),
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
 

}
