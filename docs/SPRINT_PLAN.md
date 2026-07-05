# Plan de sprints — Rutas Panamá

## Sprint 0 — Estabilización
Objetivo: que el proyecto compile correctamente.
Entregables:
- Proyecto Flutter creado formalmente.
- Dependencias resueltas.
- Android funcionando.
- README actualizado.

## Sprint 1 — GPS y mapa
Objetivo: mostrar ubicación real y rutas iniciales.
Entregables:
- Permisos de ubicación.
- Ubicación actual.
- Marcadores de rutas.
- Manejo de permisos denegados.

## Sprint 2 — Google Places
Objetivo: reemplazar lugares mock por lugares reales.
Entregables:
- Servicio Places.
- Búsqueda por categoría: restaurantes, hoteles, cafés, parkings, atractivos.
- Rating, dirección y distancia.
- Manejo de errores y límites de API.

## Sprint 3 — Supabase
Objetivo: administrar rutas desde base de datos.
Entregables:
- Tablas tourist_routes, route_stops, sponsored_places.
- Servicio Supabase.
- Carga dinámica de rutas.
- Fallback local si no hay conexión.

## Sprint 4 — Asistente inteligente básico
Objetivo: recomendaciones por contexto.
Entregables:
- Preferencias: tiempo, presupuesto, movilidad, interés.
- Recomendación de ruta.
- Respuesta amigable tipo concierge.

## Sprint 5 — Monetización MVP
Objetivo: preparar espacios comerciales.
Entregables:
- Lugares destacados.
- Ordenamiento por sponsor_level.
- Etiqueta “Recomendado”.
- Estructura para panel admin.
