import 'package:mob_monitoring/Model/Location.dart';

class Station {
  late int id, capacity, available_drones;
  late String name;
  late Location location;

  Station({
    this.id = -1,
    required this.name,
    required this.capacity,
  });

  Station.fromMaps(Map<String, dynamic> map) {
    id = map["id"] ?? 0;
    name = map["name"] ?? "";
    capacity = map["capacity"] ?? 0;
    available_drones = map["available_drones"] ?? 0;
    location = Location(
        id: map["location"]["id"] ?? 0,
        lname: map["location"]["lname"] ?? "",
        latitude: map["location"]["latitude"] ?? 0.0,
        longitude: map["location"]["longitude"] ?? 0.0);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "capacity": capacity,
    };
  }
}
