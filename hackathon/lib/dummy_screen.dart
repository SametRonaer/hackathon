import 'package:flutter/material.dart';
import 'package:hackathon/wifi_manager.dart';

class DummyScreen extends StatefulWidget {
  const DummyScreen({super.key});

  @override
  State<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  
Future<void> getWifiQuality()async{
  final wifi = await WifiQuality.getCurrent();

// if (wifi != null) {
//   print("RSSI: $wifi");
//   print("RSSI: ${wifi['rssi']}");
//   print("Kalite: ${wifi['description']} (${wifi['score']})");
//   notifier.value = "$wifi";
// }

}

final notifier = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: notifier,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal:  18.0),
                child: Text(value),
              );
            }
          ),
          SizedBox(height: 50),
          ElevatedButton(onPressed: getWifiQuality, child: Text("Get Wifi Quality"),),
        ],
      )),
    );
  }
}