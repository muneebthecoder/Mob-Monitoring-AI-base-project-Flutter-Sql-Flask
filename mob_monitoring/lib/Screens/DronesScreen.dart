import 'package:flutter/material.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/CustomWidget.dart';
import 'package:mob_monitoring/Model/Drone.dart';
import 'package:mob_monitoring/Screens/ViewDrone.dart';

class DronesScreen extends StatefulWidget {
  const DronesScreen({super.key});

  @override
  State<DronesScreen> createState() => _DronesScreenState();
}

class _DronesScreenState extends State<DronesScreen> {
  TextEditingController search = TextEditingController();
  List<String> categories = ["All", "Available", "Unavailable"];
  int selectedIndex = 0;
  List<Drone> dlist = [];
  List<Drone> all_dlist = [];
  List<Drone> all_dlist1 = [];
  List<Drone> all_dlist2 = [];


  @override
  void initState() {
    super.initState();
    loadDetails();
    search.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      all_dlist = dlist
          .where((item) =>
              item.type.toLowerCase().contains(search.text.toLowerCase()))
          .toList();
    });
  }

  Future<void> loadDetails() async {
    dlist = await APIHandler().GetAllDrone();
    all_dlist.addAll(dlist);
    for (int i = 0; i < dlist.length; i++) {
      dlist[i].isAvailable == true
          ? all_dlist1.add(dlist[i])
          : all_dlist2.add(dlist[i]);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Drones"),
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
            height: 15,
          ),
          Container(
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.builder(
                  itemCount: selectedIndex==0?all_dlist.length:selectedIndex==1?all_dlist1.length:all_dlist2.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                    drone: selectedIndex==0?all_dlist[index]:selectedIndex==1?all_dlist1[index]:all_dlist2[index],
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewDroneScreen(
                          drone: selectedIndex==0?all_dlist[index]:selectedIndex==1?all_dlist1[index]:all_dlist2[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
              height: 100.0,
              width: 150.0,
              padding: EdgeInsets.all(10.0),
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
