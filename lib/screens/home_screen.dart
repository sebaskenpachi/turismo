import 'package:flutter/material.dart';
import '../services/routes_service.dart';
import '../widgets/route_card.dart';
import 'route_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = RoutesService().getRoutes();
    return Scaffold(
      appBar: AppBar(title: const Text('Rutas Panamá')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '¿Qué quieres hacer hoy?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Elige una ruta y el asistente te recomendará paradas cercanas.'),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                final route = routes[index];
                return RouteCard(
                  route: route,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RouteDetailScreen(route: route)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
