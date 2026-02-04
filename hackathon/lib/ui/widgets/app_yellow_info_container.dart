import 'package:flutter/material.dart';
import 'package:hackathon/ui/styles.dart';

class AppYellowInfoContainer extends StatelessWidget {
  const AppYellowInfoContainer({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      height: 55, width: double.infinity,
                      decoration: BoxDecoration(color: const Color.fromRGBO(253, 244, 213, 255), 
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(label, style: textStyle.copyWith(color: const Color.fromARGB(255, 163, 77, 3)),),
                        ],
                      ),
                      );
  }
}