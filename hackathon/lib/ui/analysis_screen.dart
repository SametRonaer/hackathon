// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hackathon/ui/models/added_room_model.dart';
import 'package:hackathon/ui/models/grid_model.dart';
import 'package:hackathon/ui/models/wifi_status.dart';
import 'package:hackathon/ui/rooms_values_screen.dart';
import 'package:hackathon/ui/styles.dart';
import 'package:hackathon/ui/widgets/app_yellow_info_container.dart';
import 'package:hackathon/ui/widgets/base_scaffold.dart';
import 'package:hackathon/ui/widgets/grid_box.dart';
import 'package:hackathon/ui/widgets/primary_button.dart';
import 'package:hackathon/ui/widgets/result_home_plan_screen.dart';
import 'package:hackathon/wifi_manager.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({
    Key? key,
    required this.currentRoom,
    required this.rooms,
  }) : super(key: key);

  final AddedRoomModel currentRoom;
  final List<AddedRoomModel> rooms;

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int get listLength => widget.rooms.length;

  int get roomIndex => widget.rooms.indexOf(widget.currentRoom);

  int? get nextRoomIndex {
    if((roomIndex + 1) != listLength ){
      return roomIndex+1;
    }else{
      return null;
    }
  }
final wifiChecker = WifiChecker();
  @override
  void initState() {
    wifiChecker.startTimer();
    super.initState();
  }

  @override
  void dispose() {
   wifiChecker.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        centerTitle: true,
        title: Text("${widget.currentRoom.roomName} Analysis", style: textStyle.copyWith(fontWeight: FontWeight.w600),),),
      child: SingleChildScrollView(
        child: Column(
        children: [
          Container( width: double.infinity,
          child: Column(
            children: [
              getIndicatorBar(),
              ValueListenableBuilder(
                valueListenable: wifiChecker.wifiStatusNotifier,
                builder: (context, value, child) {
                  if(value == null || (value.score ?? 0) >= 50){
                    return SizedBox();
                  }
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red),
                      color: Colors.red.shade100
                    ),
                    child: Column(
                    children: [
                      Text("Weak Signal Detected", style:  textStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 16,),),
                      Text("Please mark all areas with poor WiFi coverage", style:  textStyle,),
                    ],
                  ),);
                }
              )
            ],
          ),
          ),
          DynamicGrid(addedRoomModel: widget.currentRoom, wifiChecker: wifiChecker,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:  16.0),
            child: AppYellowInfoContainer(label: "Walk around and tap areas with poor WiFi signal"),
          ),
          getButtons(context),
          // ValueListenableBuilder(
          //   valueListenable: wifiChecker.wifiStatusNotifier,
          //   builder: (context, value, child) {
          //     return Text("$value");
          //   }
          // )
        ],
            ),
      ));
  }

getButtons(BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      spacing: 8,
      children: [
        Expanded(
          child: PrimaryButton(onTap: (){
            Navigator.of(context).pop();
          }, label: "Back"),
        ),
        if(nextRoomIndex != null)
        Expanded(
          child: PrimaryButton(onTap: (){
            wifiChecker.stopTimer();
            generateGridModels();
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => AnalysisScreen(currentRoom: widget.rooms[roomIndex+1], rooms: widget.rooms)));
          }, label: "Next Room"),
        )
        else
              Expanded(
          child: PrimaryButton(onTap: (){
            wifiChecker.stopTimer();
            generateGridModels();
            //Navigator.of(context).push(MaterialPageRoute(builder: (_) => RoomsValuesScreen(rooms: widget.rooms)));
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => ResultHomePlanScreen(addedRooms: widget.rooms)));
          }, label: "Next"),
        ),
      ],
    ),
  );
}

 generateGridModels() {
  int rowCount = widget.currentRoom.height.toInt();
  int colCount = widget.currentRoom.width.toInt();
  List<GridModel> gridList = [];

  for (int i = 1; i <= rowCount; i++) {
    for (int j = 1; j <= colCount; j++) {
      gridList.add(
        GridModel(
          x: i,
          y: j,
          wifiStatus: wifiChecker.getMedianWifiStatus() ?? WifiStatus() ,
        ),
      );
    }
  }
widget.currentRoom.allSignals = gridList;
widget.currentRoom.allSignals.forEach((e){
  widget.currentRoom.weakSignals.forEach((w){
    if(w.x == e.x && w.y == e.y){
      e.wifiStatus = w.wifiStatus;
    }
  });
});
}

Widget getIndicatorBar(){
  final double progress = widget.rooms.isEmpty ? 0 : (roomIndex + 1) / listLength;

return Column(
  children: [
    LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.grey[300],
      color: Colors.blueAccent,
      minHeight: 5,
      borderRadius: BorderRadius.circular(5),
    ),
    const SizedBox(height: 8),
    Text("Room ${roomIndex + 1} of $listLength"),
  ],
);
}
}






class DynamicGrid extends StatelessWidget {
final AddedRoomModel addedRoomModel;
final WifiChecker wifiChecker;

  const DynamicGrid({
    Key? key,
 required this.addedRoomModel,
 required this.wifiChecker
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal:  18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical:  8.0),
            child: Text("Tap cells where signal is weak", style: textStyle,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
              // Kaydırmayı engellemek veya içeriğe göre daraltmak istersen:
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // Sütun sayısını burada belirliyoruz
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: addedRoomModel.width.toInt(), // Yan yana kaç tane olacak
                crossAxisSpacing: 8,      // Yatay boşluk
                mainAxisSpacing: 8,       // Dikey boşluk
                childAspectRatio: 1.0,    // 1.0 yaparak kare olmasını sağlıyoruz
              ),
              // Toplam hücre sayısı = satır * sütun
              itemCount: addedRoomModel.width.toInt() * addedRoomModel.height.toInt(),
              itemBuilder: (context, index) {
                    final x = (index ~/ addedRoomModel.width.toInt()) + 1;
                    final y = (index % addedRoomModel.width.toInt()) + 1;
                return GridBox(x: x, y: y, addedRoomModel: addedRoomModel, wifiChecker: wifiChecker,);
              },
            ),
          ),
          SizedBox(height: 12),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
             children: [
               Row(
                 children: [
                   Text("Strong Signal ", style: textStyle.copyWith(fontSize: 12, color: Colors.grey),),
                   Container(height: 16, width: 16,decoration: BoxDecoration(
                    color: goodSignalGridBg,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.green)
                   ),),
                 ],
               ),
               Row(
                 children: [
                   Text("Weak Signal ", style: textStyle.copyWith(fontSize: 12, color: Colors.grey),),
                   Container(height: 16, width: 16,decoration: BoxDecoration(
                    color: badSignalGridBg,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.red)
                   ),),
                 ],
               ),
             ],
           ),
           SizedBox(height: 12),
        ],
      ),
    );
  }
}

