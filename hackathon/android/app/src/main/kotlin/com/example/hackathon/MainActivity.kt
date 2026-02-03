package com.example.hackathon

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "wifi_quality_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {
                "getWifiQuality" -> {
                    val manager = WifiQualityManager(this)
                    val quality = manager.getCurrentWifiQuality()

                    if (quality != null) {
                        val map = mapOf(
                            "rssi" to quality.rssi,
                            "linkSpeed" to quality.linkSpeed,
                            "frequency" to quality.frequency,
                            "score" to quality.score,
                            "description" to quality.description
                        )
                        result.success(map)
                    } else {
                        result.error(
                            "UNAVAILABLE",
                            "Wi-Fi bilgisi alınamadı",
                            null
                        )
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
}


