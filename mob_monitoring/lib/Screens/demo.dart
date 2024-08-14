// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Google Map Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ButtonScreen(),
//     );
//   }
// }

// class ButtonScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Button Screen'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: ()async {

//             // In the calling widget where you navigate to another screen
// Map<dynamic, dynamic> result = await Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => MapScreen()),
//             );

// // Now you can access the values of 'location' and 'text' from the result map
// if (result ==true) {
//   LatLng location = result['location'];
//   String text = result['text'];
//   // Use the values as needed
//   print(text);
//   print(location.latitude);
//   print(location.longitude);
// }

//           },
//           child: Text('Open Map'),
//         ),
//       ),
//     );
//   }
// }

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? mapController;
//   late LatLng selectedLocation;
//   static const LatLng currentLocation = LatLng(33.641855, 73.077002);

//   String selectedLocationText = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map Screen'),
//       ),
//       body: Column(
//         children: [
//           TextField(
//             decoration: InputDecoration(
//               hintText: 'Search location',
//               suffixIcon: Icon(Icons.search),
//             ),
//             onTap: () async {
//               Prediction? prediction = await PlacesAutocomplete.show(
//                 context: context,
//                 apiKey: '<Your Google Maps API Key>',
//                 language: 'en',
//               );
//               if (prediction != null) {
//                 displayPrediction(prediction);
//               }
//             },
//           ),
//           Expanded(
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: currentLocation,
//                 zoom: 15,
//               ),
//               onMapCreated: (GoogleMapController controller) {
//                 mapController = controller;
//               },
//               onTap: _selectLocation,
//               markers: Set<Marker>.of(markers),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Handle saving the selected location here
//           // For demonstration, let's just navigate back to the previous screen
//           Navigator.pop(context, {
//             'location': selectedLocation,
//             'text': selectedLocationText,
//           });
//           print(selectedLocation);
//         },
//         child: Icon(Icons.save),
//       ),
//     );
//   }

//   void _selectLocation(LatLng latLng) async {
//     selectedLocation = latLng;
//     final List<Placemark> placemarks = await placemarkFromCoordinates(
//         latLng.latitude, latLng.longitude);
//     final Placemark place = placemarks.first;
//     setState(() {
//       selectedLocationText =
//           "${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//     });
//     mapController?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: latLng, zoom: 15),
//       ),
//     );
//     _addMarker(latLng);
//   }

//   List<Marker> markers = [];

//   void _addMarker(LatLng latLng) {
//     setState(() {
//       markers.clear(); // Clear existing markers
//       markers.add(
//         Marker(
//           markerId: MarkerId('selectedLocation'),
//           position: latLng,
//           draggable: true,
//           infoWindow: InfoWindow(
//             title: 'Selected Location',
//             snippet: selectedLocationText,
//           ),
//           icon: BitmapDescriptor.defaultMarkerWithHue(
//               BitmapDescriptor.hueBlue),
//         ),
//       );
//     });
//   }

//   void displayPrediction(Prediction prediction) async {
//     GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: '<Your Google Maps API Key>');
//     PlacesDetailsResponse detail =
//     await _places.getDetailsByPlaceId(prediction.placeId!);
//     final lat = detail.result.geometry!.location.lat;
//     final lng = detail.result.geometry!.location.lng;
//     LatLng latLng = LatLng(lat, lng);
//     _selectLocation(latLng);
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DTime extends StatefulWidget {
//   const DTime({super.key});

//   @override
//   State<DTime> createState() => _DTimeState();
// }

// class _DTimeState extends State<DTime> {
//   DateTime dateTime = DateTime(2022, 12, 24);
//   String ftime = "12:00 PM";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           ElevatedButton(
//               onPressed: () async {
//                 final date = await pickdate();
//                 final time = await picktime();
//                 if (time == null) return;
//                 if (date == null) return;
//                 ftime = _formatTime(time);
//                 final newDateTime = DateTime(
//                   dateTime.year,
//                   dateTime.month,
//                   dateTime.day,
//                 );
//                 setState(() {
//                   dateTime = newDateTime;
//                 });
//               },
//               child: Text(
//                   '${dateTime.year}/${dateTime.month}/${dateTime.day} ${ftime}'))
//         ],
//       ),
//     );
//   }

//   Future<DateTime?> pickdate() => showDatePicker(
//       context: context,
//       initialDate: dateTime,
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100));
//   Future<TimeOfDay?> picktime() => showTimePicker(
//       context: context,
//       initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
//   String _formatTime(TimeOfDay time) {
//     final now = DateTime.now();
//     final dateTime =
//         DateTime(now.year, now.month, now.day, time.hour, time.minute);
//     return DateFormat('h:mm a').format(dateTime);
//   }
// }

// Stack(
//         children: [
//           SpinCircleBottomBarHolder(
//               bottomNavigationBar: SCBottomBarDetails(
//                   actionButtonDetails: SCActionButtonDetails(
//                       color: Colors.black, icon: Icon(Icons.add), elevation: 0),
//                   items: [
//                     SCBottomBarItem(
//                         title: "Home",
//                         icon: Icons.home,
//                         onPressed: () {
//                           setState(() {
//                             selectedIndex = 0;
//                           });
//                         }),
//                     SCBottomBarItem(
//                         title: "Notifications",
//                         icon: Icons.notifications,
//                         onPressed: () {
//                           setState(() {
//                             selectedIndex = 0;
//                           });
//                         }),
//                     SCBottomBarItem(
//                         title: "Mob List",
//                         icon: Icons.list_alt_outlined,
//                         onPressed: () {
//                           setState(() {
//                             selectedIndex = 0;
//                           });
//                         }),
//                     SCBottomBarItem(
//                         title: "profile",
//                         icon: Icons.person,
//                         onPressed: () {
//                           setState(() {
//                             selectedIndex = 0;
//                           });
//                         }),
//                   ],
//                   circleItems: [
//                     SCItem(
//                         icon: Icon(
//                           Icons.add,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {
//                           Navigator.of(context)
//                               .push(MaterialPageRoute(builder: (context) {
//                             return AddDroneScreen();
//                           }));
//                         }),
//                     SCItem(
//                         icon: Icon(Icons.add, color: Colors.white),
//                         onPressed: () {
//                           Navigator.of(context)
//                               .push(MaterialPageRoute(builder: (context) {
//                             return AddMobScreen();
//                           }));
//                         }),
//                     SCItem(
//                         icon: Icon(Icons.add,
//                             color: Colors.white),
//                         onPressed: () {
//                           Navigator.of(context)
//                               .push(MaterialPageRoute(builder: (context) {
//                             return AddStationScreen();
//                           }));
//                         }),
//                   ],
//                   circleColors: [
//                     Colors.black,
//                     Colors.black,
//                     Colors.black,
//                   ]),
//               child: widgetScreen[selectedIndex]),
//           Positioned(
//             bottom: 110,
//             left: MediaQuery.of(context).size.width / 3.4 - 12,
//             child: Transform.rotate(angle: -00.99,
//               child: Text(
//                 'Station',
//                 style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 165,
//             left: MediaQuery.of(context).size.width / 2.03 - 12,
//             child: Text(
//               'Mob',
//               style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
//             ),
//           ),
//           Positioned(
//             bottom: 110,
//             right: MediaQuery.of(context).size.width / 3.3 - 12,
//             child: Transform.rotate(angle: 0.99,
//               child: Text(
//                 'Drone',
//                 style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MapScreen(),
//     );
//   }
// }

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? mapController;
//   LatLng _sourceLocation = LatLng(37.4219999, -122.0840575); // Example source location
//   LatLng _destinationLocation = LatLng(37.7749, -122.4194); // Example destination location
//   Set<Marker> _markers = {};
//   Set<Polyline> _polylines = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map with Polylines'),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: _sourceLocation,
//           zoom: 12.0,
//         ),
//         markers: _markers,
//         polylines: _polylines,
//         onMapCreated: (GoogleMapController controller) {
//           mapController = controller;
//           _addMarkers();
//           _addPolyline();
//         },
//       ),
//     );
//   }

//   void _addMarkers() {
//     _markers.add(
//       Marker(
//         markerId: MarkerId('source'),
//         position: _sourceLocation,
//         icon: BitmapDescriptor.defaultMarker,
//       ),
//     );
//     _markers.add(
//       Marker(
//         markerId: MarkerId('destination'),
//         position: _destinationLocation,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//       ),
//     );
//   }

//   void _addPolyline() {
//     _polylines.add(
//       Polyline(
//         polylineId: PolylineId('route1'),
//         visible: true,
//         points: [_sourceLocation, _destinationLocation],
//         color: Colors.blue,
//         width: 3,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class demosc extends StatefulWidget {
//   @override
//   State<demosc> createState() => _demoscState();
// }

// class _demoscState extends State<demosc> {
//   GoogleMapController? mapController;
//   List<LatLng> _polylineCoordinates = [];
//   Set<Polyline> _polylines = {};
//   List<Marker> markers = [
//     Marker(
//       markerId: MarkerId("1"),
//       icon: BitmapDescriptor.defaultMarker,
//       position: LatLng(33.641855, 73.077002),
//     ),
//   ];
//   int id = 1;
//   int splitId = 0;
//   bool isComplete = false;
//   bool isSplit = false;

//   void _updatePolylines() {
//     if (markers.length < 2) {
//       return;
//     }
//     List<LatLng> points = [];
//     for (int i = 0; i < markers.length - 1; i++) {
//       points.add(markers[i].position);
//       points.add(markers[i + 1].position);
//     }
//     setState(() {
//       _polylineCoordinates = points;
//       // Add the new polyline to the current polylines
//       _polylines.add(
//         Polyline(
//           polylineId: PolylineId("route$id"),
//           color: Colors.red,
//           points: _polylineCoordinates,
//           width: 3,
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey,
//       appBar: AppBar(
//         title: Text(
//           "Mob Tracking",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blueGrey,
//         elevation: 0,
//         leading: GestureDetector(
//           child: Icon(
//             Icons.arrow_back_sharp,
//             color: Colors.white,
//           ),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 450.0,
//                 width: 500.0,
//                 child: Expanded(
//                   child: GoogleMap(
//                     initialCameraPosition: CameraPosition(
//                       target: LatLng(33.641855, 73.077002),
//                       zoom: 14,
//                     ),
//                     onMapCreated: (GoogleMapController controller) {
//                       mapController = controller;
//                     },
//                     polylines: _polylines,
//                     onTap: (LatLng latLng) {
//                       id++;
//                       Marker newMarker = Marker(
//                         markerId: MarkerId(id.toString()),
//                         position: LatLng(latLng.latitude, latLng.longitude),
//                         icon: BitmapDescriptor.defaultMarkerWithHue(
//                           isSplit ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueRed,
//                         ),
//                       );
//                       markers.add(newMarker);
//                       isSplit ? splitId = id : splitId = 0;
//                       isSplit = false;
//                       _updatePolylines();
//                       setState(() {});
//                     },
//                     markers: Set<Marker>.of(markers),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 isSplit = true;
//               });
//             },
//             child: Text("Split"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 isComplete = true;
//            //     id++; // Create a new polyline ID
//                 // Store the previous polylines
//                 Set<Polyline> previousPolylines = _polylines;
//                 markers = [markers.first]; // Start a new route from the first marker
//                 _updatePolylines();
//                 // Add the previous polylines to the current polylines
//                 _polylines.addAll(previousPolylines);
//               });
//               if (markers.isNotEmpty) {
//                 mapController?.animateCamera(
//                   CameraUpdate.newCameraPosition(
//                     CameraPosition(target: markers.first.position, zoom: 14),
//                   ),
//                 );
//               }
//             },
//             child: Text("Complete"),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void _updatePolylines() {
//   List<LatLng> points = [];
//   //  List<LatLng> points2 = [];
//   // if (trackinglist.length > 1) {
//   //   for (int i = 0; i < trackinglist.length - 1; i++) {
//   //     if (trackinglist[i].splitId == 0) {
//   //       points
//   //           .add(LatLng(trackinglist[i].latitude, trackinglist[i].longitude));
//   //       points.add(LatLng(
//   //           trackinglist[i + 1].latitude, trackinglist[i + 1].longitude));
//   //     }
//   //     if (trackinglist[i].splitId >= 1) {
//   //       // if (trackinglist[i + 1].splitId == trackinglist[i + 1].parentId) {
//   //       //   points.add(LatLng(
//   //       //       trackinglist[i + 1].latitude, trackinglist[i + 1].longitude));
//   //       //   points.add(LatLng(trackinglist[spiltId - 1].latitude,
//   //       //       trackinglist[spiltId - 1].longitude));
//   //       // }
//   //       // else
//   //       if (trackinglist[i + 1].parentId > trackinglist[i].parentId ) {

//   //           points.add(
//   //               LatLng(trackinglist[i].latitude, trackinglist[i].longitude));
//   //           points.add(LatLng(
//   //               trackinglist[i + 1].latitude, trackinglist[i + 1].longitude));

//   //       }
//   //     }
//   //   }
//   // }

//   // setState(() {
//   //   _polylineCoordinates = points;
//   //   _polylineCoordinates2 = points2;
//   //   _polylines = trackinglist
//   //       .map((e) {
//   //         if (e.splitId < splitpoin) {
//   //           return Polyline(
//   //             polylineId: PolylineId("1"),
//   //             color: Colors.red,
//   //             points: _polylineCoordinates,
//   //             width: 3,
//   //           );
//   //         }
//   //         else if(e.splitId==splitpoin){
//   //            return Polyline(
//   //             polylineId: PolylineId("3"),
//   //             color: Colors.blue,
//   //             points: _polylineCoordinates2,
//   //             width: 3,
//   //           );
//   //         }
//   //         else {
//   //           return Polyline(
//   //             polylineId: PolylineId("2"),
//   //             color: Colors.blue,
//   //             points: _polylineCoordinates2,
//   //             width: 3,
//   //           );
//   //         }
//   //       })
//   //       .toList()
//   //       .toSet();
//   //   print("Poly lines  :: $_polylines");
//   // });

//   if (markers.length > 1) {
//     for (int i = 0; i < markers.length - 1; i++) {
//       points.add(markers[i].position);
//       points.add(markers[i + 1].position);
//     }
//   }

//   setState(() {
//     _polylineCoordinates=points;
//     _polylines = {
//       Polyline(
//         polylineId: PolylineId("$id"),
//         color: Colors.red,
//         points: _polylineCoordinates,
//         width: 3,
//       ),
//     };
//   });
// }

// for (int i = 0; i < trackinglist.length - 1; i++) {
//   if (trackinglist[i].isLast == false) {
//     points.add(LatLng(trackinglist[i].latitude, trackinglist[i].longitude));
//     points.add(LatLng(
//         trackinglist[i + 1].latitude, trackinglist[i + 1].longitude));
//   }
//   if (trackinglist[i].isLast == true) {
//     points.add(LatLng(trackinglist[spiltId - 1].latitude,
//         trackinglist[spiltId - 1].longitude));
//     points.add(LatLng(
//         trackinglist[i + 1].latitude, trackinglist[i + 1].longitude));

//   }
// }

//    void _updatePolylines() {
//   allMarkers.addAll(markers1);
//   allMarkers.addAll(markers2);
//   if (markers1.length < 2) {
//     return;
//   }
//   List<LatLng> points = [];
//   List<LatLng> points1 = [];
//   List<LatLng> points2 = [];

//   int li = 0;
//   for (int i = 0; i < trackinglist.length - 1; i++) {
//     if (trackinglist[i].isLast == false) {
//       points.add(LatLng(trackinglist[i].latitude, trackinglist[i].longitude));
//       points.add(LatLng(
//           trackinglist[i + 1].latitude, trackinglist[i + 1].longitude));
//     } else if (trackinglist[i].isLast == true) {
//       li = i;
//       break;
//     }
//   }
//   if (li > 1) {
//     for (int i = li; i < trackinglist.length - 1; i++) {
//       if (trackinglist[i].isLast == false) {
//         points1
//             .add(LatLng(trackinglist[i].latitude, trackinglist[i].longitude));
//         points1.add(LatLng(
//             trackinglist[i + 1].latitude, trackinglist[i + 1].longitude));
//       } else if (trackinglist[i].isLast == true) {
//         points2.add(LatLng(trackinglist[spiltId - 1].latitude,
//             trackinglist[spiltId - 1].longitude));
//         points2.add(LatLng(
//             trackinglist[i + 1].latitude, trackinglist[i + 1].longitude));
//       }
//     }

//   }
//    setState(() {
//       _polylineCoordinates = points1;
//       _polylines.add(
//         Polyline(
//           polylineId: PolylineId("route${id +100}"),
//           color: Colors.red,
//           points: _polylineCoordinates,
//           width: 3,
//         ),
//       );
//     });
//   setState(() {
//     _polylineCoordinates = points;
//     _polylines.add(
//       Polyline(
//         polylineId: PolylineId("route$id"),
//         color: Colors.black,
//         points: _polylineCoordinates,
//         width: 3,
//       ),
//     );
//   });
//     setState(() {
//       _polylineCoordinates = points2;
//       _polylines.add(
//         Polyline(
//           polylineId: PolylineId("route${id - 1}"),
//           color: Colors.blue,
//           points: _polylineCoordinates,
//           width: 3,
//         ),
//       );
//     });
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

// class VideoSelectorScreen extends StatefulWidget {
//   @override
//   _VideoSelectorScreenState createState() => _VideoSelectorScreenState();
// }

// class _VideoSelectorScreenState extends State<VideoSelectorScreen> {
//   VideoPlayerController? _videoController;

//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Selector'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _videoController != null && _videoController!.value.isInitialized
//                 ? Container(
//                     width: 300.0,
//                     height: 200.0,
//                     child: VideoPlayer(_videoController!),
//                   )
//                 : Container(),
//             ElevatedButton(
//               onPressed: () async {
//                 final XFile? video =
//                     await ImagePicker().pickVideo(source: ImageSource.gallery);
//                 if (video != null) {
//                   _videoController = VideoPlayerController.file(
//                     File(video.path),
//                   )..initialize().then((_) {
//                       setState(() {});
//                       _videoController!.play();
//                     });
//                 }
//               },
//               child: Text('Select Video'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

// class VideoSelectorScreen extends StatefulWidget {
//   @override
//   _VideoSelectorScreenState createState() => _VideoSelectorScreenState();
// }

// class _VideoSelectorScreenState extends State<VideoSelectorScreen> {
//   final ImagePicker _picker = ImagePicker();
//   List<VideoPlayerController?> _videoControllers = [];
//   List<Widget> _videoContainers = [];
//   VideoPlayerController? controller;

//   @override
//   void dispose() {
//     _videoControllers.forEach((controller) => controller?.dispose());
//     super.dispose();
//   }

//   void _addVideoToScreen(XFile? video) {
//     if (video != null) {
//        controller =
//           VideoPlayerController.file(File(video.path))
//             ..initialize().then((_) {
//               setState(() {
//                 _videoControllers.add(controller);
//                 _videoContainers.add(
//                   Container(
//                     width: 300.0,
//                     height: 200.0,
//                     child: VideoPlayer(controller!),
//                   ),
//                 );
//               });
//               controller!.play();
//             });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Selector'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             for (int i = 0; i < _videoContainers.length; i++)
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.0),
//                 child: _videoContainers[i],
//               ),
//             ElevatedButton(
//               onPressed: () async {
//                 final XFile? video =
//                     await _picker.pickVideo(source: ImageSource.gallery);
//                 _addVideoToScreen(video);
//               },
//               child: Text('Select Video'),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     final XFile? video =
//                         await _picker.pickVideo(source: ImageSource.gallery);
//                     _addVideoToScreen(video);
//                   },
//                   child: Text('Add Video 1'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final XFile? video =
//                         await _picker.pickVideo(source: ImageSource.gallery);
//                     _addVideoToScreen(video);
//                   },
//                   child: Text('Add Video 2'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final XFile? video =
//                         await _picker.pickVideo(source: ImageSource.gallery);
//                     _addVideoToScreen(video);
//                   },
//                   child: Text('Add Video 3'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final XFile? video =
//                         await _picker.pickVideo(source: ImageSource.gallery);
//                     _addVideoToScreen(video);
//                   },
//                   child: Text('Add Video 4'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

// class VideoSelectorScreen extends StatefulWidget {
//   @override
//   _VideoSelectorScreenState createState() => _VideoSelectorScreenState();
// }

// class _VideoSelectorScreenState extends State<VideoSelectorScreen> {
//   List<VideoPlayerController?> _videoControllers = [];
//   List<XFile?> _videoList = [];

//   @override
//   void dispose() {
//     _videoControllers.forEach((controller) => controller?.dispose());
//     super.dispose();
//   }

//   void _addVideoToList(XFile? video) {
//     if (video != null) {
//       setState(() {
//         _videoList.add(video);
//         _videoControllers.add(VideoPlayerController.file(File(video.path))
//           ..initialize().then((_) {
//             setState(() {});
//             _videoControllers.last!.play();
//           }));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Selector'),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               for (int i = 0; i < _videoControllers.length; i++)
//                 _videoControllers[i] != null &&
//                         _videoControllers[i]!.value.isInitialized
//                     ? Container(
//                         width: 300.0,
//                         height: 200.0,
//                         child: Chewie(
//                           controller: ChewieController(
//                             videoPlayerController: _videoControllers[i]!,
//                             aspectRatio:
//                                 _videoControllers[i]!.value.aspectRatio,
//                             autoPlay: true,
//                             looping: false,
//                             showControlsOnInitialize: true,
//                           ),
//                         ),
//                       )
//                     : Container(),
//               ElevatedButton(
//                 onPressed: () async {
//                   final XFile? video = await ImagePicker()
//                       .pickVideo(source: ImageSource.gallery);
//                   _addVideoToList(video);
//                 },
//                 child: Text('Select Video'),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () async {
//                       final XFile? video = await ImagePicker()
//                           .pickVideo(source: ImageSource.gallery);
//                       _addVideoToList(video);
//                     },
//                     child: Text('Add Video 1'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final XFile? video = await ImagePicker()
//                           .pickVideo(source: ImageSource.gallery);
//                       _addVideoToList(video);
//                     },
//                     child: Text('Add Video 2'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final XFile? video = await ImagePicker()
//                           .pickVideo(source: ImageSource.gallery);
//                       _addVideoToList(video);
//                     },
//                     child: Text('Add Video 3'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final XFile? video = await ImagePicker()
//                           .pickVideo(source: ImageSource.gallery);
//                       _addVideoToList(video);
//                     },
//                     child: Text('Add Video 4'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// // }
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   File? _image;

//   final ImagePicker _picker = ImagePicker();

//   Future<void> _getImage(BuildContext context, ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });

//     Navigator.pop(context); // Close the bottom sheet
//   }

//   void _showOptions(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Wrap(
//               children: [
//                 ListTile(
//                   leading: Icon(Icons.photo_library_outlined),
//                   title: Text('Gallery'),
//                   onTap: () => _getImage(context, ImageSource.gallery),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.camera_alt_outlined),
//                   title: Text('Camera'),
//                   onTap: () => _getImage(context, ImageSource.camera),
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gallery and Camera'),
//       ),
//       body: Center(
//         child: _image == null
//             ? Text('No image selected.')
//             : Image.file(_image!),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showOptions(context),
//         tooltip: 'Select Image',
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }
// // }
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class Mappp extends StatefulWidget {
//   const Mappp({super.key});

//   @override
//   State<Mappp> createState() => _MapppState();
// }

// class _MapppState extends State<Mappp> {
//   GoogleMapController? mapController;
//   late LatLng selectedLocation;
//   static const LatLng currentLocation = LatLng(33.641855, 73.077002);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: 500.0, width: 300.0,
//               decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//               child: GoogleMap(
//                   gestureRecognizers: Set()
//                     ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()
//                       ..onStart = (_) {})), // Disable map panning
//                   initialCameraPosition: CameraPosition(
//                     target: currentLocation, // Center the map at (0, 0) initially
//                     zoom: 15,
//                   ),
//                   onMapCreated: (GoogleMapController controller) {
//                     mapController = controller;
//                   },
//                 ),

//             ),
//             Container(
//               height: 500.0,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('ListView Color Toggle'),
//         ),
//         body: ColorToggleListView(),
//       ),
//     );
//   }
// }

// class ColorToggleListView extends StatefulWidget {
//   @override
//   _ColorToggleListViewState createState() => _ColorToggleListViewState();
// }

// class _ColorToggleListViewState extends State<ColorToggleListView> {
//   final Set<int> _toggledIndices = {};

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 20, // Assuming you want 20 items in the list
//       itemBuilder: (BuildContext context, int index) {
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               if (_toggledIndices.contains(index)) {
//                 _toggledIndices.remove(index);
//               } else {
//                 _toggledIndices.add(index);
//               }
//             });
//           },
//           child: Container(
//             height: 100,
//             color: _toggledIndices.contains(index) ? Colors.red : Colors.blue,
//             margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//             child: Center(
//               child: Text(
//                 'Item $index',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CounterScreen(),
//     );
//   }
// }

// class CounterScreen extends StatefulWidget {
//   @override
//   _CounterScreenState createState() => _CounterScreenState();
// }

// class _CounterScreenState extends State<CounterScreen> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Counter Screen'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _incrementCounter,
//           child: Text(
//             'Increment',
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         //       alignment: Alignment.center,
//         children: [
//           Container(
//             child: Center(
//                 child: Text(
//               "Track",
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             )),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: Colors.black,
//             ),
//             width: 90.0,
//             height: 40.0,
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:io';

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//     XFile? video;
//       VideoPlayerController? _videoController;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DDDD()
//     );
//   }
// }
// class DDDD extends StatefulWidget {
//   const DDDD({super.key});

//   @override
//   State<DDDD> createState() => _DDDDState();
// }

// class _DDDDState extends State<DDDD> {
//    XFile? video;
//       VideoPlayerController? _videoController;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Modal Bottom Sheet Example'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//             showDialog(
//                               barrierDismissible: false,
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   icon: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Add Video",
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(width: 100.0),
//                                       GestureDetector(
//                                         child: Icon(
//                                           Icons.cancel,
//                                           color: Colors.black,
//                                         ),
//                                         onTap: () {
//                                           Navigator.of(context).pop();
//                                               _videoController = null;
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   backgroundColor: Colors.white,
//                                   title:Text("data"),
//                                   content: StatefulBuilder(
//                                       builder: (context, setstate) {
//                                     return Container(
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Colors.black)),
//                                         width: 300.0,
//                                         height: 150.0,
//                                         child: GestureDetector(
//                                           onTap: () async {

//                                             try {
//                                               video = await ImagePicker()
//                                                   .pickVideo(
//                                                       source:
//                                                           ImageSource.gallery);
//                                               if (video != null) {
//                                                 if (_videoController != null) {
//                                                   await _videoController!
//                                                       .dispose();
//                                                 }
//                                                 _videoController =
//                                                     VideoPlayerController.file(
//                                                   File(video!.path),
//                                                 )..initialize().then((_) {
//                                                         //         setstate(() {});
//                                                         _videoController!
//                                                             .play();
//                                                       });

//                                                 setstate(() {});
//                                               }
//                                             } catch (e) {
//                                               print('Caught an exception: $e');
//                                             }
//                                           },
//                                           child: _videoController == null
//                                                   ? Icon(
//                                                       Icons.video_call_rounded,
//                                                       size: 50.0,
//                                                     )
//                                                   :
//                                                   // AspectRatio(
//                                                   //         aspectRatio:
//                                                   //             _videoController!
//                                                   //                 .value
//                                                   //                 .aspectRatio,
//                                                   //         child: VideoPlayer(
//                                                   //             _videoController!),
//                                                   //       )
//                                                   Chewie(
//                                                       controller:
//                                                           ChewieController(
//                                                         videoPlayerController:
//                                                             _videoController!,
//                                                         aspectRatio:
//                                                             _videoController!
//                                                                 .value
//                                                                 .aspectRatio,
//                                                         autoPlay: true,
//                                                         looping: false,
//                                                         showControlsOnInitialize:
//                                                             true,
//                                                       ),
//                                                     ),
//                                         ));
//                                   }),
//                                   actions: <Widget>[
//                                     Icon(Icons.groups_outlined),
//                                     Text(
//                                       "Strength : 0",
//                                       style: TextStyle(fontSize: 13),
//                                     ),
//                                     SizedBox(
//                                       width: 15.0,
//                                     ),
//                                     ElevatedButton(
//                                         style: ButtonStyle(
//                                             backgroundColor:
//                                                 MaterialStateProperty
//                                                     .all<Color>(Color.fromARGB(
//                                                         255, 0, 0, 0))),
//                                         onPressed: ()async {

//                                         },
//                                         child: Text(
//                                           "Save",
//                                           style: TextStyle(color: Colors.white),
//                                         ))
//                                   ],
//                                 );
//                               });
//             },
//             child: Text('Show Modal Bottom Sheet'),
//           ),
//         ),
//       );
//   }
// }

// import 'dart:io';

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: DDDD());
//   }
// }

// class DDDD extends StatefulWidget {
//   const DDDD({super.key});

//   @override
//   State<DDDD> createState() => _DDDDState();
// }

// class _DDDDState extends State<DDDD> {
// TextEditingController text=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Modal Bottom Sheet Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showDialog(
//                 barrierDismissible: false,
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     icon: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           "MY BOX",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 100.0),
//                         GestureDetector(
//                           child: Icon(
//                             Icons.cancel,
//                             color: Colors.black,
//                           ),
//                           onTap: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ],
//                     ),
//                     backgroundColor: Colors.white,
//                     title: TextFormField(controller: text,),
//                     content: StatefulBuilder(builder: (context, setstate) {
//                       return Container(height: 250.0,
//                         child: Column(children: [

//                         Icon(Icons.groups_outlined),
//                         Text(
//                           "Strength : ${text.text}",
//                           style: TextStyle(fontSize: 13),
//                         ),
//                         SizedBox(
//                           height: 100.0,
//                         ),
//                         ElevatedButton(
//                             style: ButtonStyle(
//                                 backgroundColor: MaterialStateProperty.all<Color>(
//                                     Color.fromARGB(255, 0, 0, 0))),
//                             onPressed: () async {
//                               // setstate(() {

//                               // });
//                             },
//                             child: Text(
//                               "Save",
//                               style: TextStyle(color: Colors.white),
//                             ))
//                         ],),
//                       );
//                     }),
//                   );
//                 });
//           },
//           child: Text('Show Modal Bottom Sheet'),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';
// import 'package:intl/intl.dart';
// import 'package:mob_monitoring/Api/ApiHandler.dart';
// import 'package:video_player/video_player.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Picker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<XFile?> videoFiles =  List<XFile?>.generate(10, (index) => null);
//   List<VideoPlayerController?> _controllers = List<VideoPlayerController?>.generate(10, (index) => null);
//   int a=0;

//   Future<void> _pickVideo(int index, StateSetter setState) async {
//     XFile? pickedFile =
//         await ImagePicker().pickVideo(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       if (_controllers[index] != null) {
//         _controllers[index]!.dispose();
//       }

//       _controllers[index] = VideoPlayerController.file(File(pickedFile.path))
//         ..initialize().then((_) {
//           setState(() {
//             videoFiles[index] = XFile(pickedFile.path);
//           });
//         });
//     }
//   }

//   void _showVideoDialog(int index) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               content: videoFiles[index] == null
//                   ? GestureDetector(
//                       onTap: () => _pickVideo(index, setState),
//                       child: Container(
//                         width: 300,
//                         height: 300,
//                         color: Colors.grey[300],
//                         child: Icon(
//                           Icons.video_library,
//                           size: 100,
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                     )
//                   : Column(
//                       children: [
//                         GestureDetector(
//                           child: Icon(Icons.close),
//                           onTap: () async {
//                             _controllers[index]!.pause();
//                              a=await APIHandler().saveImage(
//                                 DateFormat('yyyy-MM-dd HH:mm:ss')
//                                     .format(DateTime.now()),
//                                 18,
//                                 15,
//                                 157,
//                                 videoFiles[index]!);
//                                 setState(() {});
//                           },
//                         ),
//                         Text("Strength $a"),
//                         Container(
//                           width: 300,
//                           height: 300,
//                           child: Chewie(
//                             controller: ChewieController(
//                               videoPlayerController: _controllers[index]!,
//                               aspectRatio: 16 / 9,
//                               autoPlay: true,
//                               looping: false,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller?.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Picker Example'),
//       ),
//       body: GridView.builder(
//         padding: EdgeInsets.all(16),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//         ),
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return ElevatedButton(
//             onPressed: () => _showVideoDialog(index),
//             child: Text('Button ${index + 1}'),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    try {
      _controller = VideoPlayerController.network(widget.videoUrl)
       ..initialize().then((_) {
          setState(() {});
          _controller.play();
        });
    } catch (e) {
      print('Error playing video: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
           ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Video Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoPlayerScreen(videoUrl: 'http://192.168.0.108:5000/videos/0dfbac2a-1cfb-4d5a-b17b-eb4454a531fc.mp4'),
    );
  }
}