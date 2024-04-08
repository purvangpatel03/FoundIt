import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();

  final List<LatLng> points = [
    LatLng(48.9146074, 12.81123148),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: mapController,
              options: const MapOptions(
                maxZoom: 21,
                initialCenter: LatLng(48.9146074, 12.81123148),
                initialZoom: 5.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  maxZoom: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
