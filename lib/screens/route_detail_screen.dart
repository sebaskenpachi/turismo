import 'package:flutter/material.dart';
import '../models/tourist_route.dart';
import '../services/assistant_service.dart';
import '../services/places_service.dart';
import 'map_screen.dart';

class RouteDetailScreen extends StatefulWidget {
  final TouristRoute route;
  const RouteDetailScreen({super.key, required this.route});

  @override
  State<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  final placesService = PlacesService();
  final assistantService = AssistantService();
  final String mood = 'turismo relajado';
  int minutes = 120;
  double budget = 40;

  @override
  Widget build(BuildContext context) {
    final places = placesService.getRecommendedPlaces(widget.route);
    final recommendation = assistantService.buildRecommendation(
      route: widget.route,
      places: places,
      availableMinutes: minutes,
      budget: budget,
      mood: mood,
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.route.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(widget.route.description, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          const Text('Asistente inteligente', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(recommendation),
          const SizedBox(height: 16),
          Text('Tiempo disponible: $minutes minutos'),
          Slider(
            value: minutes.toDouble(),
            min: 30,
            max: 240,
            divisions: 7,
            label: '$minutes min',
            onChanged: (value) => setState(() => minutes = value.round()),
          ),
          Text('Presupuesto: B/.${budget.toStringAsFixed(0)}'),
          Slider(
            value: budget,
            min: 10,
            max: 150,
            divisions: 14,
            label: 'B/.${budget.toStringAsFixed(0)}',
            onChanged: (value) => setState(() => budget = value),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.map),
            label: const Text('Ver mapa y lugares cercanos'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MapScreen(route: widget.route, places: places)),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Paradas recomendadas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ...places.map((place) => Card(
                child: ListTile(
                  leading: Icon(place.sponsored ? Icons.star : Icons.place),
                  title: Text(place.name),
                  subtitle: Text('${place.category} · ${place.priceLevel} · ⭐ ${place.rating}\n${place.description}'),
                  isThreeLine: true,
                ),
              )),
        ],
      ),
    );
  }
}
