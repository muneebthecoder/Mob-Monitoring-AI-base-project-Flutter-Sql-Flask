import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mob_monitoring/Model/Mob.dart';

class ViewMobScreen extends StatefulWidget {
  final Mob mob;
  const ViewMobScreen({required this.mob});

  @override
  State<ViewMobScreen> createState() => _ViewMobScreenState();
}

class _ViewMobScreenState extends State<ViewMobScreen> {
  GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {
    LatLng currentLocation =
        LatLng(widget.mob.location.latitude, widget.mob.location.longitude);

    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.mob.type,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
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
        child: Column(
          children: [
            Column(
              children: [
                Center(
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),

                    height: 460.0,
                    width: 340.0,
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Expanded(
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target:
                              currentLocation, // Center the map at (0, 0) initially
                          zoom: 14,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                        //   onTap: _selectLocation,
                        markers: {
                          Marker(
                            markerId: MarkerId("Cl"),
                            icon: BitmapDescriptor.defaultMarker,
                            position: currentLocation,
                          ),
                        },
                        //      circles: {
                        //   Circle(
                        //       circleId: CircleId("1"),
                        //       center: currentLocation,
                        //       radius: 350,
                        //       strokeWidth: 1,
                        //       fillColor:
                        //           Color.fromARGB(255, 240, 70, 70).withOpacity(0.2))
                        // },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  width: 340.0,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Type: ",style: TextStyle(fontWeight: FontWeight.w600),),
                            Text("${widget.mob.type}",style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Starting Time: ",style: TextStyle(fontWeight: FontWeight.w600)),
                            Text("${widget.mob.starting_time}",style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Estimated Strenght: ",style: TextStyle(fontWeight: FontWeight.w600)),
                            Text("${widget.mob.strength}",style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Status: ",style: TextStyle(fontWeight: FontWeight.w600)),
                            Text("${widget.mob.status}",style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        SingleChildScrollView(scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text("Location: ",style: TextStyle(fontWeight: FontWeight.w600)),
                              Text("${widget.mob.location.lname}",style: TextStyle(fontWeight: FontWeight.w300)),
                            ],
                          ),
                        ),
                      ],
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
                          child: Text("Back",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)))),
                  onTap: () {
                    Navigator.pop(context);
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
