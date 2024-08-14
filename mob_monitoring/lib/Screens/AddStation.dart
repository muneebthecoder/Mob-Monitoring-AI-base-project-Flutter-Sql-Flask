import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/CustomWidget.dart';
import 'package:mob_monitoring/Screens/Home.dart';
import 'package:mob_monitoring/Screens/MapScreen.dart';

class AddStationScreen extends StatefulWidget {
  const AddStationScreen({super.key});

  @override
  State<AddStationScreen> createState() => _AddStationScreenState();
}

class _AddStationScreenState extends State<AddStationScreen> {
  TextEditingController namec = TextEditingController();
  TextEditingController locationc = TextEditingController();
  TextEditingController capacityc = TextEditingController();
  double? longitude, latitude;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 //     appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blueGrey,
                  Colors.grey,
                ],
              ),
            ),
          ),
           Positioned(
              child: GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                   onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
          },
                      ),
              top: 20,
              left: 20,
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                   Container(
                        width: 1000,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            //    crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Add Station",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 34,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MyTextForm(
                                  controller: namec,
                                  hintText: "Name",
                                  labelText: "Name"),
                              SizedBox(
                                height: 10,
                              ),
                              MyTextFormWithIC(
                                  controller: locationc,
                                  hintText: "Location",
                                  labelText: "Location",
                              //    img: "assets/images/licon.png",
                                                       icon: Icon(Icons.location_on),
              
                                  // readonly: true,
                                  onTap: () async {
                                    Map<dynamic, dynamic> result =
                                        await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MapScreen()),
                                    );
              
              // Now you can access the values of 'location' and 'text' from the result map
              // ignore: unnecessary_null_comparison
                                    if (result != null) {
                                      LatLng location = result['location'];
                                      String text = result['text'];
                                      // Use the values as needed
                                      print(text);
                                      print(location.latitude);
                                      print(location.longitude);
                                      locationc.text = text;
                                      latitude = location.latitude;
                                      longitude = location.longitude;
                                    }
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              MyTextForm(
                                  keyboardType: TextInputType.number,
                                  controller: capacityc,
                                  hintText: "Total Capacity",
                                  labelText: "Total Capacity"),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                child: Container(
                                    height: 50,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    child: Center(
                                        child: Text("Add",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)))),
                                onTap: () async {
                                     if (namec.text == "" || locationc.text=="" || capacityc.text=="") {
                                 showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Text(
                                      'Please enter all information ',
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
                              } else {
                                  int statuscode = await APIHandler().AddStation(
                                    namec.text,
                                    locationc.text,
                                    longitude!,
                                    latitude!,
                                    int.parse(capacityc.text),
                                  );
                                  print(statuscode);
                                  if (statuscode == 200) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return HomeScreen();
                                    }));
                                       showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Text(
                                      'Station Add Successfully ',
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
                                            title: Text('Error $statuscode'),
                                          );
                                        });
                                  }}
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
