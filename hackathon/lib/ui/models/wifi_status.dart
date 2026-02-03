// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WifiStatus {
  final int? rssi;
  final int? linkSpeed;
  final int? frequency;
  final int? score;
  final String? description;
  WifiStatus({
    this.rssi,
    this.linkSpeed,
    this.frequency,
    this.score,
    this.description,
  });
 

  WifiStatus copyWith({
    int? rssi,
    int? linkSpeed,
    int? frequency,
    int? score,
    String? description,
  }) {
    return WifiStatus(
      rssi: rssi ?? this.rssi,
      linkSpeed: linkSpeed ?? this.linkSpeed,
      frequency: frequency ?? this.frequency,
      score: score ?? this.score,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rssi': rssi,
      'linkSpeed': linkSpeed,
      'frequency': frequency,
      'score': score,
      'description': description,
    };
  }

  factory WifiStatus.fromMap(Map<dynamic, dynamic> map) {
    return WifiStatus(
      rssi: map['rssi'] != null ? map['rssi'] as int : null,
      linkSpeed: map['linkSpeed'] != null ? map['linkSpeed'] as int : null,
      frequency: map['frequency'] != null ? map['frequency'] as int : null,
      score: map['score'] != null ? map['score'] as int : null,
      description: map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WifiStatus.fromJson(String source) => WifiStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WifiStatus(rssi: $rssi, linkSpeed: $linkSpeed, frequency: $frequency, score: $score, description: $description)';
  }

  @override
  bool operator ==(covariant WifiStatus other) {
    if (identical(this, other)) return true;
  
    return 
      other.rssi == rssi &&
      other.linkSpeed == linkSpeed &&
      other.frequency == frequency &&
      other.score == score &&
      other.description == description;
  }

  @override
  int get hashCode {
    return rssi.hashCode ^
      linkSpeed.hashCode ^
      frequency.hashCode ^
      score.hashCode ^
      description.hashCode;
  }
}
