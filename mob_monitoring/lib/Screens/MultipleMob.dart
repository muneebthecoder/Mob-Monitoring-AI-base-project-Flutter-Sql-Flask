// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:mob_monitoring/Model/Mob.dart';
// import 'package:mob_monitoring/Model/MobTrack.dart';

// class MultipleMobScreen extends StatefulWidget {
//   final List<Mob> mlist;
//   MultipleMobScreen({required this.mlist});

//   @override
//   State<MultipleMobScreen> createState() => _MultipleMobScreenState();
// }

// class _MultipleMobScreenState extends State<MultipleMobScreen> {
//   GoogleMapController? mapController;
//   int currentMob = 0;

//   List<Mob> all_mlist = [];
//   List<Marker> markers = [];
//   List<Polyline> _polylines = [];


//   List<List<MobTracking>> trackinglist = [];


//   int spid = 0;
//   String selectedLocationText = '';
//   int CompleteIncremt = 0;
//   bool markerStop = false;
//   int id = 1;
//   int spiltId = 0;
//   bool IsComplete = false;
//   bool IsSplitColor = false;
//   bool IsTrack = false;
//   bool markeeed = false;


//   @override
//   void initState() {
//     super.initState();
//     all_mlist = widget.mlist;

//     for (int i = 0; i < all_mlist.length; i++) {
//       markers.add(
//         Marker(
//           markerId: MarkerId('1'),
//           position: LatLng(
//               all_mlist[i].location.latitude, all_mlist[i].location.longitude),
//           draggable: true,
//           icon: BitmapDescriptor.defaultMarkerWithHue(
//               BitmapDescriptor.hueRed), // Change marker color here
//         ),
//       );
//     }
//     for (int i = 0; i < all_mlist.length; i++) {
//       trackinglist.add([
//         MobTracking(
//           markerId: 1,
//           lname: all_mlist[i].location.lname,
//           mobId: all_mlist[i].id,
//           latitude: all_mlist[i].location.latitude,
//           longitude: all_mlist[i].location.longitude,
//           typeId: 1,
//           splitId: 0,
//           parentId: 0,
//           movement_time:
//               DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
//         )
//       ]);
//     }
//   }

//    void _updatePolylines() {
//     int a=0;
//     for (int i = 0; i < trackinglist.length; i++) {
//       for (int j = 0; j < trackinglist[i].length-1; j++){
//               a++;
//       if (trackinglist[i][j + 1].splitId == trackinglist[i][j + 1].parentId &&
//           trackinglist[i][j + 1].splitId != 0) {
//         LatLng start = LatLng(
//             trackinglist[i][trackinglist[i][j + 1].splitId - 1].latitude,
//             trackinglist[i][trackinglist[i][j + 1].splitId - 1].longitude);
//         LatLng end =
//             LatLng(trackinglist[i][j + 1].latitude, trackinglist[i][j + 1].longitude);

//         _polylines.add(
//           Polyline(
//             polylineId: PolylineId('${a}'),
//             visible: true,
//             points: [start, end],
//             color: Colors.black,
//             width: 3,
//           ),
//         );
//       } else {
//         LatLng start =
//             LatLng(trackinglist[i][j].latitude, trackinglist[i][j].longitude);
//         LatLng end =
//             LatLng(trackinglist[i][j + 1].latitude, trackinglist[i][j + 1].longitude);

//         _polylines.add(
//           Polyline(
//             polylineId: PolylineId('${a}'),
//             visible: true,
//             points: [start, end],
//             color: Colors.black,
//             width: 3,
//           ),
//         );
//       }
//       }
//     }
//     setState(() {});
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${all_mlist.length}'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//           child: GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: LatLng(
//                   all_mlist[currentMob].location.latitude,
//                   all_mlist[currentMob]
//                       .location
//                       .longitude), // Center the map at (0, 0) initially
//               zoom: 15,
//             ),
//             onMapCreated: (GoogleMapController controller) {
//               mapController = controller;
//             },
//             markers: Set<Marker>.of(markers),
//             polylines:Set<Polyline>.of(_polylines),
//             onTap: (LatLng latLng)async{



//  if (
//                         //n == isSplitComplete &&
//                         markerStop == true) {
//                     } else {
//                       id = id + 1;
//                       Marker newMarker = Marker(
//                           markerId: MarkerId("$id"),
//                           position: LatLng(latLng.latitude, latLng.longitude),
//                           icon: BitmapDescriptor.defaultMarkerWithHue(
//                               IsSplitColor == true
//                                   ? BitmapDescriptor.hueBlue
//                                   : BitmapDescriptor.hueRed));
//                       //added to markers list
//                       markers.add(newMarker);

//                       IsSplitColor == true ? spiltId = id : 0;

//                       try {
//                         final List<Placemark> placemarks =
//                             await placemarkFromCoordinates(
//                                 latLng.latitude, latLng.longitude);
//                         if (placemarks.isNotEmpty) {
//                           final Placemark place = placemarks.first;
//                           setState(() {
//                             selectedLocationText =
//                                 "${place.subLocality}, ${place.locality}, ${place.country}";
//                           });
//                         } else {
//                           print('No placemarks found.');
//                         }
//                       } catch (e) {
//                         print('Caught an exception: $e');
//                       }

//                       //    IsSplitColor == true && n>isSplitComplete?:;
//                       markeeed == true ? spiltId = spid : null;

//                       MobTracking mt = MobTracking(
//                           movement_time: DateFormat('yyyy-MM-dd HH:mm:ss')
//                               .format(DateTime.now()),
//                           markerId: id,
//                           mobId: all_mlist[currentMob].id,
//                           lname: selectedLocationText,
//                           latitude: newMarker.position.latitude,
//                           longitude: newMarker.position.longitude,
//                           typeId:  1,
//                           parentId: markeeed == false
//                               ?
//                               //IsComplete == true ? spiltId:
//                               id - 1
//                               : spid,
//                           splitId: markeeed == false
//                               ? spiltId == 0 || id == spiltId
//                                   //         || IsSplitColor == true
//                                   ? trackinglist[currentMob].last.splitId
//                                   : spiltId
//                               : spid);
//                       markeeed = false;
//                       trackinglist[currentMob].add(mt);

//                       IsSplitColor = false;
//                       //         IsComplete = false;

//                       _updatePolylines();
//                       setState(() {
//                         for (var item in trackinglist[currentMob]) {
//                           print(
//                               "Mob Id: ${item.mobId}\n Marker Id: ${item.markerId}\n Latitude: ${item.latitude}\n Longitutde: ${item.longitude}\n Text : ${item.lname}\n Type Id: ${item.typeId}\n Parent Id: ${item.parentId}\n Split Id: ${item.splitId}\n");
//                         }
//                       });
//                     }



//             },
//           ),
//         ),
//       ),
//       floatingActionButton: ElevatedButton(
//         onPressed: (){
//           currentMob++;
//         },

//         child: Text("Next"),
//       ),
//     );
    
//   }
// }


import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/Model/Drone.dart';
import 'package:mob_monitoring/Model/Mob.dart';
import 'package:mob_monitoring/Model/MobMovements.dart';
import 'package:mob_monitoring/Model/MobTrack.dart';
import 'package:mob_monitoring/Screens/MobsScreen.dart';
import 'package:video_player/video_player.dart';

class MobTrackingScreenDemo extends StatefulWidget {
  final List<Mob> mlist;
  const MobTrackingScreenDemo({required this.mlist});
  @override
  State<MobTrackingScreenDemo> createState() => _MobTrackingScreenDemoState();
}

class _MobTrackingScreenDemoState extends State<MobTrackingScreenDemo> {
  TextEditingController strengthCT = TextEditingController();
  List<VideoPlayerController?> _videoControllers =
      List<VideoPlayerController?>.generate(20, (index) => null);
  final List<Drone> dobj = [];
  bool sendvideo = false;
  int stng = 0;
  int currentMob = 0;
  int mobIndex = 0;
  String selectedMob = "";
  List<Mob> all_mlist = [];
  String areaText = "";
  List<String> mlist = [];
  GoogleMapController? mapController;
  Set<Polyline> _polylines = {};
  // bool videoAvailable = false;
  int movessid = 0;
  // VideoPlayerController? _videoController;
  List<MobMovements> movementslist = [];
  XFile? video;
  int spid = 0;
  String selectedLocationText = '';
  bool markerStop = false;
  int id = 0;
  int spiltId = 0;
  // bool IsComplete = false;
  bool IsSplitColor = false;
  bool IsTrack = false;
  bool markeeed = false;
  bool nextMob = false;

  bool Ismarge = false;
  List<int> mklist=[];

  List<Marker> markers = [];

  List<List<MobTracking>> trackinglist = [];
  List<List<MobTracking>> gettrackinglist = [];
  @override
  void initState() {
    super.initState();
    all_mlist = widget.mlist;

    selectedMob = all_mlist[0].location.lname;

    for (int i = 0; i < all_mlist.length; i++) {
      id++;
      markers.add(
        Marker(
            markerId: MarkerId('$id'),
            position: LatLng(all_mlist[i].location.latitude,
                all_mlist[i].location.longitude),
            draggable: true,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
              title: "${all_mlist[i].location.lname}",
              snippet: "1",
            )),
      );

      trackinglist.add([
        MobTracking(
          markerId: id,
          moveId: 0,
          lname: all_mlist[i].location.lname,
          mobId: all_mlist[i].id,
          latitude: all_mlist[i].location.latitude,
          longitude: all_mlist[i].location.longitude,
          typeId: 1,
          splitId: 0,
          parentId: 0,
          movement_time:
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        )
      ]);
      mlist.add(all_mlist[i].location.lname);
    }
    loaddetails();
  }

  void loaddetails() async {
    for (int i = 0; i < all_mlist.length; i++) {
      dobj.add(await APIHandler().fetchAssignDroneDetails(all_mlist[i].id));
    }
  }

  int a = 0;

  void _updatePolylines() {
    if (markers.length < 2) {
      return;
    }

    for (int i = 0; i < trackinglist.length; i++) {
      for (int j = 0; j < trackinglist[i].length - 1; j++) {
        a++;
        if (trackinglist[i][j + 1].splitId == trackinglist[i][j + 1].parentId &&
            trackinglist[i][j + 1].splitId != 0) {
          int c = trackinglist[i].indexWhere(
              (element) => element.markerId == trackinglist[i][j + 1].splitId);
          LatLng start =
              LatLng(trackinglist[i][c].latitude, trackinglist[i][c].longitude);
          LatLng end = LatLng(trackinglist[i][j + 1].latitude,
              trackinglist[i][j + 1].longitude);

          _polylines.add(
            Polyline(
              polylineId: PolylineId('${a}'),
              visible: true,
              points: [start, end],
              color: Colors.black,
              width: 8,
              patterns: [PatternItem.dot],
            ),
          );
        } else {
          LatLng start =
              LatLng(trackinglist[i][j].latitude, trackinglist[i][j].longitude);
          LatLng end = LatLng(trackinglist[i][j + 1].latitude,
              trackinglist[i][j + 1].longitude);

          _polylines.add(
            Polyline(
              polylineId: PolylineId('${a}'),
              visible: true,
              points: [start, end],
              color: Colors.black,
              width: 8,
              patterns: [PatternItem.dot],
            ),
          );
        }
      }
    }
    setState(() {});
  }

  Future<void> _pickVideo(int index, StateSetter setState) async {
    XFile? pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (_videoControllers[index] != null) {
        _videoControllers[index]!.dispose();
      }

      _videoControllers[index] =
          VideoPlayerController.file(File(pickedFile.path))
            ..initialize().then((_) {
              setState(() {
                video = null;
                video = XFile(pickedFile.path);
              });
            });
    }
  }

  @override
  void dispose() {
    for (var controller in _videoControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Mob Tracking",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 340,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: DropdownButton(
                    isExpanded: true,
                    underline: Container(),
                    dropdownColor: Color.fromARGB(255, 255, 255, 255),
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    value: selectedMob,
                    items: mlist
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(fontSize: 16),
                            )))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
             //           trackinglist[currentMob][0];
                //        if (IsTrack == true) {
                          selectedMob = value!;
                          mobIndex = mlist.indexOf(selectedMob);
                          mapController?.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                  target: LatLng(
                                      trackinglist[mobIndex][0].latitude,
                                      trackinglist[mobIndex][0].longitude),
                                  zoom: 14),
                            ),
                          );
                //        }
                      });
                    }),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              height: 440.0,
              width: 340.0,
              child: Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(all_mlist[mobIndex].location.latitude,
                        all_mlist[mobIndex].location.longitude),
                    zoom: 14,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  polylines: _polylines,
                  onTap: (LatLng latLng) async {
                    if (markerStop == true) {
                    } else {
                      id = id + 1;
                      try {
                        final List<Placemark> placemarks =
                            await placemarkFromCoordinates(
                                latLng.latitude, latLng.longitude);
                        if (placemarks.isNotEmpty) {
                          final Placemark place = placemarks.first;
                          setState(() {
                            selectedLocationText =
                                "${place.subLocality}, ${place.locality}, ${place.country}";
                            areaText = "${place.subLocality}";
                          });
                        } else {
                          print('No placemarks found.');
                        }
                      } catch (e) {
                        print('Caught an exception: $e');
                      }
                      String s = id.toString();
                      Marker newMarker = Marker(
                          markerId: MarkerId(s),
                          position: LatLng(latLng.latitude, latLng.longitude),
                          draggable: true,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              IsSplitColor == true
                                  ? BitmapDescriptor.hueBlue
                                  : BitmapDescriptor.hueRed),
                          infoWindow: InfoWindow(
                              title: "$selectedLocationText", snippet: ''));

                      //added to markers list
                      markers.add(newMarker);

                      IsSplitColor == true ? spiltId = id : 0;

                      markeeed == true ? spiltId = spid : null;

                      MobTracking mt = MobTracking(
                          moveId: 0,
                          movement_time: DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(DateTime.now()),
                          markerId: id,
                          mobId: all_mlist[mobIndex].id,
                          lname: selectedLocationText,
                          latitude: newMarker.position.latitude,
                          longitude: newMarker.position.longitude,
                          typeId: 1,
                          parentId: markeeed == false
                              ?
                              //     nextMob==true?1:
                              id - 1
                              : spid,
                          splitId: markeeed == false
                              ? spiltId == 0 || id == spiltId
                                  ? trackinglist[mobIndex].last.splitId
                                  : spiltId
                              : spid);
                      markeeed = false;
                      trackinglist[mobIndex].add(mt);

                      IsSplitColor = false;
                      nextMob = false;
                       mklist.add(id);
                      _updatePolylines();
                      setState(() {
                        for (var item in trackinglist[mobIndex]) {
                          print(
                              "Mob Id: ${item.mobId}\n Marker Id: ${item.markerId}\n Latitude: ${item.latitude}\n Longitutde: ${item.longitude}\n Text : ${item.lname}\n Type Id: ${item.typeId}\n Parent Id: ${item.parentId}\n Split Id: ${item.splitId}\n");
                        }
                      });
                    }
                  },
                  markers: Set<Marker>.of(markers.map((marker) {
                    return Marker(
                      markerId: marker.markerId,
                      icon: marker.icon,
                      infoWindow: InfoWindow(
                          title: IsTrack == true
                              ? 'Mob ${mobIndex + 1}'
                              : 'Marker ID: ${marker.markerId.value}',
                          snippet: IsTrack == true ? "" : ""),
                      position: marker.position,
                      onTap: () async {
                        sendvideo = false;
                        spid = int.parse(marker.markerId.value);
                        mklist.add(spid);
                        markeeed = true;
                        if (Ismarge == true) {
                          MobTracking mt = MobTracking(
                              markerId: 0,
                              lname: "",
                              mobId: 0,
                              latitude: 0,
                              longitude: 0,
                              typeId: 0,
                              parentId: 0,
                              splitId: 0,
                              movement_time: "",
                              moveId: 0);
                          for (int i = 0; i < trackinglist.length; i++) {
                            for (int j = 0; j < trackinglist[i].length; j++) {
                              if (trackinglist[i][j].markerId ==
                                  int.parse(marker.markerId.value)) {
                                mt = trackinglist[i][j];
                              }
                            }
                          }
                          mt.movement_time = DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(DateTime.now());
                              mt.parentId=mklist[mklist.length-1];
                          trackinglist[mobIndex].add(mt);
                          _updatePolylines();
                          Ismarge=false;
                        }
                        // movessid = trackinglist[mobIndex]
                        //     .firstWhere((element) =>
                        //         element.markerId ==
                        //         int.parse(marker.markerId.value))
                        //     .moveId;

                        for (int i = 0; i < trackinglist.length; i++) {
                          for (int j = 0; j < trackinglist[i].length; j++) {
                            if (trackinglist[i][j].markerId ==
                                int.parse(marker.markerId.value)) {
                              movessid = trackinglist[i][j].moveId;
                            }
                          }
                        }

                        // videoAvailable = movementslist
                        //     .where((element) => element.movement_id == movessid)
                        //     .isNotEmpty;

                        print("marker iddd      " + marker.markerId.value);
                        print("moveeeeidddd       " + movessid.toString());
                        //                  print("videoooavailble   " + videoAvailable.toString());
                        if (IsTrack == true) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  icon: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Add Video",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 100.0),
                                      GestureDetector(
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.black,
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          // _videoController = null;
                                          // _videoController?.dispose();
                                          _videoControllers[int.parse(
                                                      marker.markerId.value)] ==
                                                  null
                                              ? null
                                              : _videoControllers[int.parse(
                                                      marker.markerId.value)]!
                                                  .pause();
                                        },
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.white,
                                  title: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 15.0,
                                        ),
                                        Text(
                                          '${marker.infoWindow.title}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  content: StatefulBuilder(
                                      builder: (context, setstate) {
                                    return Container(
                                      height: 220.0,
                                      child: Column(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              width: 300.0,
                                              height: 150.0,
                                              child: GestureDetector(
                                                  onTap: () async {
                                                    _pickVideo(
                                                        int.parse(marker
                                                            .markerId.value),
                                                        setstate);
                                                  },
                                                  child: _videoControllers[
                                                              int.parse(marker
                                                                  .markerId
                                                                  .value)] !=
                                                          null
                                                      ? Chewie(
                                                          controller:
                                                              ChewieController(
                                                            videoPlayerController:
                                                                _videoControllers[
                                                                    int.parse(marker
                                                                        .markerId
                                                                        .value)]!,
                                                            autoPlay: true,
                                                            looping: false,
                                                            showControlsOnInitialize:
                                                                true,
                                                          ),
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .video_call_rounded,
                                                          size: 50.0,
                                                        ))),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                sendvideo == true
                                                    ? FutureBuilder(
                                                        future: APIHandler()
                                                            .saveImage(
                                                                DateFormat(
                                                                        'yyyy-MM-dd HH:mm:ss')
                                                                    .format(DateTime
                                                                        .now()),
                                                                dobj[mobIndex]
                                                                    .drone_id,
                                                                //      18,
                                                                all_mlist[
                                                                        mobIndex]
                                                                    .id,
                                                                //       15,

                                                                movessid,
                                                                //               157,
                                                                video!),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            // Show the circular progress indicator while waiting
                                                            return CircularProgressIndicator(
                                                              color:
                                                                  Colors.blue,
                                                            );
                                                          } else if (snapshot
                                                              .hasError) {
                                                            print(
                                                                "'Error in: ${snapshot.error} ${snapshot.data}'");
                                                            // Show error message if there is an error
                                                            return Text(
                                                              'Error in: ${snapshot.error} \n ${snapshot.data}',
                                                              style: TextStyle(
                                                                  fontSize: 8),
                                                            );
                                                          } else {
                                                            WidgetsBinding
                                                                .instance
                                                                .addPostFrameCallback(
                                                                    (_) {
                                                              setstate(() {
                                                                stng = snapshot
                                                                    .data!;
                                                                strengthCT
                                                                        .text =
                                                                    stng.toString();
                                                                sendvideo =
                                                                    false;

                                                                movementslist.add(MobMovements(
                                                                    movement_id:
                                                                        movessid,
                                                                    head_cout:
                                                                        stng,
                                                                    video:
                                                                        video!,
                                                                    mob_id:
                                                                        all_mlist[mobIndex]
                                                                            .id,
                                                                    markid: int.parse(marker
                                                                        .markerId
                                                                        .value)));
                                                                stng = 0;

                                                                setstate(() {});
                                                                setState(() {});
                                                              });
                                                            });

                                                            // Show the result when the future is complete
                                                            return Icon(Icons
                                                                .groups_outlined);
                                                          }
                                                        },
                                                      )
                                                    : Icon(
                                                        Icons.groups_outlined),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                movementslist
                                                        .where((element) =>
                                                            element.markid ==
                                                            int.parse(marker
                                                                .markerId
                                                                .value))
                                                        .isNotEmpty
                                                    ? Text(
                                                        "Strength : ${movementslist.firstWhere((element) => element.markid == int.parse(marker.markerId.value)).head_cout}",
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      )
                                                    : Text(
                                                        "Strength : $stng",
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                SizedBox(
                                                  width: 15.0,
                                                ),
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0))),
                                                    onPressed: () async {
                                                      if (_videoControllers[
                                                              int.parse(marker
                                                                  .markerId
                                                                  .value)] ==
                                                          null) {
                                                        sendvideo = true;
                                                        setstate(() {});
                                                        setState(() {});
                                                      }
                                                      for (var item
                                                          in movementslist) {
                                                        print(
                                                            "Movement Id: ${item.movement_id}\n Video: ${item.video.path}\n Head Count: ${item.head_cout}\n Mob Id: ${item.mob_id}\n");
                                                      }
                                                    },
                                                    child: Text(
                                                      "Save",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                                );
                              });
                        }
                      },
                    );
                  })),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 Radio(
                  value: true,
                  groupValue: Ismarge,
                  onChanged: (value) {
                    setState(() {
                      Ismarge = true;
             //         print(Ismarge);
                    });
                  },
                  activeColor: Colors.blue,
                ),
                Text(
                  'Merge',
                  style: TextStyle(color: Colors.black),
                ),
                Radio(
                  value: true,
                  groupValue: IsSplitColor,
                  onChanged: (value) {
                    setState(() {
                      markerStop == true ? null : IsSplitColor = value as bool;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                Text(
                  'Split',
                  style: TextStyle(color: Colors.black),
                ),
                Checkbox(
                  shape: CircleBorder(),
                  activeColor: Colors.blue,
                  value: nextMob,
                  onChanged: (bool? value) {
                    setState(() {
                      if (IsTrack == false) {
                        nextMob = value!;
                        IsSplitColor = false;
                        Ismarge=false;
                        markerStop = !markerStop;
                      }
                    });
                  },
                ),
                // Radio(
                //   value: true,
                //   groupValue: nextMob,
                //   onChanged: (bool? value) {
                //     setState(() {
                //       nextMob = value!;
                //       IsSplitColor = false;

                //       all_mlist.length > currentMob + 1
                //           ? currentMob++
                //           : markerStop = true;
                //     });
                //   },
                //   activeColor: Colors.blue,
                // ),
                Text(
                  'Complete',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 30.0,
                ),
              ],
            ),
            Container(
              height: 40.0,
              width: 300,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 235, 238, 239),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(child: Icon(Icons.groups_outlined)),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 240,
                      child: TextFormField(
                        style: TextStyle(fontSize: 14),
                        readOnly: true,
                        controller: strengthCT,
                        cursorColor: Color.fromARGB(255, 60, 59, 59),
                        decoration: InputDecoration(
                            hintText: "Strength",
                            border: InputBorder.none,
                            focusColor: Color.fromARGB(255, 60, 59, 59),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Center(
                          child: Text("Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)))),
                  onTap: () async {
                    if (nextMob == true && IsTrack == false) {
                      if (currentMob < all_mlist.length) {
                        // gettrackinglist.add(await APIHandler()
                        //     .saveMovementsList(trackinglist[currentMob]));
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Text(
                                      'Mob Saved. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Icon(
                                      Icons.check_box,
                                      color: Colors.green,
                                    )
                                  ],
                                ),
                              );
                            });
                        if (currentMob + 1 == all_mlist.length) {
                     //     trackinglist = gettrackinglist;
                          IsTrack = true;
                        } else {
                          currentMob++;
                          mapController?.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                  target: LatLng(
                                      trackinglist[currentMob][0].latitude,
                                      trackinglist[currentMob][0].longitude),
                                  zoom: 14),
                            ),
                          );
                          nextMob = false;
                          markerStop = false;
                        }
                      }
                    }
                    setState(() {});
                  },
                ),
                SizedBox(
                  width: 35.0,
                ),
                InkWell(
                  child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Center(
                          child: Text("Terminate",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)))),
                  onTap: () async {
                    // await APIHandler().terminateMob(
                    //     all_mlist[mobIndex].id,
                    //     "Completed",
                    //     DateFormat('yyyy-MM-dd HH:mm:ss')
                    //         .format(DateTime.now()));
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return MobScreen();
                    }));
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Row(
                              children: [
                                Text(
                                  'Mob ${mobIndex + 1} Terminated. ',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Icon(
                                  Icons.check_box,
                                  color: Colors.green,
                                )
                              ],
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
