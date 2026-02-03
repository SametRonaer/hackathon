import 'package:flutter/material.dart';
import 'package:hackathon/ui/models/added_room_model.dart';
import 'package:hackathon/ui/widgets/app_container.dart';

class AddedRoomContainer extends StatelessWidget {
  const AddedRoomContainer({super.key, required this.addedRoomModel, required this.onTapDelete,  });
  
final AddedRoomModel addedRoomModel;
final ValueSetter<AddedRoomModel> onTapDelete;
  @override
  Widget build(BuildContext context) {
    return AppContainer(child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(addedRoomModel.roomName),
            Text("${addedRoomModel.height}m x ${addedRoomModel.width}m (${addedRoomModel.height * addedRoomModel.width}m)"),
          ],
        ),
        GestureDetector(
          onTap: () {
            onTapDelete(addedRoomModel);
          },
          child: Container(height: 35, width: 35, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)), child: Icon(Icons.close, color: Colors.white,),))
      ],
    ));
  }
}