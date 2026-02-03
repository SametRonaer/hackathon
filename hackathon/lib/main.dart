import 'package:flutter/material.dart';
import 'package:hackathon/dummy_screen.dart';
import 'package:hackathon/hepler_methods.dart';
import 'package:hackathon/ui/analysis_screen.dart';
import 'package:hackathon/ui/get_started_screen.dart';
import 'package:hackathon/ui/layout_page.dart';
import 'package:hackathon/ui/models/added_room_model.dart';
import 'package:hackathon/ui/setup_your_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      //home: LayoutPage(boxes: [],),
      //home: SetupYourHomeScreen(),
      //home: AnalysisScreen(currentRoom: dummyRoom, rooms: [dummyRoom, dummyRoom2]),
      home: GetStartedScreen(),
      //home: DummyScreen(),
    );
  }
}



AddedRoomModel dummyRoom = AddedRoomModel(position: Offset(10, 10), width: 3, height: 4, color: getRandomColor(), roomName: "roomName");
AddedRoomModel dummyRoom2 = AddedRoomModel(position: Offset(10, 10), width: 4, height: 4, color: getRandomColor(), roomName: "roomName2");