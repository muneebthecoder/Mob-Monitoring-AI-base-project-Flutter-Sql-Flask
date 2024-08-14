import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/CustomWidget.dart';
import 'package:mob_monitoring/Model/Station.dart';
import 'package:mob_monitoring/Screens/Home.dart';

class AddDroneScreen extends StatefulWidget {
  const AddDroneScreen({super.key});

  @override
  State<AddDroneScreen> createState() => _AddDroneScreenState();
}

class _AddDroneScreenState extends State<AddDroneScreen> {
  TextEditingController battery_timingc = TextEditingController();
  TextEditingController ceiling = TextEditingController();
  TextEditingController storage = TextEditingController();
  TextEditingController range = TextEditingController();
  File? pickimage;
  bool isAvailable = false;

  List<Station> dlist = [];
  String selectedStation = "Select";
  Set<String> avd = {'Select'};

  List<String> tlist = ["Select", "Fixed-wing", "Multi-rotor", "Single-rotor"];
  String selectedType = "Select";
  List<String> mlist = [
    "Select",
    "Dril 35",
    "Dril 21",
    "Dril 41",
    "Dril 99",
    "Dril 50",
    "DJI Mack 30",
    "MJI 20"
  ];
    String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dateTime);
  }
  String selectedModel = "Select";
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
          ),
          Positioned(
            child: GestureDetector(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }))),
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
                      color: Colors.white,
                      //     border: Border.all(color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        //    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add Drone",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            child: Container(
                              child: pickimage == null
                                  ? Icon(
                                      Iconsax.camera,
                                      color: Colors.black,
                                    )
                                  : Image.file(pickimage!),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 235, 238, 239),
                                  // border: Border.all(
                                  //     color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onTap: () async {
                              XFile? img = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (img != null) {
                                pickimage = File(img.path);
                                setState(() {});
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 18.0,
                              ),
                              Text(
                                "Type",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 120.0,
                              ),
                              Text(
                                "Model",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 55.0,
                                width: 130.0,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 235, 238, 239),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
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
                                        });
                                      }),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                height: 55.0,
                                width: 130.0,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 235, 238, 239),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                      isExpanded: true,
                                      underline: Container(),
                                      dropdownColor:
                                          Color.fromARGB(255, 235, 238, 239),
                                      iconDisabledColor: Colors.black,
                                      iconEnabledColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      value: selectedModel,
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
                                          selectedModel = value!;
                                        });
                                      }),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 18.0,
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 235, 238, 239),
                            ),
                            height: 50,
                            width: 300.0,
                            child: FutureBuilder(
                                future: APIHandler().GetAllStation(),
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
                                      avd.add(element.name);
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
                                                          fontSize: 16),
                                                    )))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedStation = value!;
                                              });
                                            }),
                                      ),
                                    );
                                  }
                                })),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextForm(
                              keyboardType: TextInputType.number,
                              controller: battery_timingc,
                              hintText: "Battery Timing in Minutes",
                              labelText: "Battery Timing"),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextForm(
                              keyboardType: TextInputType.number,
                              controller: storage,
                              hintText: "Storage in GB",
                              labelText: "Storage"),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextForm(
                              keyboardType: TextInputType.number,
                              controller: ceiling,
                              hintText: "Ceiling in Meter",
                              labelText: "Ceiling"),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextForm(
                              keyboardType: TextInputType.number,
                              controller: range,
                              hintText: "Range in Meter",
                              labelText: "Range"),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Avaiable',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Checkbox(
                                  value: isAvailable,
                                  activeColor: Colors.black,
                                  onChanged: (val) {
                                    setState(() {
                                      isAvailable = val!;
                                    });
                                  })
                            ],
                          ),
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
                              if (battery_timingc.text == "" ||
                                  storage.text == "" ||
                                  ceiling.text == "" ||
                                  range.text == "" ||
                                  selectedModel == "Select" ||
                                  selectedType == "Select" ||
                                  selectedStation == "Select" ||
                                  pickimage == null) {
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
                                String time="${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
                                int statuscode = await APIHandler().AddDrone(
                                    selectedType,
                                    selectedModel,
                                    int.parse(battery_timingc.text),
                                    int.parse(ceiling.text),
                                    int.parse(storage.text),
                                    int.parse(range.text),
                                    isAvailable == true ? 1 : 0,
                                    dlist
                                        .firstWhere((element) =>
                                            element.name == selectedStation)
                                        .id,
                                    pickimage!,
                                    time);
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
                                      'Drone Add Successfully ',
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
}
