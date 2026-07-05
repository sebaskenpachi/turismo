# Tarea Codex — Sprint 1: GPS y mapa

Implementa ubicación real del usuario y mapa funcional.

Objetivo:
El usuario debe ver su ubicación actual y los marcadores de las rutas turísticas iniciales.

Instrucciones:
1. Implementa permisos de ubicación con `geolocator`.
2. Maneja estados: permiso aceptado, denegado, denegado permanentemente y GPS apagado.
3. Muestra la ubicación actual en el mapa.
4. Muestra marcadores para Cerro Ancón, Cinta Costera y Casco Viejo.
5. Agrega botón para centrar mapa en la ubicación actual.
6. Agrega botón para abrir navegación externa con Google Maps usando `url_launcher`.
7. Mantén datos mock de lugares; no conectes Google Places todavía.

Criterio de aceptación:
- La app no se cae si el usuario niega permisos.
- El mapa muestra rutas y/o ubicación.
- El botón “cómo llegar” abre navegación externa.
