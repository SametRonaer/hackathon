// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hackathon/ui/analysis_screen.dart';
// Model dosyanızın yolunu kendinize göre güncelleyin
import 'package:hackathon/ui/models/added_room_model.dart';
import 'package:hackathon/ui/widgets/primary_button.dart'; 

class RoomCanvas extends StatefulWidget {
  final List<AddedRoomModel> rooms;
  const RoomCanvas({
    Key? key,
    required this.rooms,
  }) : super(key: key);

  @override
  _RoomCanvasState createState() => _RoomCanvasState();
}

class _RoomCanvasState extends State<RoomCanvas> {
  List<AddedRoomModel> rooms = [];

  @override
  void initState() {
    super.initState();
    rooms = widget.rooms;
    
    // Başlangıçta odaların üst üste binmesini engellemek için pozisyonları ayarla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePositions();
    });
  }

  void _initializePositions() {
    setState(() {
      for (int i = 0; i < rooms.length; i++) {
        // Eğer bir oda diğeriyle çakışıyorsa, boş yer bulana kadar kaydır
        _findSafeInitialPosition(rooms[i], rooms.sublist(0, i));
      }
    });
  }

  void _findSafeInitialPosition(AddedRoomModel target, List<AddedRoomModel> others) {
    bool hasCollision = true;
    while (hasCollision) {
      hasCollision = false;
      for (var other in others) {
        if (target.scaledRect.overlaps(other.scaledRect)) {
          hasCollision = true;
          // Çakışma varsa sağa veya aşağı kaydır (Basit bir algoritma)
          target.position = Offset(target.position.dx + 20, target.position.dy + 20);
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.amber,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Stack(
              children: rooms.map((room) => _buildDraggableRoom(room)).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: PrimaryButton(onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder:(context) => AnalysisScreen(currentRoom: widget.rooms.first, rooms: rooms),));
              }, label: "Continue to Analysis")),
          )
        ],
      ),
    );
  }

  Widget _buildDraggableRoom(AddedRoomModel room) {
    return Positioned(
      left: room.position.dx,
      top: room.position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            // 1. Yeni pozisyon adayı
            Offset tentativePosition = room.position + details.delta;

            // 2. Çakışma Kontrolü (Collision Detection)
            Rect newRect = Rect.fromLTWH(
              tentativePosition.dx,
              tentativePosition.dy,
              room.scaledWidth,
              room.scaledHeight,
            );

            bool collision = false;
            for (var other in rooms) {
              if (other == room) continue;
              if (newRect.overlaps(other.scaledRect)) {
                collision = true;
                break;
              }
            }

            // 3. Eğer çakışma yoksa konumu güncelle
            if (!collision) {
              room.position = tentativePosition;
            }
          });
        },
        child: Container(
          width: room.scaledWidth,
          height: room.scaledHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: room.color.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black45, width: 2),
            boxShadow: const [
              BoxShadow(blurRadius: 4, color: Colors.black12, spreadRadius: 2)
            ],
          ),
          child: Text(
            room.roomName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
    );
  }
}