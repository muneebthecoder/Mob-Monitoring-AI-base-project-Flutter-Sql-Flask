import 'dart:io';

class Drone {
  late int drone_id, battery_timing, storage, ceiling, range;
  late String type, model, img;
  late bool isAvailable;
  late File pickimg;
  Drone({
    this.drone_id = -1,
    required this.type,
    required this.battery_timing,
    required this.model,
    required this.storage,
    required this.ceiling,
    required this.range,
    required this.img,
    required this.isAvailable,
  });

  Drone.fromMap(Map<String, dynamic> map) {
    drone_id = map["id"] ?? 0;
    type = map["type"] ?? "";
    model = map["model"] ?? "";
    storage = map["storage"] ?? 0;
    battery_timing = map["battery_timing"] ?? 0;
    ceiling = map["ceiling"] ?? 0;
    img = map["img"] ?? "";
    range = map["range"] ?? 0;
    isAvailable = map["isAvailable"] ?? false;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "type": type,
      "model": model,
      "battery_timing": battery_timing,
      "storage": storage,
      "ceiling": ceiling,
      "img": img,
      "range": range,
      "isAvailable": isAvailable,
    };
  }
}
