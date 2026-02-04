import 'package:flutter/material.dart';
import 'package:hackathon/ui/models/grid_model.dart';
import 'package:hackathon/ui/styles.dart';

class DividedContainer extends StatelessWidget {
  
    final int width;
  final int height;
  final List<GridModel> grids;
  final Color emptyColor;

  const DividedContainer({super.key, required this.width, required this.height, required this.grids, required this.emptyColor});


   @override
  Widget build(BuildContext context) {
    // max x ve y'yi bul
    final maxX = grids.map((e) => e.x).reduce((a, b) => a > b ? a : b);
    final maxY = grids.map((e) => e.y).reduce((a, b) => a > b ? a : b);

    final columnCount = maxX + 1;
    final rowCount = maxY + 1;

    // hızlı lookup için map
    final Map<String, GridModel> gridMap = {
      for (var g in grids) '${g.x}_${g.y}': g
    };

    return SizedBox(
      width: width.toDouble(),
      height: height.toDouble(),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnCount,
        ),
        itemCount: columnCount * rowCount,
        itemBuilder: (context, index) {
          final x = (index % columnCount) + 1;
          final y = (index ~/ columnCount) + 1;

          final grid = gridMap['${x}_$y'];

          return Container(
            decoration: BoxDecoration(
              
              color: (grid?.wifiStatus.score ?? 0) > 50 ? goodSignalGridBg : badSignalGridBg, 
              border: Border.all(color: Colors.black12),
            ),
          );
        },
      ),
    );
  }
}