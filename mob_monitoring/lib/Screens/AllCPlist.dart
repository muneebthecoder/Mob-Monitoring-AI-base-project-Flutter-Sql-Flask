import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/Model/CPoint.dart';
import 'package:mob_monitoring/Model/Mob.dart';
import 'package:mob_monitoring/Screens/Home.dart';

class CPlistScreen extends StatefulWidget {
  const CPlistScreen({super.key});

  @override
  State<CPlistScreen> createState() => _CPlistScreenState();
}

class _CPlistScreenState extends State<CPlistScreen> {
  GoogleMapController? mapController;
  late LatLng selectedLocation;
  static const LatLng currentLocation = LatLng(33.641855, 73.077002);

  List<String> mtypelist = ["All", "Active", "InActive"];
  int selectedIndex = 0;

  String selectedLocationText = 'MMM';
  List<Marker> markers = [];
  List<Marker> markers1 = [];
  List<Marker> markers2 = [];
  List<Circle> circle = [];
  List<Circle> circle1 = [];
  List<Circle> circle2 = [];
  List<CPoints> mlist = [];

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future<void> loadDetails() async {
    mlist = await APIHandler().GetAllCpb();
    for (int i = 0; i < mlist.length; i++) {
      markers.add(Marker(
        markerId: MarkerId("${mlist[i].id}"),
        position:
            LatLng(mlist[i].location.latitude, mlist[i].location.longitude),
        draggable: true,
        infoWindow: InfoWindow(
          title: '${mlist[i].location.lname}',
       //   snippet: '${mlist[i].status}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
      circle.add(Circle(
          circleId: CircleId("${mlist[i].id}"),
          center:
              LatLng(mlist[i].location.latitude, mlist[i].location.longitude),
          radius: int.parse(mlist[i].radius).toDouble(),
          strokeWidth: 0,
          fillColor:Color.fromARGB(255, 145, 31, 31).withOpacity(0.3)));

      // if (mlist[i].status == "Active") {
      //   markers1.add(Marker(
      //     markerId: MarkerId("${mlist[i].id}"),
      //     position:
      //         LatLng(mlist[i].location.latitude, mlist[i].location.longitude),
      //     draggable: true,
      //     infoWindow: InfoWindow(
      //       title: '${mlist[i].location.lname}',
      //       snippet: '${mlist[i].status}',
      //     ),
      //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      //   ));
      //   circle1.add(Circle(
      //       circleId: CircleId("${mlist[i].id}"),
      //       center:
      //           LatLng(mlist[i].location.latitude, mlist[i].location.longitude),
      //       radius: 400,
      //       strokeWidth: 0,
      //       fillColor: Color.fromARGB(255, 240, 70, 70).withOpacity(0.3)));
      // }
      // if (mlist[i].status == "InActive") {
      //   markers2.add(Marker(
      //     markerId: MarkerId("${mlist[i].id}"),
      //     position:
      //         LatLng(mlist[i].location.latitude, mlist[i].location.longitude),
      //     draggable: true,
      //     infoWindow: InfoWindow(
      //       title: '${mlist[i].location.lname}',
      //       snippet: '${mlist[i].status}',
      //     ),
      //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      //   ));
      //   circle2.add(Circle(
      //       circleId: CircleId("${mlist[i].id}"),
      //       center:
      //           LatLng(mlist[i].location.latitude, mlist[i].location.longitude),
      //       radius: 400,
      //       strokeWidth: 0,
      //       fillColor: Color.fromARGB(255, 21, 21, 21).withOpacity(0.3)));
      // }
    }
try{    setState(() {});}catch(e){}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        title: Text(
          "All Critical Points",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          SizedBox(
              height: 10.0,
            ),
            // SizedBox(
            //   height: 30.0,
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: mtypelist.length,
            //       itemBuilder: (context, index) {
            //         return GestureDetector(
            //           onTap: () {
            //             setState(() {
            //               selectedIndex = index;
            //             });
            //           },
            //           child: buildCategory(index),
            //         );
            //       }),
            // ),
            Container(
   //           height: 550.0,
                 height: 500.0,

              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: currentLocation, // Center the map at (0, 0) initially
                  zoom: 12,
                ),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                markers: Set<Marker>.of(markers),
                circles:Set<Circle>.of(circle),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              mtypelist[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    selectedIndex == index ? Colors.black : Color(0xFFACACAC),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0 / 8), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
