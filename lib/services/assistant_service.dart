import '../models/tourist_route.dart';
import '../models/place_item.dart';

class AssistantService {
  String buildRecommendation({
    required TouristRoute route,
    required List<PlaceItem> places,
    required int availableMinutes,
    required double budget,
    required String mood,
  }) {
    final recommendedPlace = places.isNotEmpty ? places.first : null;

    if (availableMinutes < route.estimatedMinutes) {
      return 'Te recomiendo una versión corta de ${route.name}. Tienes $availableMinutes minutos, así que prioriza el punto principal, una parada rápida y evita desviarte demasiado.';
    }

    final placeText = recommendedPlace == null
        ? 'No tengo una parada cercana cargada todavía, pero puedo guiarte directo al punto principal.'
        : 'Antes o después, puedes pasar por ${recommendedPlace.name}, especialmente si buscas ${recommendedPlace.category}.';

    return 'Plan sugerido: haz ${route.name}. Es ideal para $mood, toma aproximadamente ${route.estimatedMinutes} minutos y se ajusta a un presupuesto de B/.${budget.toStringAsFixed(0)}. $placeText';
  }
}
