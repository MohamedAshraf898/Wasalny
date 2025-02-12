// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../models/place_model.dart';
import '../utils/Location_Service.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;
  late Location location;
  late LocationService locationService;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        target: LatLng(31.21363651121742, 29.91188144350756), zoom: 8);
    locationService = LocationService();
    location = Location();
    UpdateMyLcation();
    initmarker();
    initpolyline();
    super.initState();
  }

  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  bool isFirstCall = true;
  GoogleMapController? googleMapController;
  @override
  void dispose() {
    super.dispose();
    googleMapController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        // polylines: polylines,
        zoomControlsEnabled: false,
        markers: markers,
        onMapCreated: (controller) {
          googleMapController = controller;
          // mapstyle();
        },
        // cameraTargetBounds: CameraTargetBounds(
        //   LatLngBounds(
        //     southwest: const LatLng(22.167986, 25.032595),
        //     northeast: const LatLng(31.260669374013705, 34.11024406151212),
        //   ),
        // ),
        initialCameraPosition: initialCameraPosition,
      ),
      // Positioned(
      //   bottom: 16,
      //   left: 16,
      //   right: 16,
      //   child: ElevatedButton(
      //     onPressed: () {
      //       googleMapController!.animateCamera(
      //         CameraUpdate.newCameraPosition(
      //           const CameraPosition(
      //               zoom: 15,
      //               target: LatLng(30.64310566658504, 31.17366003148489)),
      //         ),
      //       );
      //     },
      //     child: const Text(
      //       'كفر هلال',
      //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //     ),
      //   ),
      // )
    ]);
  }

  void mapstyle() async {
    var grayMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/mapStyle/gray_white.json');
    googleMapController!.setMapStyle(grayMapStyle);
  }

  Future<Uint8List> getImageRawData(String Image, double width) async {
    var imageData = await rootBundle.load(Image);
    var imageCoded = await ui.instantiateImageCodec(
        imageData.buffer.asUint8List(),
        targetWidth: width.round());
    var imageFrame = await imageCoded.getNextFrame();
    var imageByteData =
        await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);
    return imageByteData!.buffer.asUint8List();
  }

  void initmarker() async {
    var customMarkerIcon = BitmapDescriptor.fromBytes(
        await getImageRawData('assets/images/mini-bus.png', 100));
    var myMarkers = places
        .map(
          (e) => Marker(
            icon: customMarkerIcon,
            infoWindow: InfoWindow(
              title: e.name,
            ),
            position: e.latLng,
            markerId: MarkerId(e.id.toString()),
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }

  void initpolyline() {
    Polyline polyline = const Polyline(
      color: Colors.black,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      width: 5,
      points: [
        LatLng(31.21363651121742, 29.91188144350756),
        LatLng(30.78173728029123, 30.99103428055039),
        LatLng(30.64310566658504, 31.17366003148489)
      ],
      polylineId: PolylineId('1'),
    );
    polylines.add(polyline);
  }

  void getLocationData() async {
    location.changeSettings(
      distanceFilter: 2,
    );
    var customMarkerIcon = BitmapDescriptor.fromBytes(
        await getImageRawData('assets/images/mini-bus.png', 100));
    location.onLocationChanged.listen((locationData) {
      var myLocationMarker = Marker(
          icon: customMarkerIcon,
          markerId: const MarkerId('My Location'),
          position: LatLng(locationData.latitude!, locationData.longitude!));
      markers.add(myLocationMarker);
      setState(() {});
      if (isFirstCall) {
        CameraPosition cameraPosition = CameraPosition(
            target: LatLng(locationData.latitude!, locationData.longitude!),
            zoom: 15);
        googleMapController
            ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        isFirstCall = false;
      } else {
        googleMapController?.animateCamera(CameraUpdate.newLatLng(
            LatLng(locationData.latitude!, locationData.longitude!)));
      }
    });
  }

  // ignore: non_constant_identifier_names
  void UpdateMyLcation() async {
    await locationService.checkAndRequestLocationService();
    var hasPremission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPremission) {
      getLocationData();
    }
  }
}
