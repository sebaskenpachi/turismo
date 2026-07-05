# Arquitectura técnica — Rutas Panamá

## App móvil
Flutter para Android/iOS.

## Capas
- `models`: entidades de negocio.
- `screens`: pantallas.
- `widgets`: componentes reutilizables.
- `services`: llamadas a GPS, mapas, Places, Supabase e IA.
- `data`: datos mock temporales para MVP.

## Servicios
### LocationService
Responsable de permisos y ubicación del usuario.

### PlacesService
Fase 1: datos mock.
Fase 2: integración Google Places.

### RoutesService
Fase 1: rutas locales.
Fase 2: rutas desde Supabase.

### AssistantService
Fase 1: reglas simples.
Fase 2: motor contextual.
Fase 3: IA conversacional.

## Backend recomendado
Supabase:
- PostgreSQL para rutas, paradas y comercios.
- Storage para imágenes.
- Auth para usuarios.
- Edge Functions en fases posteriores.

## APIs externas
- Google Maps SDK
- Google Places API
- Google Directions/Routes API en fase posterior
- Weather API en fase posterior

## Seguridad
- API keys en variables de entorno o configuración nativa segura.
- Restringir Google API Key por app Android/iOS.
- Nunca subir llaves privadas al repositorio.
- Usar `.env.example` como plantilla.
