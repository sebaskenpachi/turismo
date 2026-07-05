import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/place_item.dart';
import '../models/tourist_route.dart';

class MapScreen extends StatelessWidget {
  final TouristRoute route;
  final List<PlaceItem> places;

  const MapScreen({super.key, required this.route, required this.places});

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>{
      Marker(
        markerId: MarkerId(route.id),
        position: LatLng(route.latitude, route.longitude),
        infoWindow: InfoWindow(title: route.name, snippet: 'Punto principal'),
      ),
      ...places.map((place) => Marker(
            markerId: MarkerId(place.id),
            position: LatLng(place.latitude, place.longitude),
            infoWindow: InfoWindow(title: place.name, snippet: place.category),
          )),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de ruta')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(route.latitude, route.longitude),
          zoom: 14,
        ),
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.directions),
        label: const Text('Cómo llegar'),
        onPressed: () => _openGoogleMaps(route.latitude, route.longitude),
      ),
    );
  }

  Future<void> _openGoogleMaps(double lat, double lng) async {
    final uri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir Google Maps');
    }
  }
}
