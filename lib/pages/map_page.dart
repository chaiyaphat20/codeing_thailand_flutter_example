import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: GoogleMap(
        markers: <Marker>{
          Marker(
              markerId: const MarkerId('001'),
              position: const LatLng(37.42796133580664, -122.085749655962),
              infoWindow: const InfoWindow(
                  title: "อบรม Flutter ที่นี่", snippet: "เดือน ม.ค. 65"),
              onTap: () {
                Get.snackbar('การเดินทาง', 'ใช้รถไฟฟ้าได้');
              } //popup ที่ marker
              )
        },
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
