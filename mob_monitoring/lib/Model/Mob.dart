
import 'package:mob_monitoring/Model/Location.dart';

class Mob {
  late int id, parent_id, user_id;
  late String type, starting_time, ending_time, strength,status,duration;
  late Location location;
  late String criticalSection;
  late String ptype;
  late int cid;
  Mob(
      {this.id = -1,
      required this.type,
      required this.starting_time,
      required this.status,
      this.parent_id = 0});

  Mob.fromMap(Map<String, dynamic> map) {
    criticalSection=map["critical"]??"";
     cid=map["cid"]??0;
    ptype=map["ptype"]??"";
    id = map["id"] ??0;
    type = map["type"] ??'';
    starting_time = map["starting_time"] ?? '';
    ending_time = map["ending_time"] ?? '';
    parent_id = map["parent_id"] ?? 0;
    status = map["status"] ?? '';
    user_id = map["user_id"] ?? 0;
    strength = map["strength"] ?? '';
    duration = map["duration"]?? '';
    location = Location(
        id: map["location"]["id"]?? 0,
        lname: map["location"]["lname"]??'',
        latitude: map["location"]["latitude"]??0.0,
        longitude: map["location"]["longitude"]??0.0);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "type": type,
      "starting_time": starting_time,
      "ending_time": ending_time,
      "strength": strength,
      "status": status,
      "parent_id": parent_id,
      "user_id": user_id
    };
  }
}
