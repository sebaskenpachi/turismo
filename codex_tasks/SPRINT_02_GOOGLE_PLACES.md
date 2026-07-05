# Tarea Codex — Sprint 2: Google Places

Conecta Google Places API para obtener lugares reales cercanos.

Objetivo:
Reemplazar lugares simulados por restaurantes, hoteles, cafés, parkings y atractivos reales cerca de la ruta seleccionada.

Instrucciones:
1. Crea o actualiza `lib/services/places_service.dart`.
2. Usa API Key desde configuración segura, no quemada en código.
3. Implementa búsqueda por categoría:
   - restaurant
   - lodging
   - cafe
   - parking
   - tourist_attraction
4. Devuelve modelo `PlaceItem` con:
   - name
   - category
   - latitude
   - longitude
   - rating
   - address
   - distanceMeters si es posible
5. Maneja errores de red, API key inválida y límites de API.
6. Mantén fallback a mockPlaces si la API falla.

Criterio de aceptación:
- En Cerro Ancón aparecen lugares reales cercanos.
- El usuario puede filtrar por categoría.
- La app sigue funcionando aunque Places falle.
