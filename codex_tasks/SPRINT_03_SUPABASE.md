# Tarea Codex — Sprint 3: Supabase

Conecta Supabase para administrar rutas turísticas.

Objetivo:
Sacar las rutas del código y cargarlas desde Supabase.

Instrucciones:
1. Agrega dependencia `supabase_flutter`.
2. Crea `lib/services/supabase_service.dart`.
3. Crea `lib/services/routes_repository.dart` si es necesario.
4. Lee variables `SUPABASE_URL` y `SUPABASE_ANON_KEY` desde configuración segura.
5. Carga `tourist_routes` desde Supabase.
6. Carga `route_stops` por ruta.
7. Carga `sponsored_places` activos por ruta.
8. Si Supabase falla, usa datos locales de `panama_routes.dart`.

Criterio de aceptación:
- Home carga rutas desde Supabase cuando hay conexión.
- Funciona fallback local cuando Supabase no está configurado.
