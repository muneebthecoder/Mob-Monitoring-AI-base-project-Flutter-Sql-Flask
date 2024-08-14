import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/CustomWidget.dart';
import 'package:mob_monitoring/Model/Mob.dart';
import 'package:mob_monitoring/Screens/DroneAssignScreen.dart';
import 'package:mob_monitoring/Screens/Login.dart';
import 'package:mob_monitoring/Screens/MobDetails.dart';
import 'package:mob_monitoring/Screens/MobTracking.dart';
import 'package:mob_monitoring/Screens/MobTrackingNew.dart';
import 'package:mob_monitoring/Screens/MultipleMob.dart';
import 'package:mob_monitoring/Screens/TaskScreenMobDetails.dart';
import 'package:mob_monitoring/Screens/ViewMob.dart';

class MobScreen extends StatefulWidget {
  const MobScreen({super.key});

  @override
  State<MobScreen> createState() => _MobScreenState();
}

class _MobScreenState extends State<MobScreen> {
  final Set<Mob> _toggledIndices = {};
  TextEditingController search = TextEditingController();
  List<String> mtypelist = ["All", "Completed", "Active", "InActive"];
  int selectedIndex = 0;
  List<Mob> mlist = [];

  List<Mob> all_mlist = [];
  List<Mob> all_mlist1 = [];
  List<Mob> all_mlist2 = [];
  List<Mob> all_mlist3 = [];
  @override
  void initState() {
    super.initState();
    loadDetails();
    search.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      all_mlist = mlist
          .where((item) =>
              item.type.toLowerCase().contains(search.text.toLowerCase()))
          .toList();
    });
  }

  Future<void> loadDetails() async {
    mlist = await APIHandler().GetAllMob();
    all_mlist.addAll(mlist);
    all_mlist = all_mlist.reversed.toList();
    all_mlist=all_mlist.where((element) => element.parent_id==0).toList();
    for (int i = 0; i < mlist.length; i++) {
      if (mlist[i].status == "InActive") {
        all_mlist3.add(mlist[i]);
      }
      if (mlist[i].status == "Active") {
        all_mlist2.add(mlist[i]);
      }
      if (mlist[i].status == "Completed") {
        all_mlist1.add(mlist[i]);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _toggledIndices.length >= 1
          ? GestureDetector(
              onTap: () {
                if (_toggledIndices.length == 1) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(icon: Icon(Icons.warning,color: Colors.red,),
                          backgroundColor: Colors.white,
                          title: Text(
                            'Please select atleast two mobs for tracking.',
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      });
                } else {
                   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MobTrackingScreenNew(
                                              mlist: _toggledIndices.toList()),
                                    ),
                                  );

                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         icon: Icon(Icons.emoji_emotions),
                  //         backgroundColor: Colors.white,
                  //         title: Text(
                  //           "Please select any",
                  //           style: TextStyle(fontSize: 14),
                  //         ),
                  //         content: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             InkWell(
                  //               child: Container(
                  //                   height: 40,
                  //                   width: 100,
                  //                   decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.circular(10),
                  //                       color: Colors.green),
                  //                   child: Center(
                  //                       child: Text("By List",
                  //                           style: TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 16,
                  //                               fontWeight: FontWeight.bold)))),
                  //               onTap: () async {
                  //                 Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                     builder: (context) => MobTrackingScreen(
                  //                         mlist: _toggledIndices.toList()),
                  //                   ),
                  //                 );
                  //               },
                  //             ),
                  //             SizedBox(
                  //               width: 20.0,
                  //             ),
                  //             InkWell(
                  //               child: Container(
                  //                   height: 40,
                  //                   width: 100,
                  //                   decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.circular(10),
                  //                       color: Colors.green),
                  //                   child: Center(
                  //                       child: Text("By Points",
                  //                           style: TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 16,
                  //                               fontWeight: FontWeight.bold)))),
                  //               onTap: () async {
                  //                 Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                     builder: (context) =>
                  //                         MobTrackingScreenNew(
                  //                             mlist: _toggledIndices.toList()),
                  //                   ),
                  //                 );
                  //               },
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     });
                }
              },
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.black,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          "${_toggledIndices.length}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 90.0,
                    ),
                    Text(
                      "Track Now",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            )
          : null,
      // floatingActionButton: _toggledIndices.length >= 1
      //     ? Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           Container(
      //             child: Center(
      //                 child: Text(
      //               "Track : ${_toggledIndices.length}",
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
      //       )
      //     : null,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("MOB"),
      ),
      body: Column(
        children: [
          MySearchTextForm(controller: search, hintText: "Search"),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 30.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mtypelist.length,
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
            height: 10,
          ),
          Container(
            child: Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                      itemCount: selectedIndex == 0
                          ? all_mlist.length
                          : selectedIndex == 1
                              ? all_mlist1.length
                              : selectedIndex == 2
                                  ? all_mlist2.length
                                  : all_mlist3.length,
                      itemBuilder: (context, index) {
                        Mob m = selectedIndex == 0
                            ? all_mlist[index]
                            : selectedIndex == 1
                                ? all_mlist1[index]
                                : selectedIndex == 2
                                    ? all_mlist2[index]
                                    : all_mlist3[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_toggledIndices.contains(m)) {
                                _toggledIndices.remove(m);
                              } else {
                                if (m.status == "Active") {
                                  _toggledIndices.add(m);
                                }
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                width: 320.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: _toggledIndices.contains(m)
                                        ? Color.fromARGB(255, 169, 172, 172)
                                        : Color.fromARGB(255, 223, 229, 231),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white
                                            .withOpacity(0.1), // Shadow color
                                        spreadRadius: 1, // Spread radius
                                        blurRadius: 1, // Blur radius
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              m.type,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 180,
                                            ),
                                            Text(m.strength + "+",
                                                style: TextStyle(
                                                    color: (int.parse(
                                                                m.strength) >=
                                                            501
                                                        ? Colors.red
                                                        : Color.fromARGB(
                                                            255, 49, 220, 55)),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 15.0,
                                            ),
                                            Text(
                                              m.location.lname,
                                              style: TextStyle(fontSize: 13.5),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time_outlined,
                                              size: 15.0,
                                            ),
                                            Text(
                                              "Timing: " + m.starting_time,
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 25.0,
                                            ),
                                            m.status == "Completed"
                                                ? MyButton2(
                                                    text: "Details",
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              MobDetailScreen(
                                                            mob: m,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    textColor: Colors.black,
                                                    bgColor: Colors.white)
                                                : MyButton2(
                                                    text: "Details",
                                                    onTap: () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewMobScreen(
                                                              mob: m,
                                                            ),
                                                          ),
                                                        ),
                                                    textColor: Colors.black,
                                                    bgColor: Colors.white),
                                            SizedBox(
                                              width: 50.0,
                                            ),
      //                                       m.status == "Completed"?
      //                                     InkWell(
      // child: Container(
      //     height: 35.0,
      //     width: 10.0,
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10), color: Colors.red),
      //     child: Center(
      //         child: Text("Simulation",
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 17,
      //                   fontWeight: FontWeight.w400
      //             )))),
      // onTap:  () {
      //             Navigator.of(context)
      //                 .push(MaterialPageRoute(builder: (context) {
      //               return TaskScreenDetails();
      //             }));
      //           },
      // )
      //                                               :SizedBox(),
                                            m.status != "Completed"
                                                ? m.status == "InActive"
                                                    ? MyButton2(
                                                        text: "Assign",
                                                        onTap: () async {
                                                          dynamic landl = [];
                                                          Response response =
                                                              await APIHandler()
                                                                  .NearestStation(
                                                                      m.location
                                                                          .latitude,
                                                                      m.location
                                                                          .longitude);
                                                          if (response
                                                                  .statusCode ==
                                                              200) {
                                                            landl = jsonDecode(
                                                                response.body);
                                                          }
                                                          double lt =
                                                              landl["location"]["latitude"];
                                                          double lg = landl["location"][
                                                              "longitude"];
                                                          int sid = landl[
                                                              "id"];
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DroneAssignScreen(
                                                                        mob: m,
                                                                        lg: lg,
                                                                        lt: lt,
                                                                        sid:
                                                                            sid),
                                                              ));
                                                        },
                                                        textColor: Colors.white,
                                                        bgColor: Colors.black)
                                                    : MyButton2(
                                                        text: "Track",
                                                        onTap: () async {
                                                          List<Mob> ml = [];
                                                          ml.add(m);
                                                           Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MobTrackingScreenNew(
                                              mlist: ml),
                                    ),
                                  );
                                                          // showDialog(
                                                          //     context: context,
                                                          //     builder:
                                                          //         (context) {
                                                          //       return AlertDialog(
                                                          //         icon: Icon(Icons
                                                          //             .emoji_emotions),
                                                          //         backgroundColor:
                                                          //             Colors
                                                          //                 .white,
                                                          //         title: Text(
                                                          //           "Please select any",
                                                          //           style: TextStyle(
                                                          //               fontSize:
                                                          //                   14),
                                                          //         ),
                                                          //         content: Row(
                                                          //           mainAxisAlignment:
                                                          //               MainAxisAlignment
                                                          //                   .center,
                                                          //           children: [
                                                          //             InkWell(
                                                          //               child: Container(
                                                          //                   height:
                                                          //                       40,
                                                          //                   width:
                                                          //                       100,
                                                          //                   decoration:
                                                          //                       BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.green),
                                                          //                   child: Center(child: Text("By List", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))),
                                                          //               onTap:
                                                          //                   () async {
                                                          //                 Navigator
                                                          //                     .push(
                                                          //                   context,
                                                          //                   MaterialPageRoute(
                                                          //                     builder: (context) => MobTrackingScreen(mlist: ml),
                                                          //                   ),
                                                          //                 );
                                                          //               },
                                                          //             ),
                                                          //             SizedBox(
                                                          //               width:
                                                          //                   20.0,
                                                          //             ),
                                                          //             InkWell(
                                                          //               child: Container(
                                                          //                   height:
                                                          //                       40,
                                                          //                   width:
                                                          //                       100,
                                                          //                   decoration:
                                                          //                       BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.green),
                                                          //                   child: Center(child: Text("By Points", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))),
                                                          //               onTap:
                                                          //                   () async {
                                                          //                 Navigator
                                                          //                     .push(
                                                          //                   context,
                                                          //                   MaterialPageRoute(
                                                          //                     builder: (context) => MobTrackingScreenNew(mlist: ml),
                                                          //                   ),
                                                          //                 );
                                                          //               },
                                                          //             ),
                                                          //           ],
                                                          //         ),
                                                          //       );
                                                          //     });
                                                        },
                                                        textColor: Colors.white,
                                                        bgColor: Colors.green)
                                                : Container()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      })),
            ),
          )
        ],
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
