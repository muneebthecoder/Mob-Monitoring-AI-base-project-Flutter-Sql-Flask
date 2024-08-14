import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/Model/Drone.dart';
import 'package:mob_monitoring/Model/Station.dart';
import 'package:mob_monitoring/Screens/ViewDrone.dart';

class ViewStationScreen extends StatefulWidget {
  final Station s;
  const ViewStationScreen({required this.s});

  @override
  State<ViewStationScreen> createState() => _ViewStationScreenState();
}

class _ViewStationScreenState extends State<ViewStationScreen> {
  GoogleMapController? mapController;
  List<String> categories = ["All", "Available", "Unavailable"];
  int selectedIndex = 0;
  List<Drone> dlist = [];
  List<Drone> all_dlist1 = [];
  List<Drone> all_dlist2 = [];
  // List<Drone> all_dlist = [];

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future<void> loadDetails() async {
    dlist = await APIHandler().availableDronesInStation(widget.s.id);
    for (int i = 0; i < dlist.length; i++) {
      dlist[i].isAvailable == true
          ? all_dlist1.add(dlist[i])
          : all_dlist2.add(dlist[i]);
    }

    setState(() {});
  }
  // if (!snapshot.hasData) {
  //                     return Center(
  //                       child: CircularProgressIndicator(
  //                         color: Colors.black,
  //                       ),
  //                     );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Station"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80.0,
              width: 340.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Color.fromARGB(255, 234, 235, 235),
              ),
              child: Column(
                children: [
                  Text(widget.s.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Text("Drones Capacity: ${widget.s.capacity}"),
                  Text("Total Drones: ${widget.s.available_drones}"),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Container(
                height: 200.0,
                width: 340.0,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Expanded(
                  child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            widget.s.location.latitude,
                            widget.s.location
                                .longitude), // Center the map at (0, 0) initially
                        zoom: 13,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId("Cl"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: LatLng(widget.s.location.latitude,
                              widget.s.location.longitude),
                        ),
                      }),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Station Drones",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 30.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: buildCategory(index),
                    );
                  }),
            ),
            SizedBox(
              height: 10.0,
            ),
            dlist.length == 0
                ? Center(child: Text("No Drones Available"))
                : Container(
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GridView.builder(
                          itemCount: selectedIndex == 0
                              ? dlist.length
                              : selectedIndex == 1
                                  ? all_dlist1.length
                                  : all_dlist2.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 20.0,
                            childAspectRatio: 0.75,
                          ),
                          itemBuilder: (context, index) => ItemCard(
                            drone: selectedIndex == 0
                                ? dlist[index]
                                : selectedIndex == 1
                                    ? all_dlist1[index]
                                    : all_dlist2[index],
                            press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewDroneScreen(
                                  drone: selectedIndex == 0
                                      ? dlist[index]
                                      : selectedIndex == 1
                                          ? all_dlist1[index]
                                          : all_dlist2[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
              categories[index],
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

// ignore: must_be_immutable
class ItemCard extends StatelessWidget {
  ItemCard({super.key, required this.drone, required this.press});

  late Drone drone;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 70.0,
              width: 120.0,
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 222, 221, 221),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black)),
              child: Hero(
                tag: "${drone.drone_id}",
                child: Image.network(APIHandler.imgr_url + drone.img),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0 / 4),
            child: Text(
              // products is out demo list
              drone.type, style: TextStyle(color: Color(0xFFACACAC)),
            ),
          ),
          Text(
            "${drone.model}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
