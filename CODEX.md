# CODEX.md — Reglas para construir Rutas Panamá

## Rol del agente
Eres el desarrollador principal de la app Rutas Panamá. Debes construir un MVP real, mantenible y escalable en Flutter, orientado a turismo inteligente en Panamá.

## Principios obligatorios
1. No quemar API keys en el código.
2. Mantener arquitectura limpia: `models`, `services`, `screens`, `widgets`, `data`.
3. Cada tarea debe compilar antes de considerarse terminada.
4. Entregar resumen de archivos modificados al final de cada tarea.
5. No reescribir todo el proyecto sin necesidad.
6. No agregar paquetes innecesarios.
7. Priorizar Android primero; iOS queda preparado pero no bloquea el MVP.
8. Manejar errores de permisos, red, ubicación y API externa.
9. Mantener el producto simple: rutas, mapa, lugares cercanos, asistente turístico.
10. Todo cambio debe pensar en monetización futura: comercios patrocinados, rutas premium, tours y alianzas.

## Stack objetivo
- Flutter
- Google Maps
- Google Places API
- Supabase para rutas propias, comercios patrocinados y favoritos
- Backend serverless mínimo

## MVP esperado
El usuario debe poder:
- Abrir la app.
- Ver rutas turísticas de Panamá.
- Seleccionar Cerro Ancón, Cinta Costera o Casco Viejo.
- Ver mapa y punto principal de la ruta.
- Ver lugares recomendados cercanos.
- Abrir navegación en Google Maps.
- Usar un asistente básico por tiempo, presupuesto y tipo de experiencia.

## Criterio de calidad
El MVP no debe ser perfecto, pero debe sentirse vendible. Si una funcionalidad se ve bonita pero no ayuda a probar el negocio, se posterga.
