import 'package:flutter/material.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/CustomWidget.dart';
import 'package:mob_monitoring/Model/Station.dart';
import 'package:mob_monitoring/Screens/ViewStation.dart';

class StationScreen extends StatefulWidget {
  const StationScreen({super.key});

  @override
  State<StationScreen> createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
  TextEditingController search = TextEditingController();
  List<String> mtypelist = ["All"];
  int selectedIndex = 0;
  List<Station> slist = [];

  List<Station> all_slist = [];
  @override
  void initState() {
    super.initState();
    loadDetails();
    search.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      all_slist = slist
          .where((item) =>
              item.name.toLowerCase().contains(search.text.toLowerCase()))
          .toList();
    });
  }

  Future<void> loadDetails() async {
    slist = await APIHandler().GetAllStation();
    all_slist.addAll(slist);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Station> mlist = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Stations"),
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
            height: 20,
          ),
          Container(
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
                    mlist = snapshot.data!;
                    if (mlist.length == 0) {
                      return Center(
                        child: Text('No station added'),
                      );
                    }
                    return Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                              itemCount: all_slist.length,
                              itemBuilder: (context, index) {
                                Station m = all_slist[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        height: 110.0,
                                        width: 320.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Color.fromARGB(
                                                255, 223, 229, 231),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white.withOpacity(
                                                    0.1), // Shadow color
                                                spreadRadius:
                                                    1, // Spread radius
                                                blurRadius: 1, // Blur radius
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                m.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("Drones Capacity : " +
                                                  m.capacity.toString(),style: TextStyle(fontSize: 14,color: Colors.red),),
                                              Text(
                                                "Total Drones : " +
                                                    m.available_drones
                                                        .toString(),style: TextStyle(fontSize: 14,color: Colors.blue)
                                              ),
                                              // Text(
                                              //   "Total Drones : " +
                                              //       m.
                                              //           .toString(),style: TextStyle(fontSize: 14)
                                              // ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewStationScreen(
                                            s: m,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              })),
                    );
                  }
                })),
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
