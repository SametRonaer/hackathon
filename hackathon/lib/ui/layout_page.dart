// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hackathon/ui/analysis_screen.dart';
// Model dosyanızın yolunu kendinize göre güncelleyin
import 'package:hackathon/ui/models/added_room_model.dart';
import 'package:hackathon/ui/models/router_model.dart';
import 'package:hackathon/ui/styles.dart';
import 'package:hackathon/ui/widgets/app_container.dart';
import 'package:hackathon/ui/widgets/app_yellow_info_container.dart';
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
    return Container(
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appBackgroundColor,
        centerTitle: true,
        title: Text("Arrange Your Rooms", style: textStyle.copyWith(fontWeight: FontWeight.w600),),),
          backgroundColor: appBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal:  16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(top:  12.0, bottom: 16),
                    child: Text("Drag rooms to position them on your floor plan", style: textStyle.copyWith(color: Colors.grey.shade600),),
                  ),
                    Container(
                      padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white
                          ,borderRadius: BorderRadius.circular(16)
                        ),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical:  16, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey.shade300)
                          ,borderRadius: BorderRadius.circular(8)
                        ),
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Stack(
                          children: [
                            Stack(
                              children: rooms.map((room) => _buildDraggableRoom(room)).toList(),
                            ),
                           // _buildRouter(RouterModel()),
                          ],
                        ),
                      ),
                    ),
                    AppYellowInfoContainer(label: "Position rooms to match your actual layout"),
                     AppContainer(
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Quick Templates:", style: textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 13),),
                            SizedBox(height: 6),
                            _getTemplateButton()
                          ],
                        ))
                  ],
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
          ),
        ),
      ),
    );
  }

  Widget _getTemplateButton() {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: Container(height: 50, child: Column(
            children: [
              Icon(Icons.snapchat_outlined),
              Text("Linear"),
            ],
          ), decoration: BoxDecoration(
                                  color: appBackgroundColor,
                                  border: Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(8)
                                ),),
        ),
        Expanded(
          child: Container(height: 50, child: Column(
            children: [
              Icon(Icons.snapchat_outlined),
              Text("Linear"),
            ],
          ), decoration: BoxDecoration(
                                  color: appBackgroundColor,
                                  border: Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(8)
                                ),),
        ),
        Expanded(
          child: Container(height: 50, child: Column(
            children: [
              Icon(Icons.snapchat_outlined),
              Text("Linear"),
            ],
          ), decoration: BoxDecoration(
                                  color: appBackgroundColor,
                                  border: Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(8)
                                ),),
        ),
       
      ],
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
                gradient:  LinearGradient(
                begin: Alignment.centerRight, // sağdan
                end: Alignment.centerLeft,     // sola
                colors: [
                  appPurple,
                  appLightPurple,
                ],
              ),
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
    );
  }
  Widget _buildRouter(RouterModel routerModel) {
    final initialPosition = Offset(50,50);
    return Positioned(
      left: initialPosition.dx,
      top: initialPosition.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            // 1. Yeni pozisyon adayı
            Offset tentativePosition = initialPosition + details.delta;

            

            
          
              routerModel.offset = tentativePosition;

           
          });
        },
        child: Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
                gradient:  LinearGradient(
                begin: Alignment.centerRight, // sağdan
                end: Alignment.centerLeft,     // sola
                colors: [
                  appPurple,
                  appLightPurple,
                ],
              ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black45, width: 1),
            boxShadow: const [
              BoxShadow(blurRadius: 4, color: Colors.black12, spreadRadius: 2)
            ],
          ),
          child: SizedBox(height: 50, width: 50,),
        ),
      ),
    );
  }
}