import 'package:flutter/material.dart';
import 'package:hackathon/ui/models/added_room_model.dart';
import 'package:hackathon/ui/models/grid_model.dart';
import 'package:hackathon/wifi_manager.dart';

class GridBox extends StatefulWidget {
  
final AddedRoomModel addedRoomModel;
final int x;
final int y;
final WifiChecker wifiChecker;
  const GridBox({super.key, required this.addedRoomModel, required this.x, required this.y, required this.wifiChecker,});
  @override
  State<GridBox> createState() => _GridBoxState();
}

class _GridBoxState extends State<GridBox> {
bool isSginalStatusGood = true;


@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {
            if(widget.wifiChecker.wifiStatusNotifier.value != null){
            final grid = GridModel(x: widget.x, y: widget.y,wifiStatus: widget.wifiChecker.wifiStatusNotifier.value!);
            print(grid);
            isSginalStatusGood = !isSginalStatusGood;
            setState(() {});
            if(isSginalStatusGood){
              widget.addedRoomModel.weakSignals.removeWhere((g) => g.x == widget.x && g.y == widget.y);
            }else{
              widget.addedRoomModel.weakSignals.add(grid);
            }

            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSginalStatusGood ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '${widget.x}, ${widget.y}',
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        );
  }
}