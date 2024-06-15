import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPage();
}

class _LocationPage extends State<LocationPage> {
  double? currentLatitude;
  double? currentLongitude;

  final double coffeeShopLatitude = 37.4688;
  final double coffeeShopLongitude = -122.1411;
  final String coffeeShopName = 'Koffee Korner';


  late GoogleMapController mapController;
  Set<Marker> markers = {};
  Polyline? routePolyline;
  double? distanceInMeters;

  @override
  void initState() {
    super.initState();
    getGeolocation();
  }

  void getGeolocation() async {
    // Check if permission is granted
    var status = await Permission.locationWhenInUse.status;

    if (!status.isGranted) {
      // Request permission if its granted
      status = await Permission.locationWhenInUse.request();

      if (!status.isGranted) {
        print('Location permissions are denied');
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        currentLatitude = position.latitude;
        currentLongitude = position.longitude;

        markers.add(
          Marker(
            markerId: MarkerId('currentLocation'),
            position: LatLng(currentLatitude!, currentLongitude!),
            infoWindow: InfoWindow(title: 'Current Location'),
          ),
        );

        markers.add(
          Marker(
            markerId: MarkerId('coffeeShop_$coffeeShopName'),
            position: LatLng(coffeeShopLatitude, coffeeShopLongitude),
            infoWindow: InfoWindow(title: coffeeShopName),
          ),
        );

        distanceInMeters = Geolocator.distanceBetween(
          currentLatitude!,
          currentLongitude!,
          coffeeShopLatitude,
          coffeeShopLongitude,
        );

        routePolyline = Polyline(
          polylineId: PolylineId('route'),
          points: [
            LatLng(currentLatitude!, currentLongitude!),
            LatLng(coffeeShopLatitude, coffeeShopLongitude),
          ],
          color: Colors.blue,
          width: 5,
        );
      });

      print('Current Latitude: $currentLatitude');
      print('Current Longitude: $currentLongitude');
      print('Distance to coffee shop: $distanceInMeters meters');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Location',
            style: TextStyle(
              color: Colors.brown[900],
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.brown[900]),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLatitude ?? coffeeShopLatitude, currentLongitude ?? coffeeShopLongitude),
                zoom: 13.0,
              ),
              mapType: MapType.normal,
              markers: markers,
              polylines: routePolyline != null ? {routePolyline!} : {},
            ),
            if (distanceInMeters != null)
              Positioned(
                bottom: 20,
                left: 20,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Text(
                    'Distance to Koffee Korner: ${(distanceInMeters! / 1000).toStringAsFixed(2)} km',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown[900]),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(LocationPage());
}
