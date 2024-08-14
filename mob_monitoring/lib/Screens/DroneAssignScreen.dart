import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/CustomWidget.dart';
import 'package:mob_monitoring/Model/Drone.dart';
import 'package:mob_monitoring/Model/Mob.dart';
import 'package:mob_monitoring/Screens/MobsScreen.dart';

class DroneAssignScreen extends StatefulWidget {
  final Mob mob;
  final double lt;
  final double lg;
  final int sid;

  const DroneAssignScreen(
      {required this.mob,
      required this.lt,
      required this.lg,
      required this.sid});

  @override
  State<DroneAssignScreen> createState() => _DroneAssignScreenState();
}

class _DroneAssignScreenState extends State<DroneAssignScreen> {
  List<Drone> dlist = [];
  String selectedDrone = "---Select---";
  GoogleMapController? mapController;
  Set<String> avd = {'---Select---'};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLocation =
        LatLng(widget.mob.location.latitude, widget.mob.location.longitude);
    LatLng stnlocation = LatLng(widget.lt, widget.lg);

    final Polyline poly = Polyline(
        polylineId: PolylineId("p1"),
        points: [currentLocation, stnlocation],
        width: 3,
        color: Colors.red);

 //   Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Assign Drone",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
     //   physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    height: 530.0,
                    width: 500.0,
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
                        polylines: {poly},
                        markers: {
                          Marker(
                            markerId: MarkerId("Cl"),
                            icon: BitmapDescriptor.defaultMarker,
                            position: currentLocation,
                            infoWindow: InfoWindow(
                              title: 'Mob',
                            ),
                          ),
                          Marker(
                            markerId: MarkerId("sl"),
                            icon: BitmapDescriptor.defaultMarker,
                            position: stnlocation,
                            infoWindow: InfoWindow(
                              title: 'Station',
                            ),
                          ),
                        },
                        circles: {
                          Circle(
                              circleId: CircleId("1"),
                              center: currentLocation,
                              radius: 350,
                              strokeWidth: 1,
                              fillColor:
                                  Color.fromARGB(255, 240, 70, 70).withOpacity(0.2))
                        },
                      ),
                    ),
                  ),SizedBox(height: 5.0,),
                  Container(                //    decoration: BoxDecoration(border: Border.all(color: Colors.black)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [                             
                                    Text(
                                      "Select Drone",
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color.fromARGB(255, 235, 238, 239),
                                      ),
                                      height: 40,
                                      width: 310.0,
                                      child: FutureBuilder(
                                          future: APIHandler()
                                              .availableDronesInStation(widget.sid),
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
                                                avd.add(element.model);
                                              });
                        
                                              if (dlist.length == 0) {
                                                return Center(
                                                  child: Text('No Drones added'),
                                                );
                                              }
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Expanded(
                                                  child: DropdownButton(
                                                      icon: Icon(Icons
                                                          .arrow_drop_down_sharp),
                                                      iconSize: 30,
                                                      isExpanded: true,
                                                      underline: Container(),
                                                      dropdownColor: Color.fromARGB(
                                                          255, 235, 238, 239),
                                                      iconDisabledColor: Colors.black,
                                                      iconEnabledColor: Colors.black,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                      value: selectedDrone,
                                                      items: avd
                                                          .map((e) =>
                                                              DropdownMenuItem(
                                                                  value: e,
                                                                  child: Text(e)))
                                                          .toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedDrone = value!;
                                                        });
                                                      }),
                                                ),
                                              );
                                            }
                                          })),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyButton3(
                                      text: "Cancel",
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      textColor: Colors.black,
                                      bgColor: Color.fromARGB(255, 219, 221, 222)),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  MyButton3(
                                      text: "Assign",
                                      onTap: () async {
                                        if(selectedDrone=="---Select---"){
                                           showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Row(
                          children: [
                            Text(
                              'Please select any drone ',
                              style: TextStyle(fontSize: 14),
                            ),
                            Icon(
                              Icons.warning,
                              color: Colors.red,
                            )
                          ],
                        ),
                      );
                    });
                                        }else{
                                        Drone id = dlist
                                            .where(
                                              (d) => d.model == selectedDrone,
                                            )
                                            .first;
                                        // print(DateFormat('yyyy-MM-dd HH:mm:ss')
                                        //     .format(DateTime.now()));
                        
                                        // showDialog(
                                        //     context: context,
                                        //     builder: (context) {
                                        //       return AlertDialog(
                                        //         title: Text(
                                        //             "${DateTime.now()}\n ${widget.mob.location.id} \n ${id.drone_id} \n ${widget.mob.id}"),
                                        //       );
                                        //     });
                        
                                        int response = await APIHandler()
                                            .AssignDroneToMob(
                                                DateFormat('yyyy-MM-dd HH:mm:ss')
                                                    .format(DateTime.now()),
                                                widget.mob.location.id,
                                                id.drone_id,
                                                widget.mob.id);
                                        if (response == 200) {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(builder: (context) {
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
                              'Drone Assigned ',
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
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Error ${response}'),
                                                );
                                              });
                                        }}
                                      },
                                      textColor: Colors.white,
                                      bgColor: Colors.black)
                                ],
                              ),
                            ],
                          ),
                    ),
                      
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
