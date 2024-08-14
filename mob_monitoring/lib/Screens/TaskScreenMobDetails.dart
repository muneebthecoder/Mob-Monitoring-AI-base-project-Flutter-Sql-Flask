import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/Model/CPoint.dart';
import 'package:mob_monitoring/Model/Mob.dart';
import 'package:mob_monitoring/Model/MobTrack.dart';
import 'package:mob_monitoring/Screens/Home.dart';
import 'package:video_player/video_player.dart';

class TaskScreenDetails extends StatefulWidget {
  const TaskScreenDetails({super.key});

  @override
  State<TaskScreenDetails> createState() => _TaskScreenDetailsState();
}

// await Future.delayed(Duration(seconds: 5));
class _TaskScreenDetailsState extends State<TaskScreenDetails> {
  int ind=0;
     List<CPoints> dlist = [];
  String selectedStation = "Select";
  Set<String> avd = {'Select'};
  TextEditingController dateC = TextEditingController();
  Mob? durMob;
  GoogleMapController? mapController;
  bool isvideo = false;
  int currentStep = 0;
  late LatLng currentLocation;
  Set<Polyline> _polylines = {};
  List<MobTracking> tlist = [];
  List<Marker> markers = [];
int mobIndex=0;
  List<List<MobTracking>> allmovelists=[];

  //late Future<List<MobTracking>> futureMobTracking;

  List<String> plist = ["Select Party", "PPP", "PMLN", "PTI", "JUI"];
  String selectedParty = "Select Party";

  List<String> mlist = ["Select"];
  String selectedMob = "Select";
  List<Mob> searchMobList = [];
  @override
  void initState() {
    super.initState();
    currentLocation = LatLng(33.641855, 73.077002);
    //  futureMobTracking = _fetchMobTracking();
  }

  // Future<List<MobTracking>> _fetchMobTracking() async {
  //   List<MobTracking> data =
  //       await APIHandler().getMobMovementsDetails(widget.mob.id);
  //   durMob = await APIHandler().FetchMobEndingDetails(widget.mob.id);
  //   _updateState(data);
  //   return data;
  // }

  // void _updateState(List<MobTracking> data) {
  //   setState(() {
  //     tlist = data;
  //     _updatePolylines();
  //     _updateMarkers();
  //   });
  // }

   void _updatePolylines()async {
    _polylines.clear();
    markers.clear();
           markers.add(
        Marker(
          markerId: MarkerId("${1}"),
          icon: BitmapDescriptor.defaultMarker,
          position:
              LatLng(allmovelists[mobIndex-1][0].location.latitude, allmovelists[mobIndex-1][0].location.longitude),
          infoWindow: InfoWindow(snippet: ""),
        ),
      );
    
    for (int i = 0; i < allmovelists[mobIndex-1].length - 1; i++) {
       markers.add(
        Marker(
          markerId: MarkerId("${i+1}"),
          icon:BitmapDescriptor.defaultMarker,
          position:
              LatLng(allmovelists[mobIndex-1][i+1].location.latitude, allmovelists[mobIndex-1][i+1].location.longitude),
          infoWindow: InfoWindow(snippet: ""),
        ),
      );
      if (allmovelists[mobIndex-1][i + 1].splitId == allmovelists[mobIndex-1][i + 1].parentId &&
          allmovelists[mobIndex-1][i + 1].splitId != 0) {
        int c = allmovelists[mobIndex-1]
            .indexWhere((element) => element.markerId == allmovelists[mobIndex-1][i + 1].splitId);
        LatLng start =
            LatLng(allmovelists[mobIndex-1][c].location.latitude, allmovelists[mobIndex-1][c].location.longitude);
        LatLng end = LatLng(
            allmovelists[mobIndex-1][i + 1].location.latitude, allmovelists[mobIndex-1][i + 1].location.longitude);

        _polylines.add(
          Polyline(
            polylineId: PolylineId('$i'),
            visible: true,
            points: [start, end],
            color: Colors.black,
            width: 3,
          ),
        );
      } else {
        LatLng start =
            LatLng(allmovelists[mobIndex-1][i].location.latitude, allmovelists[mobIndex-1][i].location.longitude);
        LatLng end = LatLng(
            allmovelists[mobIndex-1][i + 1].location.latitude, allmovelists[mobIndex-1][i + 1].location.longitude);

        _polylines.add(
          Polyline(
            polylineId: PolylineId('$i'),
            visible: true,
            points: [start, end],
            color: Colors.black,
            width: 3,
          ),
        );
      }
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        
      });

    }
  }

  // void _updateMarkers() {
  //   markers.clear();
  //   for (int i = 0; i < allmovelists[mobIndex-1].length; i++) {
  //     markers.add(
  //       Marker(
  //         markerId: MarkerId("$i"),
  //         icon: BitmapDescriptor.defaultMarker,
  //         position:
  //             LatLng(allmovelists[mobIndex-1][i].location.latitude, allmovelists[mobIndex-1][i].location.longitude),
  //         infoWindow: InfoWindow(snippet: ""),
  //       ),
  //     );
  //   }
  // }

  Future<VideoPlayerController> _initializeVideoPlayer(String videoUrl) async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    try {
      await controller.initialize();
      await controller.play();
    } catch (e) {
      print('Error initializing video player: $e');
    }
    return controller;
  }

  DateTime dateTime = DateTime(2024, 5, 24);
  String ftime = "12:00 PM";
  Future<DateTime?> pickdate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
  Future<TimeOfDay?> picktime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Political Mobs",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
          },
        ),
        //     actions: [Icon(Icons.settings)],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 235, 238, 239),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                        padding: EdgeInsets.only(left: 15.0),
                        isExpanded: true,
                        underline: Container(),
                        dropdownColor: Color.fromARGB(255, 235, 238, 239),
                        iconDisabledColor: Colors.black,
                        iconEnabledColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        value: selectedParty,
                        items: plist
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextStyle(fontSize: 13),
                                )))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedParty = value!;
                          });
                        }),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Container(
                  height: 40.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 235, 238, 239),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)
                      ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            child: Icon(
                          Icons.calendar_month_outlined,
                          size: 20.0,
                        )),
                        Container(
                          width: 100.0,
                          child: Center(
                            child: TextFormField(
                              style: TextStyle(fontSize: 13),
                              onTap: () async {
                                final date = await pickdate();
                                //       final time = await picktime();
                                //       if (time == null) return;
                                if (date == null) return;
                                //     ftime = _formatTime(time);
                                setState(() {
                                  dateTime = date;
                                  dateC.text =
                                      '${dateTime.year}/${dateTime.month}/${dateTime.day}';
                                });
                              },
                              readOnly: true,
                              controller: dateC,
                              cursorColor: Color.fromARGB(255, 60, 59, 59),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusColor: Color.fromARGB(255, 60, 59, 59),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 13.5, horizontal: 10.0),
                                  labelStyle: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [             Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),                      border: Border.all(color: Colors.black),

                              color: Color.fromARGB(255, 235, 238, 239),
                            ),
                            height: 40,
                            width: 150.0,
                            child: FutureBuilder(
                                future: APIHandler().GetAllCpb(),
                                builder: ((context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    );
                                  } else {
                                    dlist = snapshot.data!;

                                    dlist.forEach((element) {
                                      avd.add(element.location.lname);
                                    });

                                    if (dlist.length == 0) {
                                      return Center(
                                        child: Text('No Critical Points'),
                                      );
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Expanded(
                                        child: DropdownButton(
                                            padding:
                                                EdgeInsets.only(left: 15.0),
                                            icon: Icon(
                                                Icons.arrow_drop_down_sharp),
                                            iconSize: 30,
                                            isExpanded: true,
                                            underline: Container(),
                                            dropdownColor: Color.fromARGB(
                                                255, 235, 238, 239),
                                            iconDisabledColor: Colors.black,
                                            iconEnabledColor: Colors.black,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 19),
                                            value: selectedStation,
                                            items: avd
                                                .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e,
                                                      style: TextStyle(
                                                          fontSize: 11),
                                                    )))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedStation = value!;
                                                ind = dlist.indexWhere((element) => element.location.lname==selectedStation);
                                              });
                                            }),
                                      ),
                                    );
                                  }
                                })),
                          ),
                SizedBox(width: 50.0,),
                InkWell(
                  child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Center(
                          child: Text("Search",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)))),
                  onTap: () async {
                    if (selectedParty == "Select Party" || dateC.text == '' || selectedStation=="Select") {
                     
                    }else{
                      mlist.clear();
                      mlist.add("Select");
                       searchMobList = await APIHandler()
                          .FetchMobSimulation(selectedParty, dateC.text,ind+1);
                           setState(() {
                            
                          });
                          for(int i=0;i<searchMobList.length;i++){
                            mlist.add(searchMobList[i].location.lname);
                            allmovelists.add(await APIHandler().getMobMovementsDetails(searchMobList[i].id));
                          }
                          int a=0;
                          setState(() {
                            
                          });
                    }
                  },
                ),
                SizedBox(
                  width: 25.0,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 238, 239),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: Row(
                  children: [
                    Text(
                      "  Mobs:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 40,
                      width: 275.0,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 235, 238, 239),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: DropdownButton(
                            isExpanded: true,
                            underline: Container(),
                            dropdownColor: Color.fromARGB(255, 235, 238, 239),
                            iconDisabledColor: Colors.black,
                            iconEnabledColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            value: selectedMob,
                            items: mlist
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        e,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    )))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedMob = value!;
                                mobIndex = mlist.indexOf(selectedMob);
                                if(mobIndex>0){
                                // mapController?.animateCamera(
                                //   CameraUpdate.newCameraPosition(
                                //     CameraPosition(
                                //         target: LatLng(
                                //             allmovelists[mobIndex-1][0].latitude,
                                //             allmovelists[mobIndex-1][0]
                                //                 .longitude),
                                //         zoom: 14),
                                //   ),
                                // );                      
                                        _updatePolylines();

                                }
                              });
                              

                              setState(() {});
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                height: 365.0,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: GoogleMap(
                  gestureRecognizers: Set()
                    ..add(Factory<PanGestureRecognizer>(
                        () => PanGestureRecognizer()..onStart = (_) {})),
                  initialCameraPosition: CameraPosition(
                    target: currentLocation,
                    zoom: 13,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  markers: Set<Marker>.of(markers.map((marker) {
                    return Marker(
                      markerId: marker.markerId,
                      icon: marker.icon,
                     infoWindow: InfoWindow(
                          title:
                             'Marker ID: ${marker.markerId.value}',snippet: allmovelists[mobIndex-1].firstWhere((element) => element.markerId==int.parse(marker.markerId.value)).img==""?"No video Uploaded":"Uploaded"),
                      position: marker.position,
                      onTap: () async {
                        int mid=int.parse(marker.markerId.value);
                 String img=       allmovelists[mobIndex-1].firstWhere((element) => element.markerId==mid).img;
                     if(img==""){

                     }else{
                       VideoPlayerController? controller;
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Video",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 140.0),
                                GestureDetector(
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.black,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    isvideo = false;
                                controller==null? null:   controller!.pause();///////////////////////
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
                                    '${searchMobList[mobIndex-1].location.lname}',//////////////////////////////////////////
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            content:
                                StatefulBuilder(builder: (context, setstate) {
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
                                        child: isvideo == true
                                            ? FutureBuilder<
                                                VideoPlayerController>(
                                                future: _initializeVideoPlayer(
                                                    APIHandler.video + img),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    if (snapshot.hasError) {
                                                      return Center(
                                                        child: Text(
                                                            'Error loading video: ${snapshot.error}'),
                                                      );
                                                    }
                                                    controller = snapshot.data!;
                                                    return Chewie(
                                                        controller:
                                                            ChewieController(
                                                      videoPlayerController:
                                                          controller!,
                                                      autoPlay: true,
                                                      looping: false,
                                                      showControlsOnInitialize:
                                                          true,
                                                    ));
                                                  } else if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  } else {
                                                    return Center(
                                                        child: Text(
                                                            'Unknown error'));
                                                  }
                                                },
                                              )
                                            :
                                            // Chewie(
                                            //   controller: ChewieController(
                                            //     videoPlayerController:
                                            //         VideoPlayerController.networkUrl(
                                            //             Uri.parse(APIHandler.video +
                                            //                 mob.img))
                                            //           ..initialize().then((_) {
                                            //             setstate(() {});
                                            //           }),

                                            //     //      aspectRatio: 16/9,
                                            //     autoPlay: true,
                                            //     looping: false,
                                            //     showControlsOnInitialize: true,
                                            //   ),
                                            // ),

                                            Image.network(APIHandler.video +
                                                img.split('.')[0] +
                                                '.jpg')),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          child: Icon(
                                            Icons.image,
                                            size: 40,
                                          ),
                                          onTap: () {
                                            isvideo = false;
                                            controller!.pause();
                                            setstate(() {});
                                          },
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                            child: Icon(
                                              Icons.video_camera_back_outlined,
                                              size: 40,
                                            ),
                                            onTap: () {
                                              isvideo = true;
                                              setstate(() {});
                                            }),
                                            SizedBox(
                                          width: 10.0,
                                        ),
                                    Text("Strength: ${allmovelists[mobIndex-1].lastWhere((element) =>  element.markerId==mid).head_count}")
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                          );
                        });
                     }
                      },
                    );
                  }
                  )),
                  polylines: _polylines,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            InkWell(
              child: Container(
                  height: 40,
                  width: 340,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: Center(
                      child: Text("Start",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)))),
              onTap: () async {
                _updatePolylines();
              },
            ),
          ],
        ),
      ),
    );
  }
}
