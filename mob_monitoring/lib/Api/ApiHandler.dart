import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mob_monitoring/Model/CPoint.dart';
import 'package:mob_monitoring/Model/Drone.dart';
import 'package:mob_monitoring/Model/Mob.dart';
import 'package:mob_monitoring/Model/MobTrack.dart';
import 'package:mob_monitoring/Model/Station.dart';

class APIHandler {
  String base_url = 'http://192.168.0.123:5000/';
  static String imgr_url = 'http://192.168.0.123:5000/images/';
  static String Userimgr_url = 'http://192.168.0.123:5000/UserPic/';
  static String video = 'http://192.168.0.123:5000/videos/';

  //User
  Future<int> SignUp(
    String name,
    String password,
    String phone,
    String email,
    String role,
  ) async {
    String url = base_url + "SignUp";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["name"] = name;
    request.fields["email"] = email;
    request.fields["phone"] = phone;
    request.fields["password"] = password;
    request.fields["role"] = role;
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res.statusCode;
  }

  Future<http.Response> SignIn(String email, String pass) async {
    String url = base_url + "SignIn";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["password"] = pass;
    request.fields["email"] = email;
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res;
  }

  Future<http.Response> searchById(int id) async {
    String url = base_url + "SearchByID";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["id"] = id.toString();
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res;
  }

  Future<int> ChangePassword(String email, String pass) async {
    String url = base_url + "ChangePassword";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["password"] = pass;
    request.fields["email"] = email;
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res.statusCode;
  }

  Future<http.Response> uploadProfilePic(int id, File image) async {
    String url = base_url + "/UploadProfilePic";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["id"] = id.toString();
    http.MultipartFile imgfile =
        await http.MultipartFile.fromPath("img", image.path);
    request.files.add(imgfile);
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res;
  }

  Future<int> updateAccount(
    String name,
    String email,
    String phone,
    String role,
    int id,
    String password,
  ) async {
    String url = base_url + "UpdateAccountDetails";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["name"] = name;
    request.fields["email"] = email;
    request.fields["phone"] = phone;
    request.fields["user_id"] = id.toString();
    request.fields["password"] = password;
    request.fields["role"] = role;
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res.statusCode;
  }

  //Station
  Future<int> AddStation(
    String name,
    String lname,
    double longitude,
    double latitude,
    int capacity,
  ) async {
    String url = base_url + "AddStation";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["name"] = name;
    request.fields["lname"] = lname;
    request.fields["longitude"] = longitude.toString();
    request.fields["latitude"] = latitude.toString();
    request.fields["capacity"] = capacity.toString();
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res.statusCode;
  }

  Future<List<Station>> GetAllStation() async {
    String url = base_url + "ShowAllStation";
    List<Station> slist = [];

    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jlist = jsonDecode(response.body);
      for (int i = 0; i < jlist.length; i++) {
        slist.add(Station.fromMaps(jlist[i]));
      }
    }
    return slist;
  }

  Future<List<Drone>> availableDronesInStation(int id) async {
    String url = base_url + "AvailableDronesInStation";
    List<Drone> slist = [];
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["station_id"] = id.toString();
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    var jlist = jsonDecode(res.body);
    for (int i = 0; i < jlist.length; i++) {
      slist.add(Drone.fromMap(jlist[i]));
    }
    return slist;
  }

  //Drone
  Future<int> AddMob(
      String type,
      String starting_time,
      String lname,
      double longitude,
      double latitude,
      String strenght,
      String status,
      int user_id,
      String ptype,
      String critical,
      int cid
      ) async {
    String url = base_url + "AddMob";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["lname"] = lname;
    request.fields["longitude"] = longitude.toString();
    request.fields["latitude"] = latitude.toString();
    request.fields["type"] = type;
    request.fields["strength"] = strenght;
    request.fields["status"] = status;
    request.fields["starting_time"] = starting_time;
    request.fields["ending_time"] = "";
    request.fields["user_id"] = user_id.toString();
    request.fields["parent_id"] = (0).toString();
     request.fields["ptype"] = ptype;
    request.fields["critical"] = critical;
      request.fields["cid"] = cid.toString();

    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res.statusCode;
  }

  Future<List<Mob>> GetAllMob() async {
    String url = base_url + "ShowAllMob";
    List<Mob> slist = [];
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jlist = jsonDecode(response.body);
      for (int i = 0; i < jlist.length; i++) {
        slist.add(Mob.fromMap(jlist[i]));
      }
    }
    return slist;
  }

  //Drone
  Future<int> AddDrone(
    String type,
    String model,
    int battery_timing,
    int ceiling,
    int storage,
    int range,
    int isAvailable,
    int station_id,
    File img,
    String time,
  ) async {
    String url = base_url + "AddDrone";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["type"] = type;
    request.fields["time"] = time;
    request.fields["model"] = model;
    request.fields["battery_timing"] = battery_timing.toString();
    request.fields["ceiling"] = ceiling.toString();
    request.fields["storage"] = storage.toString();
    request.fields["range"] = range.toString();
    request.fields["isAvailable"] = isAvailable.toString();
    request.fields["station_id"] = station_id.toString();
    http.MultipartFile imgfile =
        await http.MultipartFile.fromPath("img", img.path);
    request.files.add(imgfile);
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res.statusCode;
  }

  Future<List<Drone>> GetAllDrone() async {
    String url = base_url + "ShowAllDrones";
    List<Drone> slist = [];
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jlist = jsonDecode(response.body);
      for (int i = 0; i < jlist.length; i++) {
        slist.add(Drone.fromMap(jlist[i]));
      }
    }
    return slist;
  }

  Future<List<Drone>> GetDroneByStatus(int status) async {
    String url = base_url + "GetAllDrones";
    List<Drone> slist = [];
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["isAvailable"] = status.toString();
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    var jlist = jsonDecode(res.body);
    for (int i = 0; i < jlist.length; i++) {
      slist.add(Drone.fromMap(jlist[i]));
    }
    return slist;
  }

  Future<int> AssignDroneToMob(
      String time, int location_id, int drone_id, int mob_id) async {
    String url = base_url + "AssignDroneToMob";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["time"] = time;
    request.fields["location_id"] = location_id.toString();
    request.fields["drone_id"] = drone_id.toString();
    request.fields["mob_id"] = mob_id.toString();

    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res.statusCode;
  }

  Future<http.Response> NearestStation(
      double latitude, double longitude) async {
    String url = base_url + "NearestStation";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["latitude"] = latitude.toString();
    request.fields["longitude"] = longitude.toString();
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res;
  }

  Future<List<MobTracking>> saveMovementsList(List<MobTracking> mlist) async {
    String url = base_url + "SaveMovements";
    Uri uri = Uri.parse(url);
    List<MobTracking> slist = [];

    var pmap = mlist.map((e) => e.toMap()).toList();
    var productjson = jsonEncode(pmap);

    http.MultipartRequest request = http.MultipartRequest('POST', uri);

    request.fields["movementList"] = productjson;

    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    var jlist = jsonDecode(res.body);
    for (int i = 0; i < jlist.length; i++) {
      slist.add(MobTracking.fromMap(jlist[i]));
    }
    return slist;
  }

  Future<List<MobTracking>> getMobMovementsDetails(int mob_id) async {
    String url = base_url + "FetchMovementsDetails";
    List<MobTracking> slist = [];
    Uri uri = Uri.parse(url);

    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["mob_id"] = mob_id.toString();
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    var jlist = jsonDecode(res.body);
    for (int i = 0; i < jlist.length; i++) {
      slist.add(MobTracking.fromMap(jlist[i]));
    }
    return slist;
  }

  Future<http.Response> terminateMob(
      int id, String status, String ending_time) async {
    String url = base_url + "TerminateMob";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["status"] = status;
    request.fields["id"] = id.toString();
    request.fields["ending_time"] = ending_time;
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res;
  }

  Future<Drone> fetchAssignDroneDetails(int id) async {
    String url = base_url + "FetchAssignDroneDetails";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["mob_id"] = id.toString();
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    var jlist = jsonDecode(res.body);
    Drone m = Drone.fromMap(jlist[0]);
    return m;
  }

  Future<int> saveImage(String captured_time, int drone_id, int mob_id,
      int move_id, XFile img) async {
    String url = base_url + "SaveImage";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["captured_time"] = captured_time;
    request.fields["drone_id"] = drone_id.toString();
    request.fields["mob_id"] = mob_id.toString();
    request.fields["move_id"] = move_id.toString();
    http.MultipartFile imgfile =
        await http.MultipartFile.fromPath("img", img.path);
    request.files.add(imgfile);
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    int jlist = jsonDecode(res.body);

    return jlist;
  }

  Future<Mob> FetchMobEndingDetails(int id) async {
    String url = base_url + "FetchMobEndingDetails";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["mob_id"] = id.toString();
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    var jlist = jsonDecode(res.body);
    Mob m = Mob.fromMap(jlist[0]);
    return m;
  }

  Future<http.Response> addParentMob(
      String type,
      String starting_time,
      double latitude,
      double longitude,
      String name,
      String strength,
      String status,
      int parent_id,
      int user_id) async {
    String url = base_url + "AddParentMob";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["type"] = type;
    request.fields["name"] = name;
    request.fields["starting_time"] = starting_time;
    request.fields["strength"] = strength;
    request.fields["status"] = status;
    request.fields["longitude"] = longitude.toString();
    request.fields["latitude"] = latitude.toString();
    request.fields["parent_id"] = parent_id.toString();
    request.fields["user_id"] = user_id.toString();

    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res;
  }

   Future<MobTracking> saveSingleMovementAndGet(
      int mob_id,
      String movement_time,
      double latitude,
      double longitude,
      String name,
      int mark_id,
      int type_id,
      int parent_id,
      int split_id) async {
    String url = base_url + "SingleMovement";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["mob_id"] = mob_id.toString();
    request.fields["lname"] = name;
    request.fields["movement_time"] = movement_time;
    request.fields["mark_id"] = mark_id.toString();
    request.fields["type_id"] = type_id.toString();
    request.fields["longitude"] = longitude.toString();
    request.fields["latitude"] = latitude.toString();
    request.fields["parent_id"] = parent_id.toString();
    request.fields["split_id"] = split_id.toString();

    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    MobTracking mt=MobTracking.fromMap(jsonDecode(res.body));
    return mt;
  }
  Future<List<Mob>> FetchMobSimulation(String ptype,String date,int cid) async {
    String url = base_url + "FetchMobSimulation";
    Uri uri = Uri.parse(url);
    List<Mob> slist = [];
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["party"] = ptype.toString();
    request.fields["date"] = date.toString();
    request.fields["cid"] = cid.toString();
    
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
          var jlist = jsonDecode(res.body);
      for (int i = 0; i < jlist.length; i++) {
        slist.add(Mob.fromMap(jlist[i]));
      }
    return slist;
  }

    Future<int> AddCriticalPoints(
    double latitude,
    double longitude,
    String name,
    String radius,
  ) async {
    String url = base_url + "AddCP";
    Uri uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields["latitude"] = latitude.toString();
    request.fields["longitude"] = longitude.toString();
    request.fields["name"] = name;
    request.fields["radius"] = radius.toString();
    var streamresponse = await request.send();
    http.Response res = await http.Response.fromStream(streamresponse);
    return res.statusCode;
  }

    Future<List<CPoints>> GetAllCpb() async {
    String url = base_url + "scp";
    List<CPoints> slist = [];
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jlist = jsonDecode(response.body);
      for (int i = 0; i < jlist.length; i++) {
        slist.add(CPoints.fromMaps(jlist[i]));
      }
    }
    return slist;
  }
}
