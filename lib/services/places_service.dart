import 'dart:math';
import '../data/panama_routes.dart';
import '../models/place_item.dart';
import '../models/tourist_route.dart';

class PlacesService {
  List<PlaceItem> getRecommendedPlaces(TouristRoute route, {String? category}) {
    final places = mockPlaces.where((place) {
      final distance = _distanceKm(route.latitude, route.longitude, place.latitude, place.longitude);
      final categoryMatches = category == null || category == 'todo' || place.category == category;
      return distance <= 3.5 && categoryMatches;
    }).toList();

    places.sort((a, b) {
      if (a.sponsored != b.sponsored) return a.sponsored ? -1 : 1;
      return b.rating.compareTo(a.rating);
    });
    return places;
  }

  double _distanceKm(double lat1, double lon1, double lat2, double lon2) {
    const earthRadiusKm = 6371.0;
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) * cos(_degToRad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double _degToRad(double deg) => deg * pi / 180;
}
