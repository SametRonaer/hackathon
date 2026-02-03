// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathon/ui/models/wifi_status.dart';

class WifiQuality {
  static const MethodChannel _channel =
      MethodChannel('wifi_quality_channel');

  static Future<WifiStatus?> getCurrent() async {
    try {
      final result =
          await _channel.invokeMethod<Map>('getWifiQuality');

      if (result == null) return null;
    final status = WifiStatus.fromMap(result);
      return status;
    } on PlatformException catch (e) {
      print("Wifi error: ${e.message}");
      return null;
    }
  }
}


class WifiChecker{

WifiStatus? getMedianWifiStatus() {
  if (allStatuses.isEmpty) return null;

  // 1. Orijinal listeyi bozmamak için kopyasını oluştur ve score'a göre sırala
  // null olan score'ları 0 kabul ediyoruz (isteğe göre değiştirilebilir)
  List<WifiStatus> sortedList = List.from(allStatuses);
  sortedList.sort((a, b) => (a.score ?? 0).compareTo(b.score ?? 0));

  // 2. Ortanca index'i bul
  int middleIndex = sortedList.length ~/ 2;

  // 3. Ortanca objeyi dön
  return sortedList[middleIndex];
}

List<WifiStatus> allStatuses = [];
Timer? _timer;

ValueNotifier<WifiStatus?> wifiStatusNotifier = ValueNotifier(null);

void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async{
      final status = await WifiQuality.getCurrent();
      wifiStatusNotifier.value = status;
      if(status != null){
      allStatuses.add(status);
      }
    });
  }

  void stopTimer(){
    _timer?.cancel();
    _timer = null;
  }
}


