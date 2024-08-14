import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/Model/Mob.dart';
import 'package:mob_monitoring/Model/MobTrack.dart';
import 'package:video_player/video_player.dart';

class MobDetailScreen extends StatefulWidget {
  final Mob mob;
  const MobDetailScreen({required this.mob});

  @override
  State<MobDetailScreen> createState() => _MobDetailScreenState();
}

class _MobDetailScreenState extends State<MobDetailScreen> {
  GoogleMapController? mapController;
  bool isvideo = false;
  int currentStep = 0;
  late LatLng currentLocation;
  Set<Polyline> _polylines = {};
  List<MobTracking> tlist = [];
  List<Marker> markers = [];
  late Future<List<MobTracking>> futureMobTracking;
  // late Future<void> _initializeVideoPlayerFuture;
//   List<VideoPlayerController?> _controllers =[];
  Mob? durMob;

  @override
  void initState() {
    super.initState();
    currentLocation =
        LatLng(widget.mob.location.latitude, widget.mob.location.longitude);
    futureMobTracking = _fetchMobTracking();
  }

  Future<List<MobTracking>> _fetchMobTracking() async {
    List<MobTracking> data =
        await APIHandler().getMobMovementsDetails(widget.mob.id);
    durMob = await APIHandler().FetchMobEndingDetails(widget.mob.id);
    _updateState(data);
    return data;
  }

  void _updateState(List<MobTracking> data) {
    setState(() {
      tlist = data;
      _updatePolylines();
      _updateMarkers();
    });
  }

  void _updatePolylines() {
    _polylines.clear();
    for (int i = 0; i < tlist.length - 1; i++) {
      if (tlist[i + 1].splitId == tlist[i + 1].parentId &&
          tlist[i + 1].splitId != 0) {
        int c = tlist
            .indexWhere((element) => element.markerId == tlist[i + 1].splitId);
        LatLng start =
            LatLng(tlist[c].location.latitude, tlist[c].location.longitude);
        LatLng end = LatLng(
            tlist[i + 1].location.latitude, tlist[i + 1].location.longitude);

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
            LatLng(tlist[i].location.latitude, tlist[i].location.longitude);
        LatLng end = LatLng(
            tlist[i + 1].location.latitude, tlist[i + 1].location.longitude);

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
    }
  }

  void _updateMarkers() {
    markers.clear();
    for (int i = 0; i < tlist.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId("$i"),
          icon: BitmapDescriptor.defaultMarker,
          position:
              LatLng(tlist[i].location.latitude, tlist[i].location.longitude),
          infoWindow: InfoWindow(snippet: ""),
        ),
      );
    }
  }

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

  List<Step> _getSteps() {
    return tlist.map((mob) {
      return Step(
        state: StepState.complete,
        title: Text(mob.location.lname,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        subtitle: Text(mob.movement_time),
        content: ListTile(
          trailing: mob.img == ''
              ? Icon(Icons.videocam_off_outlined)
              : GestureDetector(
                  child: Icon(Icons.videocam_outlined),
                  onTap: () {
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
                                    controller!.pause();///////////////////////
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
                                    '${mob.location.lname}',
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
                                                    APIHandler.video + mob.img),
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
                                                mob.img.split('.')[0] +
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
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                          );
                        });
                  },
                ),
          title: Center(
              child: Text("Strength: ${mob.img == '' ? 0 : mob.head_count}",
                  style: TextStyle(fontSize: 16))),
        ),
      );
    }).toList();
  }

  // @override
  // void dispose() {
  //   for (var controller in _controllers) {
  //     controller!.dispose();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<MobTracking>>(
        future: futureMobTracking,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No Mob added'),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      height: 340.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: GoogleMap(
                        gestureRecognizers: Set()
                          ..add(Factory<PanGestureRecognizer>(
                              () => PanGestureRecognizer()..onStart = (_) {})),
                        initialCameraPosition: CameraPosition(
                          target: currentLocation,
                          zoom: 14,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                        markers: Set<Marker>.of(markers),
                        polylines: _polylines,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      width: 340.0,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 223, 229, 231),
                          border: Border.all(color: Colors.black)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Icon(Iconsax.map_1,size:40.0 ,color: Color.fromARGB(255, 24, 134, 181),),SizedBox(width: 5.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Type: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      Text(widget.mob.type)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Starting Time: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        widget.mob.starting_time,
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Starting Location: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        widget.mob.location.lname,
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Ending Time: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        widget.mob.ending_time,
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       "Duration: ",
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.w500,
                                  //           fontSize: 12),
                                  //     ),
                                  //     Text(
                                  //       durMob!.duration,
                                  //       style: TextStyle(fontSize: 12),
                                  //     )
                                  //   ],
                                  // ),
                                    Row(
                                    children: [
                                      Text(
                                        "Average Strenght: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        (double.parse(durMob!.strength)).round().toString(),
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Stepper(
                    physics: ClampingScrollPhysics(),
                    connectorColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 5, 183, 243)),
                    margin: EdgeInsets.all(4.0),
                    controlsBuilder: (context, details) {
                      return Container();
                    },
                    steps: _getSteps(),
                    onStepTapped: (index) {
                      setState(() {
                        currentStep = index;
                      });
                    },
                    currentStep: currentStep,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
