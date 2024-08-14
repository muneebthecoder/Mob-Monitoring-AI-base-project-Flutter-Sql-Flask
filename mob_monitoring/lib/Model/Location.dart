class Location {
  late int id;
  late String lname;
  late double latitude, longitude;

  Location({
    this.id = -1,
    required this.lname,
    required this.latitude,
    required this.longitude,
  });

  Location.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    lname = map["lname"];
    longitude = map["longitude"];
    latitude = map["latitude"];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "lname": lname,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
