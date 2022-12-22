


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

 late Position c1;

  Future getPosition()async{
    bool services;
    LocationPermission locationPermission;
    services=await Geolocator.isLocationServiceEnabled();
    print("services is ="+services.toString());
    if(services==false){
      AwesomeDialog(
        context: context,
        title: "services",
        body: Text("services is not enabled!"),

      )..show();
    }
    locationPermission=await Geolocator.checkPermission();

    if(locationPermission==LocationPermission.denied){
      locationPermission=await Geolocator.requestPermission();
      if(locationPermission!=LocationPermission.denied){
        getLatLng();
      }
    }
    print("///////////////////");
    print("locationPermission="+locationPermission.toString());
    print("///////////////////");
  }

 Future<Position> getLatLng()async{
    return await Geolocator.getCurrentPosition().then((value) => value);
 }

   // Completer<GoogleMapController> _controller = Completer();
   //
   // static final CameraPosition _kGooglePlex = CameraPosition(
   //   target: LatLng(37.42796133580664, -122.085749655962),
   //   zoom: 14.4746,
   // );
   //
   // static final CameraPosition _kLake = CameraPosition(
   //     bearing: 192.8334901395799,
   //     target: LatLng(37.43296265331129, -122.08832357078792),
   //     tilt: 59.440717697143555,
   //     zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosition();
    getLatLng();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map"),),
      body: Column(
        children: [
          // Container(
          //   height: 500,
          //   child: GoogleMap(
          //     mapType: MapType.hybrid,
          //     initialCameraPosition: _kGooglePlex,
          //     onMapCreated: (GoogleMapController controller) {
          //       _controller.complete(controller);
          //     },
          //   ),
          // ),
          TextButton(
          onPressed:()async{
            c1=await getLatLng();
            print(c1.latitude);
            print(c1.longitude);
            List<Placemark> placemarks = await placemarkFromCoordinates(c1.latitude,c1.longitude);
            print(placemarks[0].street);
            //لو عايز احسب المسافه ما بين منطقتين
            var distanceBetween=Geolocator.distanceBetween(c1.latitude, c1.longitude, 29.412864, 30.871979);
            var distanceKM=distanceBetween/1000;
            print("$distanceKM km");
          }, child: Text("Show Lat And Lang")),
        ],
      ),
    );
  }
}
