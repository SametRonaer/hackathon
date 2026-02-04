import 'package:flutter/material.dart';
import 'package:hackathon/ui/models/added_room_model.dart';
import 'package:hackathon/ui/styles.dart';

class RoomsValuesScreen extends StatelessWidget {
  const RoomsValuesScreen({super.key, required this.rooms});
  final List<AddedRoomModel> rooms;
// All signal values rooms allsignals
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appBackgroundColor,
          body: Column(
            children: rooms.map((e) => Container(
              child: Column(
                children: [
                  Text("Room name: ${e.roomName}"),
                  Text("Room grid values"),
                  
                  
                ],
              ),
            )).toList(),
          ),
        ),
      ),
    );
  }
  
}