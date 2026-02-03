package com.example.hackathon

import android.content.Context
import android.net.wifi.WifiInfo
import android.net.wifi.WifiManager

/**
 * Wi-Fi sinyal kalitesini ölçer ve kullanıcı dostu hale getirir
 */
class WifiQualityManager(private val context: Context) {

    data class WifiQuality(
        val rssi: Int,
        val linkSpeed: Int,
        val frequency: Int,
        val score: Int,
        val description: String
    )

    fun getCurrentWifiQuality(): WifiQuality? {
        val wifiManager = context.applicationContext
            .getSystemService(Context.WIFI_SERVICE) as WifiManager

        val wifiInfo = wifiManager.connectionInfo ?: return null
        val rssi = wifiInfo.rssi

       // if (rssi == WifiInfo.INVALID_RSSI) return null

        val score = rssiToQuality(rssi)

        return WifiQuality(
            rssi = rssi,
            linkSpeed = wifiInfo.linkSpeed,
            frequency = wifiInfo.frequency,
            score = score,
            description = qualityText(score)
        )
    }

    private fun rssiToQuality(rssi: Int): Int {
        return when {
            rssi >= -50 -> 100
            rssi >= -60 -> 80
            rssi >= -70 -> 60
            rssi >= -80 -> 40
            else -> 20
        }
    }

    private fun qualityText(score: Int): String {
        return when {
            score >= 80 -> "Mükemmel"
            score >= 60 -> "İyi"
            score >= 40 -> "Orta"
            else -> "Zayıf"
        }
    }
}
