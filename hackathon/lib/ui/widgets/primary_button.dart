import 'package:flutter/material.dart';
import 'package:hackathon/ui/styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.onTap, required this.label});
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      backgroundColor: Colors.transparent,
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
      style: textStyle.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
    ),
  ),
);
  }
}