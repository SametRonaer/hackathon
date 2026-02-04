import 'package:flutter/material.dart';
import 'package:hackathon/ui/styles.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({super.key, required this.child, this.appBar,});
final Widget child;
final AppBar? appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: appBar,
      body: child,
    );
  }
}