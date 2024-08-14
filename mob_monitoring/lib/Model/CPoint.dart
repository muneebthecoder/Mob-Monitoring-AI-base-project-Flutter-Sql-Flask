import 'package:mob_monitoring/Model/Location.dart';

class CPoints {
  late int id, location_id;
  late String radius;
  late Location location;

  // CPoints({
  //   this.id = -1,
  //   required this.name,
  //   required this.capacity,
  // });

  CPoints.fromMaps(Map<String, dynamic> map) {
    id = map["id"] ?? 0;
    location_id = map["location_id"] ?? "";
    radius = map["radius"] ??"";
    location = Location(
        id: map["location"]["id"] ?? 0,
        lname: map["location"]["lname"] ?? "",
        latitude: map["location"]["latitude"] ?? 0.0,
        longitude: map["location"]["longitude"] ?? 0.0);
  }

}
