import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSt extends StatefulWidget {
  const MapSt({super.key});

  @override
  State<MapSt> createState() => _MapStState();
}

class _MapStState extends State<MapSt> {
   Location lcontroller=new Location();
   final Completer<GoogleMapController> mapController=Completer<GoogleMapController>();
  static const LatLng SelectLocation=LatLng(33.641855, 73.077002);
  static const LatLng SelectLocation2=LatLng(33.662908, 73.085529);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoUp();
  }

  LatLng? cloc=null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cloc==null? Center(child: Text("Loading..."),):
       GoogleMap(
        initialCameraPosition: CameraPosition(
          target: SelectLocation,
          zoom: 13
          ),
          markers: {
            Marker(markerId: MarkerId("Cl"),
            icon: BitmapDescriptor.defaultMarker,
            position :cloc!,),
            
            Marker(markerId: MarkerId("sl"),
            icon: BitmapDescriptor.defaultMarker,
            position :SelectLocation,),

            Marker(markerId: MarkerId("dl"),
            icon: BitmapDescriptor.defaultMarker,
            position :SelectLocation2,),

            
          },
      ),
    );
  }


Future<void> getLoUp()async{
  bool serviceEnable;
  PermissionStatus permissiongranted;

  serviceEnable=await lcontroller.serviceEnabled();
  if(serviceEnable){
    serviceEnable=await lcontroller.requestService();
  }else{
    return;
  }
  permissiongranted=await lcontroller.hasPermission();
  if(permissiongranted==PermissionStatus.denied){
      permissiongranted=await lcontroller.requestPermission();
      if(permissiongranted!=PermissionStatus.granted){
        return;
      }
  }
  lcontroller.onLocationChanged.listen((LocationData Currentlocation) 
  {
    if(Currentlocation.latitude!=null && Currentlocation.longitude!=null){
      setState(() {
        cloc=LatLng(Currentlocation.latitude!, Currentlocation.longitude!);
        print(cloc);
      });
    }
   });
}
}