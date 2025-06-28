class Geofence {
  final String? id;
  final String latitude;
  final String longitude;
  final String radius;
  final bool status;

  Geofence({
    this.id,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.status,
  });

  factory Geofence.fromJson(Map<String, dynamic> json) {
    return Geofence(
      id: json['Id']?.toString(),
      latitude: json['Latitude'].toString(),
      longitude: json['Longitude'].toString(),
      radius: json['Radius'].toString(),
      status: json['Status'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "geofenceId": id,
      "latitude": latitude,
      "longitude": longitude,
      "radius": radius,
      "status": status,
    };
  }
}
