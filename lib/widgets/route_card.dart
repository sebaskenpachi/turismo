import 'package:flutter/material.dart';
import '../models/tourist_route.dart';

class RouteCard extends StatelessWidget {
  final TouristRoute route;
  final VoidCallback onTap;

  const RouteCard({super.key, required this.route, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(route.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${route.description}\n${route.estimatedMinutes} min · ${route.tags.join(', ')}'),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
