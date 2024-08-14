import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/CustomWidget.dart';
import 'package:mob_monitoring/Model/CPoint.dart';
import 'package:mob_monitoring/Screens/Home.dart';
import 'package:mob_monitoring/Screens/MapScreen.dart';

class AddMobScreen extends StatefulWidget {
  const AddMobScreen({super.key});

  @override
  State<AddMobScreen> createState() => _AddMobScreenState();
}

class _AddMobScreenState extends State<AddMobScreen> {
  List<String> tlist = [
    "Select Type",
    "Protest",
    "Ashura",
    "Political",
    "Festival"
  ];
  int ind=0;

   List<CPoints> dlist = [];
  String selectedStation = "Select";
  Set<String> avd = {'Select'};
  String selectedType = "Select Type";

    List<String> plist = [
    "Select Party",
    "PPP",
    "PMLN",
    "PTI",
    "JUI"
  ];
  String selectedParty = "Select Party";
  TextEditingController typec = TextEditingController();
  TextEditingController starting_time = TextEditingController();
  TextEditingController locationc = TextEditingController();
  TextEditingController strenght = TextEditingController();
  double? longitude, latitude;
  bool isActive = false;
  DateTime dateTime = DateTime(2024, 5, 24);
  String ftime = "12:00 PM";
  bool pp=false;
  bool cs=false;
  String csVal="No";
  // bool csYes=false;
  // bool csYes=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // child:Icon(
            //     Icons.arrow_back,
            //     color: Colors.white,
            //   ) ,
          ),
          Positioned(
            child: InkWell(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () {
                //  showDialog(
                //         context: context,
                //         builder: (context) {
                //           return AlertDialog(
                //             backgroundColor: Colors.white,
                //             title: Row(
                //               children: [
                //                 Text(
                //                   'Account Not Found ',
                //                   style: TextStyle(fontSize: 14),
                //                 ),
                //                 Icon(
                //                   Icons.warning,
                //                   color: Colors.red,
                //                 )
                //               ],
                //             ),
                //           );
                //         });
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              },
            ),
            top: 50,
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
                            "Add Mob",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 55.0,
                            width: 300.0,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 235, 238, 239),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                  padding: EdgeInsets.only(left: 15.0),
                                  isExpanded: true,
                                  underline: Container(),
                                  dropdownColor:
                                      Color.fromARGB(255, 235, 238, 239),
                                  iconDisabledColor: Colors.black,
                                  iconEnabledColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  value: selectedType,
                                  items: tlist
                                      .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e,
                                            style: TextStyle(fontSize: 16),
                                          )))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedType = value!;
                                      selectedType=="Political"?pp=true:pp=false;
                                    });
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                      selectedType=="Political"? Container(
                            height: 55.0,
                            width: 300.0,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 235, 238, 239),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                  padding: EdgeInsets.only(left: 15.0),
                                  isExpanded: true,
                                  underline: Container(),
                                  dropdownColor:
                                      Color.fromARGB(255, 235, 238, 239),
                                  iconDisabledColor: Colors.black,
                                  iconEnabledColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  value: selectedParty,
                                  items: plist
                                      .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e,
                                            style: TextStyle(fontSize: 16),
                                          )))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedParty = value!;
                                    });
                                  }),
                            ),
                          ):SizedBox(),
                             SizedBox(
                            height: 10,
                          ),
                          MyTextFormWithIC(
                              controller: locationc,
                              hintText: "Starting Location",
                              labelText: "Starting Location",
                              //     img: "assets/images/licon.png",
                              icon: Icon(Icons.location_on),
                              readonly: true,
                              onTap: () async {
                                Map<dynamic, dynamic> result =
                                    await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapScreen()),
                                );

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
                          MyTextFormWithIC(
                              controller: starting_time,
                              hintText: "Date Time",
                              labelText: "Date Time",
                              //     img: "assets/images/dtime.png",
                              icon: Icon(Icons.calendar_month_outlined),
                              readonly: true,
                              onTap: () async {
                                final date = await pickdate();
                                final time = await picktime();
                                if (time == null) return;
                                if (date == null) return;
                                ftime = _formatTime(time);
                                setState(() {
                                  dateTime = date;
                                  starting_time.text =
                                      '${dateTime.year}/${dateTime.month}/${dateTime.day} $ftime';
                                });
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextForm(
                              keyboardType: TextInputType.number,
                              controller: strenght,
                              hintText: "Strength",
                              labelText: "Strength"),
                          SizedBox(
                            height: 10,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       'Active',
                          //       style: TextStyle(
                          //           fontSize: 16, color: Colors.black),
                          //     ),
                          //     Checkbox(
                          //         value: isActive,
                          //         activeColor: Colors.black,
                          //         onChanged: (val) {
                          //           setState(() {
                          //             isActive = val!;
                          //           });
                          //         })
                          //   ],
                          // ),
                //      Row(children: [SizedBox(width: 20,),Text("Critical"),
                //             Radio(
                //   value: "Yes",
                //   groupValue: cs,
                //   onChanged: (value) {
                //     setState(() {
                //       csVal = value.toString();
                //     });
                //   },
                //   activeColor: Colors.blue,
                // ),
                // Text(
                //   'Yes',
                //   style: TextStyle(color: Colors.black, fontSize: 11),
                // ),
                // Radio(
                //   value: "No",
                //   groupValue: cs,
                //   onChanged: (value) {
                //     setState(() {
                //       csVal = value.toString();
                //     });
                //   },
                //   activeColor: Colors.blue,
                // ),
                // SizedBox(width: 0.0),
                // Text(
                //   'No',
                //   style: TextStyle(color: Colors.black, fontSize: 11),
                // ),
                //      ],),

                                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 235, 238, 239),
                            ),
                            height: 50,
                            width: 300.0,
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
                                                          fontSize: 12),
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
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            child: Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.black),
                                child: Center(
                                    child: Text("Add",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)))),
                            onTap: () async {
                              if (strenght.text == "" ||
                                  locationc.text == "" ||
                                  starting_time.text == "" ||
                                  selectedType == "Select Type") {
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
                                int statuscode = await APIHandler().AddMob(
                                    selectedType,
                                    starting_time.text,
                                    locationc.text,
                                    longitude!,
                                    latitude!,
                                    strenght.text,
                                    "InActive",
                                    userInfo[0]['user']['id'],pp==true?selectedParty:"",csVal,dlist[1].id);
                                print(statuscode);
                                print(
                                  typec.text,
                                );
                                print(
                                  starting_time.text,
                                );
                                print(
                                  locationc.text,
                                );
                                print(
                                  longitude!,
                                );
                                print(
                                  latitude!,
                                );
                                print(
                                  strenght.text,
                                );
                                print(isActive);

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
                                                'Mob Add Successfully ',
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
                                }
                              }
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
}
