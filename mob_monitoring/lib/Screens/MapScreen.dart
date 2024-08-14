import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  late LatLng selectedLocation;
  static const LatLng currentLocation = LatLng(33.641855, 73.077002);

  String selectedLocationText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentLocation, // Center the map at (0, 0) initially
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            onTap: _selectLocation,
            markers: Set<Marker>.of(markers),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              // Handle saving the selected location here
              // For demonstration, let's just navigate back to the previous screen
              Navigator.pop(context, {
                'location': selectedLocation,
                'text': selectedLocationText,
              });
              print(selectedLocation);
            },
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _selectLocation(LatLng latLng) async {
    selectedLocation = latLng;
    // final List<Placemark> placemarks =
    //     await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    // final Placemark place = placemarks.first;
    // setState(() {
    //   selectedLocationText =
    //       "${place.subLocality}, ${place.locality}, ${place.country}";
    //   //              "${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    // });

    try {
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        setState(() {
          selectedLocationText =
              "${place.subLocality}, ${place.locality}, ${place.country}";
          //       areaText = "${place.subLocality}";
        });
      } else {
        print('No placemarks found.');
      }
    } catch (e) {
      print('Caught an exception: $e');
    }

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15),
      ),
    );
    _addMarker(latLng);
  }

  List<Marker> markers = [];

  void _addMarker(LatLng latLng) {
    setState(() {
      markers.clear(); // Clear existing markers
      markers.add(
        Marker(
          markerId: MarkerId('selectedLocation'),
          position: latLng,
          draggable: true,
          infoWindow: InfoWindow(
            title: 'Selected Location',
            snippet: selectedLocationText,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed), // Change marker color here
        ),
      );
    });
  }
}
