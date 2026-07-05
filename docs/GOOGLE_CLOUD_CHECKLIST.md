# Checklist Google Cloud — Rutas Panamá

Acciones que debe hacer el dueño del proyecto con su cuenta:

1. Crear proyecto en Google Cloud.
2. Activar facturación.
3. Habilitar APIs:
   - Maps SDK for Android
   - Maps SDK for iOS, cuando toque iPhone
   - Places API
   - Routes API, fase posterior
4. Crear API Key.
5. Restringir API Key:
   - Por Android package name + SHA-1.
   - Por bundle ID en iOS.
6. No compartir la llave por WhatsApp ni subirla a GitHub.
7. Configurar alertas de presupuesto.

Regla comercial:
Google Places puede ser excelente, pero hay que controlar costos. El MVP debe cachear o limitar búsquedas para evitar consumo innecesario.
