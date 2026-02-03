import 'package:flutter/material.dart';
import 'package:hackathon/hepler_methods.dart';
import 'package:hackathon/ui/layout_page.dart';
import 'package:hackathon/ui/models/added_room_model.dart';
import 'package:hackathon/ui/widgets/added_room_container.dart';
import 'package:hackathon/ui/widgets/app_textfield.dart';
import 'package:hackathon/ui/widgets/base_scaffold.dart';
import 'package:hackathon/ui/styles.dart';
import 'package:hackathon/ui/widgets/primary_button.dart';
import 'package:hackathon/ui/widgets/secondary_button.dart';

class SetupYourHomeScreen extends StatelessWidget {
   SetupYourHomeScreen({super.key});
final roomNameController = TextEditingController();
final roomWidthController = TextEditingController();
final roomHeightController = TextEditingController();
ValueNotifier<List<AddedRoomModel>> addedRooms = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: Text("Setup Your Home", style: textStyle.copyWith(fontWeight: FontWeight.w600),),),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppTextfield(label: "Room Name", hintText: "e.g., Living Room", textEditingController: roomNameController,),
          Row(
            spacing: 8,
            children: [
              Expanded(child: AppTextfield(
                inputType: TextInputType.number,
                label: "Room Dimensions (meters)", hintText: "Width", textEditingController: roomWidthController,)),
              Expanded(child: AppTextfield(
                inputType: TextInputType.number,
                label: "", hintText: "Height", textEditingController: roomHeightController,)),
            ],
          ),
        ValueListenableBuilder(
          valueListenable: addedRooms,
          builder: (context, value, child) {
            return Column(
              children: addedRooms.value.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical:  8.0),
                child: AddedRoomContainer(addedRoomModel: e, onTapDelete: (value) {
                  addedRooms.value.remove(value);
                  print("object");
                  final updatedList = [...addedRooms.value].where((e) => e!= value).toList();
                  addedRooms.value = updatedList;
                },),
              )).toList(),
            );
          }
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
            width: double.infinity,
            child: SecondaryButton(onTap: addRoom, label: "+ Add Another Room")),
        ),
          SizedBox(height: 6),
        ValueListenableBuilder(
          valueListenable: addedRooms,
          builder: (context, value, child) {
            return value.isEmpty ? SizedBox()
            : SizedBox(
              width: double.infinity,
              child: PrimaryButton(onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder:(context) => RoomCanvas(rooms: value,),));
                //Navigator.of(context).push(MaterialPageRoute(builder:(context) => SnapBoxesPage(rooms: value, scaleFactor: 10,),));
              }, label: "Start Analysis (${value.length} Rooms)"));
          }
        )
        ],
            ),
      ));
  }

  addRoom(){
    if(roomWidthController.text.isNotEmpty && roomHeightController.text.isNotEmpty && roomNameController.text.isNotEmpty){
     final height = double.tryParse(roomHeightController.text);
     final width = double.tryParse(roomWidthController.text);
     if(height != null && width != null){
      addedRooms.value = [...addedRooms.value, AddedRoomModel(
        position: Offset(10, 10),
        color: getRandomColor(),
        roomName: roomNameController.text, width: width , height: height)];
      roomHeightController.clear();
      roomWidthController.clear();
      roomNameController.clear();
     }
    }
  }

  
}