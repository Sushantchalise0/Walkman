import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:WalkmanMobile/services/vendorList_services.dart';
import 'package:location/location.dart';
import '../../util/colors.dart';

class MapContainer extends StatefulWidget {
  @override
  _MapContainerState createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  VendorListServices vendorListServices = VendorListServices();
  Completer<GoogleMapController> _controller = Completer();
  Map<String, Marker> markers = {};
  List<Marker> allMarkers = [];
  Location location = new Location();
  LocationData currentLocation;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(27.7347, 85.3144),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 235,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 2.0,
            color: ThemeColor.greyWhite,
          ),
        ),
      ),
      child: Stack(
        children: [
          GoogleMap(
              markers: Set.from(allMarkers),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: initialLocation),
        ],
      ),
    );
  }
}
