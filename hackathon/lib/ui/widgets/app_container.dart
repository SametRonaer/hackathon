import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  
  final Widget child;

  const AppContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 14,
  ),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: const Color(0xFFE0E0E0), // hafif gri kenar
      width: 1,
    ),
  ),
  child: child,
);
  }
}