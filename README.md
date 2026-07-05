# Rutas Panamá MVP

MVP inicial de una app turística inteligente para Panamá.

## Concepto
Rutas Panamá es un concierge turístico inteligente que recomienda rutas, lugares y experiencias según ubicación, tiempo, presupuesto e intereses.

## Qué incluye hoy
- Home con rutas turísticas iniciales.
- Detalle de ruta.
- Asistente básico.
- Mapa con Google Maps.
- Marcadores y paradas recomendadas.
- Botón para abrir navegación en Google Maps.

## Stack objetivo
- Flutter
- Google Maps
- Google Places API
- Supabase

## Sprint 0: ejecutar en Android

Requisitos locales:
- Flutter SDK instalado.
- Android SDK instalado.
- Un emulador Android o teléfono Android conectado.

Comandos:

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Para probar el mapa sin quemar llaves en Git, configura la llave de Google Maps en `android/local.properties`, archivo que está ignorado por Git:

```properties
GOOGLE_MAPS_API_KEY=tu_api_key_android_restringida
```

También puedes usar una variable de entorno `GOOGLE_MAPS_API_KEY` en el entorno de build. No subas llaves reales de Google, Supabase ni OpenAI al repositorio.

## Primer paso con Codex
Abrir el proyecto en Codex y ejecutar la tarea:

`codex_tasks/SPRINT_00_STABILIZE.md`

## Orden recomendado
1. Sprint 0: estabilizar y compilar.
2. Sprint 1: GPS y mapa.
3. Sprint 2: Google Places.
4. Sprint 3: Supabase.
5. Sprint 4: asistente turístico inteligente.
6. Sprint 5: monetización.

## Documentos importantes
- `CODEX.md`: reglas para el agente.
- `docs/PRODUCT_BLUEPRINT.md`: visión del producto.
- `docs/TECHNICAL_ARCHITECTURE.md`: arquitectura técnica.
- `docs/SPRINT_PLAN.md`: plan de trabajo.
- `docs/QA_USER_TEST_PLAN.md`: plan de pruebas para Sebastián.
- `db/supabase_schema.sql`: base de datos inicial.
- `env/.env.example`: plantilla de variables.

## Nota de seguridad
No subir llaves reales de Google, Supabase ni OpenAI al repositorio.
