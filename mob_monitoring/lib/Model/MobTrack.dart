import 'package:mob_monitoring/Model/Location.dart';

class MobTracking {
  late int markerId;
  late int mobId;
  late double latitude;
  late double longitude;
  late int typeId;
  late String lname;
  late int parentId;
  late int splitId;
  late String movement_time;
  late Location location;
  late int head_count;
  late int moveId;
  late String img;
//  bool isLast;
  MobTracking(
      {required this.markerId,
      required this.lname,
      required this.mobId,
      required this.latitude,
      required this.longitude,
      required this.typeId,
      required this.parentId,
      required this.splitId,
      required this.movement_time,
      required this.moveId
//      required this.isLast
      });

  Map<String, dynamic> toMap() {
    return {
      "mark_id": markerId,
      "lname": lname,
      "mob_id": mobId,
      "latitude": latitude,
      "longitude": longitude,
      "type_id": typeId,
      "parent_id": parentId,
      "split_id": splitId,
      "movement_time": movement_time,
      "move_id": moveId,
    };
  }

  MobTracking.fromMap(Map<dynamic, dynamic> map) {
    markerId = map["mark_id"] ?? 0;
    moveId = map["move_id"] ?? 0;
    mobId = map["id"] ?? 0;
    typeId = map["type_id"] ?? 0;
    parentId = map["parent_id"] ?? 0;
    splitId = map["split_id"] ?? 0;
    head_count = map["head_count"] ?? 0;
    lname = map["lname"] ?? '';
    latitude = map["latitude"] ?? 0.0;
    longitude = map["longitude"] ?? 0.0;
    movement_time = map["movement_time"] ?? '';
    img = map["img"] ?? '';
    location = Location(
        lname: map["location"]["lname"]?? '',
        latitude: map["location"]["latitude"]?? 0.0,
        longitude: map["location"]["longitude"]?? 0.0);
  }
}
