import 'package:flutter/material.dart';
import 'package:hackathon/ui/styles.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.onTap, required this.label});
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
  decoration: BoxDecoration(
    gradient:  LinearGradient(
      begin: Alignment.centerRight, // sağdan
      end: Alignment.centerLeft,     // sola
      colors: [
        appPurple,
        appLightPurple,
      ],
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 14,
      ),
    ),
    onPressed: onTap
      
    ,
    child:  Text(
      label,
      style: textStyle.copyWith(color: appPurple, fontSize: 18, fontWeight: FontWeight.w600),
    ),
  ),
);
  }
}