import 'package:flutter/material.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/Model/Drone.dart';

class ViewDroneScreen extends StatefulWidget {
  final Drone drone;
  const ViewDroneScreen({required this.drone});

  @override
  State<ViewDroneScreen> createState() => _ViewDroneScreenState();
}

class _ViewDroneScreenState extends State<ViewDroneScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          widget.drone.model,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.25),
                    height: 600,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(widget.drone.type,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w400)),
                        Text(widget.drone.model,
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              // TextSpan(text: "Type: ${widget.drone.type}"),
                              // TextSpan(text: "Model: ${widget.drone.model}"),
                              // TextSpan(text: "Batery Timing: ${widget.drone.battery_timing}"),
                              // TextSpan(text: "Storage: ${widget.drone.storage}"),
                              // TextSpan(text: "Range: ${widget.drone.range}"),
                              // TextSpan(text: "Ceiling: ${widget.drone.ceiling}"),
                              // TextSpan(text: "Available: ${widget.drone.isAvailable}"),
                            ])),
                            SizedBox(
                              width: 60.0,
                            ),
                            Expanded(
                              child: Container(
                                height: 200.0,
                                width: 250.0,
                                child: Image.network(
                                    APIHandler.imgr_url + widget.drone.img,
                                    fit: BoxFit.contain),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Type: ",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("${widget.drone.type}",
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Model: ",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("${widget.drone.model}",
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Batery Timing: ",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("${widget.drone.battery_timing} minutes",
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Storage: ",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("${widget.drone.storage} GB",
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Range: ",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("${widget.drone.range} meter",
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Ceiling: ",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("${widget.drone.ceiling} meter",
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Available: ",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("${widget.drone.isAvailable==false?"NO":"YES"}",
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        SizedBox(
                          height: 100,
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
