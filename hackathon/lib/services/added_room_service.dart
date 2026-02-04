import 'package:hackathon/ui/models/added_room_model.dart';

class AddedRoomService {
  AddedRoomService._internal();
  static final shared = AddedRoomService._internal();
  factory AddedRoomService(){
    return shared;
  }

  List<AddedRoomModel> addedRooms = [];
}