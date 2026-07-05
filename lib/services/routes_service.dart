import '../data/panama_routes.dart';
import '../models/tourist_route.dart';

class RoutesService {
  List<TouristRoute> getRoutes() => touristRoutes;

  TouristRoute getRouteById(String id) {
    return touristRoutes.firstWhere((route) => route.id == id);
  }
}
