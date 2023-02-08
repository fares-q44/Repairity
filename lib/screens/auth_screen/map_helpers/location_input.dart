import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_helper.dart';
import 'map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  const LocationInput(
      {Key? key,
      required this.onSelectPlace,
      this.previewLat = -1,
      this.previewLon = -1})
      : super(key: key);
  final double previewLat;
  final double previewLon;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longtitude: lng);
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Geolocator.getCurrentPosition();
      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    } else {
      _showPreview(selectedLocation.latitude, selectedLocation.longitude);
      widget.onSelectPlace(
          selectedLocation.latitude, selectedLocation.longitude);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.previewLat != -1) {
      _showPreview(widget.previewLat, widget.previewLon);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '  Choose location:',
          ),
        ),
        SizedBox(
          height: sHeight * 0.01,
        ),
        Container(
          decoration: BoxDecoration(
              border:
                  Border.all(width: 1, color: Theme.of(context).primaryColor)),
          alignment: Alignment.center,
          height: sHeight * 0.2,
          width: sWidth * 0.8,
          child: _previewImageUrl == null
              ? const Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(
                Icons.location_on,
                color: Theme.of(context).primaryColor,
              ),
              label: const Text(
                'Current Location',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map, color: Theme.of(context).primaryColor),
              label: const Text(
                'Select on Map',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        )
      ],
    );
  }
}
