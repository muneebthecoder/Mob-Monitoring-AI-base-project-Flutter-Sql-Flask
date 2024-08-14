import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/CustomWidget.dart';
import 'package:mob_monitoring/Model/Drone.dart';
import 'package:mob_monitoring/Model/Mob.dart';
import 'package:mob_monitoring/Model/Station.dart';
import 'package:mob_monitoring/Screens/AddCriticalSection.dart';
import 'package:mob_monitoring/Screens/AddDrone.dart';
import 'package:mob_monitoring/Screens/AddMob.dart';
import 'package:mob_monitoring/Screens/AddStation.dart';
import 'package:mob_monitoring/Screens/AllCPlist.dart';
import 'package:mob_monitoring/Screens/DronesScreen.dart';
import 'package:mob_monitoring/Screens/Login.dart';
import 'package:mob_monitoring/Screens/MobsScreen.dart';
import 'package:mob_monitoring/Screens/Profile.dart';
import 'package:mob_monitoring/Screens/StationScreen.dart';
import 'package:mob_monitoring/Screens/ViewDrone.dart';
import 'package:mob_monitoring/Screens/ViewMob.dart';
import 'package:mob_monitoring/Screens/ViewStation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Drone> a_dlist = [];
  List<Mob> a_mlist = [];
  List<Mob> c_mlist = [];
  List<Station> slist = [];

  @override
  Widget build(BuildContext context) {
    //  var mq = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ProfileScreen();
            })); 
              },
              icon: Icon(Icons.settings),
            )
          ],
        ),
        floatingActionButton: SpeedDial(
          backgroundColor: Colors.black.withOpacity(0.8),
          icon: Icons.add,
          children: [
            SpeedDialChild(
                child: Icon(Icons.airplanemode_active),
                label: "Add Drone",
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddDroneScreen();
                  }));
                }),
            SpeedDialChild(
                child: Icon(Icons.groups),
                label: "Add Mob",
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddMobScreen();
                  }));
                }),
            SpeedDialChild(
                child: Icon(Icons.warehouse),
                label: "Add Station",
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddStationScreen();
                  }));
                }),
                 SpeedDialChild(
                child: Icon(Icons.add),
                label: "Add Critical Section",
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddCriticalSection();
                  }));
                }),
          ],
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
              margin: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.white24,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child:userInfo[0]['user']['img']==""? Icon(
                          Iconsax.user,
                        ):null,
                        backgroundImage: NetworkImage(APIHandler.Userimgr_url +
                            userInfo[0]['user']['img']),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "   ${userInfo[0]["user"]["name"]}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text("   ${userInfo[0]["user"]["role"]}"),
                        ],
                      ),
                    ],
                  ),
                  ListTile(
                    trailing: Icon(Icons.chevron_right_sharp),
                    title: Row(
                      children: [Icon(Icons.person),SizedBox(width: 10.0,),
                        Text('Profile'),
                      ],
                    ),
                    onTap: () {
                      // Handle home tap
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProfileScreen();
                      }));
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              trailing: Icon(Icons.chevron_right_sharp),
              title: Row(
                children: [Icon(Icons.home),SizedBox(width: 10.0,),
                  Text('Home'),
                ],
              ),
              onTap: () {
                // Handle home tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(Icons.chevron_right_sharp),
              title: Row(
                children: [Icon(Icons.airplanemode_active),SizedBox(width: 10.0,),
                  Text('See Drones'),
                ],
              ),
              onTap: () {
                // Handle home tap
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return DronesScreen();
                }));
              },
            ),
            ListTile(
              trailing: Icon(Icons.chevron_right_sharp),
              title:Row(
                children: [Icon(Icons.groups),SizedBox(width: 10.0,),
                  Text('See Mobs'),
                ],
              ),
              onTap: () {
                // Handle home tap
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return MobScreen();
                }));
              },
            ),
            ListTile(
              trailing: Icon(Icons.chevron_right_sharp),
              title: Row(
                children: [Icon(Icons.warehouse),SizedBox(width: 10.0,),
                  Text('See Stations'),
                ],
              ),
              onTap: () {
                // Handle home tap
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return StationScreen();
                }));
              },
            ),
              ListTile(
              trailing: Icon(Icons.chevron_right_sharp),
              title: Row(
                children: [Icon(Icons.warehouse),SizedBox(width: 10.0,),
                  Text('See Critical Points'),
                ],
              ),
              onTap: () {
                // Handle home tap
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CPlistScreen();
                }));
              },
            ),
            ListTile(
              trailing: Icon(Icons.chevron_right_sharp),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.blue),
              ),
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.blue,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
            ),
          ],
        )),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    CircleAvatar(
                      radius: 30,
                       child:userInfo[0]['user']['img']==""? Icon(
                          Iconsax.user,
                        ):null,
                      backgroundImage: NetworkImage(
                          APIHandler.Userimgr_url + userInfo[0]['user']['img']),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${userInfo[0]["user"]["name"]}",style: TextStyle(fontWeight: FontWeight.w600),),
                             Text(
                            "${userInfo[0]["user"]["email"]}",style: TextStyle(fontSize: 11),),
                      ],
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 200,
                //   child: FutureBuilder(
                //       future: APIHandler().GetAllMob(),
                //       builder: ((context, snapshot) {
                //         if (!snapshot.hasData) {
                //           return Center(
                //             child: CircularProgressIndicator(
                //               color: Colors.black,
                //             ),
                //           );
                //         } else {
                //           a_mlist = snapshot.data!;
                //           if (a_mlist.length == 0) {
                //             return Center(
                //               child: Text('No Mob added'),
                //             );
                //           }
                //           return ListView.builder(
                //             itemCount: a_mlist.length,
                //             scrollDirection: Axis.horizontal,
                //             itemBuilder: (context, index) {
                //               Mob m = a_mlist[index];
                //               return GestureDetector(
                //                 child: Container(
                //                     height: 200,
                //                     width: 250,
                //                     margin: EdgeInsets.all(10.0),
                //                     decoration: BoxDecoration(
                //                       border: Border.all(
                //                           color: Colors.black.withOpacity(0.3)),

                //                       image: DecorationImage(
                //                           image: index % 2 == 0
                //                               ? AssetImage(
                //                                   "assets/images/mob.png")
                //                               : AssetImage(
                //                                   "assets/images/mob1.jpg"),
                //                           fit: BoxFit.cover,
                //                           opacity: 0.8),
                //                       borderRadius: BorderRadius.circular(20.0),
                //                       //    color: Color.fromARGB(255, 192, 218, 231),
                //                       color: Color.fromARGB(255, 234, 235, 235),

                //                       boxShadow: [
                //                         BoxShadow(
                //                           color: Colors.black
                //                               .withOpacity(0.2), // Shadow color
                //                           spreadRadius: 1, // Spread radius
                //                           blurRadius: 1, // Blur radius
                //                           // offset: Offset(
                //                           //     3, 2), // Offset in x and y directions
                //                         ),
                //                       ],
                //                     ),
                //                     child: Padding(
                //                       padding: const EdgeInsets.all(8.0),
                //                       child: Column(
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.center,
                //                             children: [
                //                               Text("Active  "),
                //                               Container(
                //                                   height: 8.0,
                //                                   width: 8.0,
                //                                   decoration: BoxDecoration(
                //                                     color: Colors.red,
                //                                     borderRadius:
                //                                         BorderRadius.circular(
                //                                             100.0),
                //                                   )),
                //                             ],
                //                           ),
                //                           SizedBox(
                //                             height: 30.0,
                //                           ),
                //                           Text(
                //                             m.type,
                //                             style: TextStyle(
                //                                 fontWeight: FontWeight.w500),
                //                           ),
                //                           Text(
                //                             m.location.lname,
                //                             style: TextStyle(fontSize: 12),
                //                           ),
                //                           Text(
                //                             "Strenght: " + m.strength,
                //                             style: TextStyle(fontSize: 12),
                //                           ),
                //                         ],
                //                       ),
                //                     )),
                //                 onTap: () {
                //                   Navigator.of(context).push(MaterialPageRoute(
                //                     builder: (context) => ViewMobScreen(
                //                       mob: a_mlist[index],
                //                     ),
                //                   ));
                //                 },
                //               );
                //             },
                //           );
                //         }
                //       })),
                // ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SeeAllLable(
                        text: "See all",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DronesScreen(),
                          ));
                        })
                  ],
                ),
                SizedBox(
                  height: 100,
                  child: FutureBuilder(
                      future: APIHandler().GetAllDrone(),
                      builder: ((context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        } else {
                          a_dlist = snapshot.data!;
                          if (a_dlist.length == 0) {
                            return Center(
                              child: Text('No Drones added'),
                            );
                          }
                          return ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Drone d = a_dlist[index];
                              return GestureDetector(
                                child: Container(
                                  height: 102,
                                  width: 93,
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              APIHandler.imgr_url + d.img),
                                          fit: BoxFit.scaleDown),
                                      borderRadius: BorderRadius.circular(10.0),
                                      //            color: Color.fromARGB(255, 228, 242, 250),
                                      color: Color.fromARGB(255, 234, 235, 235),
                                      // border: Border.all(
                                      //     color: Colors.black.withOpacity(0.1)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                        ),
                                      ],                      border: Border.all(color: Colors.black.withOpacity(0.3))
),
                                  child: Text(
                                    d.model,
                                    style: TextStyle(fontSize: 13),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ViewDroneScreen(
                                      drone: d,
                                    ),
                                  ));
                                },
                              );
                            },
                          );
                        }
                      })),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  " Upcoming Mob",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SeeAllLable(
                        text: "See all",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MobScreen(),
                          ));
                        })
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  decoration: BoxDecoration(
                            color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.black.withOpacity(0.3)),
                          boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Shadow color
                                          spreadRadius: 1, // Spread radius
                                          blurRadius: 1, // Blur radius
                                          // offset: Offset(
                                          //     3, 2), // Offset in x and y directions
                                        ),
                                      ],),
                  height: 300.0,
                  child: Center(
                    child: SizedBox(
                      height: 300.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FutureBuilder(
                            future: APIHandler().GetAllMob(),
                            builder: ((context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                );
                              } else {
                                c_mlist = snapshot.data!;
                                c_mlist=c_mlist.reversed.toList();
                                if (c_mlist.length == 0) {
                                  return Center(
                                    child: Text('No Mob added'),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: 3,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    Mob m = c_mlist[index];
                                    return GestureDetector(
                                      child: Container(
                                        height: 85.0,
                                        margin: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Color.fromARGB(
                                              255, 234, 235, 235),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    m.type,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    width: 150.0,
                                                  ),
                                                  Text(m.strength + '+',
                                                      style: TextStyle(
                                                          color: (int.parse(m
                                                                      .strength) >=
                                                                  501
                                                              ? Colors.red
                                                              : Color.fromARGB(
                                                                  255,
                                                                  49,
                                                                  220,
                                                                  55)),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              Text(
                                                m.location.lname,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                "Timing: " + m.starting_time,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: const Color.fromARGB(
                                                        255, 6, 137, 245)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => ViewMobScreen(
                                            mob: m,
                                          ),
                                        ));
                                      },
                                    );
                                  },
                                );
                              }
                            })),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  " Stations",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SeeAllLable(
                        text: "See all",
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return StationScreen();
                          }));
                        })
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  decoration: BoxDecoration(
                            color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Shadow color
                                          spreadRadius: 1, // Spread radius
                                          blurRadius: 1, // Blur radius
                                          // offset: Offset(
                                          //     3, 2), // Offset in x and y directions
                                        ),
                                      ],
                      border: Border.all(color: Colors.black.withOpacity(0.3))
                      ),
                  height: 300,
                  child: Center(
                    child: SizedBox(
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
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
                                slist = snapshot.data!;
                                if (slist.length == 0) {
                                  return Center(
                                    child: Text('No Station added'),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: 3,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    Station s = slist[index];
                                    return GestureDetector(
                                      child: Container(
                                        height: 85.0,
                                        margin: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Color.fromARGB(
                                              255, 234, 235, 235),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                s.name,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                "Drone Capacity: ${s.capacity}",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                s.location.lname,
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ViewStationScreen(
                                            s: s,
                                          );
                                        }));
                                      },
                                    );
                                  },
                                );
                              }
                            })),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
