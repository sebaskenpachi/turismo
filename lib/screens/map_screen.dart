import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/panama_routes.dart';
import '../models/place_item.dart';
import '../models/tourist_route.dart';
import '../services/location_service.dart';

class MapScreen extends StatefulWidget {
  final TouristRoute route;
  final List<PlaceItem> places;
  final LocationService locationService;

  MapScreen({
    super.key,
    required this.route,
    required this.places,
    LocationService? locationService,
  }) : locationService = locationService ?? LocationService();

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Position? _userPosition;
  LocationException? _locationError;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de ruta')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.route.latitude, widget.route.longitude),
              zoom: 14,
            ),
            markers: _markers,
            myLocationEnabled: _userPosition != null,
            myLocationButtonEnabled: _userPosition != null,
            onMapCreated: (controller) {
              _mapController = controller;
              final userPosition = _userPosition;
              if (userPosition != null) {
                _moveCameraToUser(userPosition);
              }
            },
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 88,
            child: _LocationStatusCard(
              isLoading: _isLoadingLocation,
              userPosition: _userPosition,
              error: _locationError,
              onRetry: _loadUserLocation,
              onOpenAppSettings: _openAppSettings,
              onOpenLocationSettings: _openLocationSettings,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.directions),
        label: const Text('Cómo llegar'),
        onPressed: () => _openGoogleMaps(widget.route.latitude, widget.route.longitude),
      ),
    );
  }

  Set<Marker> get _markers {
    final routeMarkers = touristRoutes.map((touristRoute) {
      final isSelectedRoute = touristRoute.id == widget.route.id;
      return Marker(
        markerId: MarkerId('route_${touristRoute.id}'),
        position: LatLng(touristRoute.latitude, touristRoute.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          isSelectedRoute ? BitmapDescriptor.hueAzure : BitmapDescriptor.hueRed,
        ),
        infoWindow: InfoWindow(
          title: touristRoute.name,
          snippet: isSelectedRoute ? 'Ruta seleccionada' : 'Ruta inicial',
        ),
      );
    });

    final placeMarkers = widget.places.map((place) {
      return Marker(
        markerId: MarkerId('place_${place.id}'),
        position: LatLng(place.latitude, place.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          place.sponsored ? BitmapDescriptor.hueYellow : BitmapDescriptor.hueGreen,
        ),
        infoWindow: InfoWindow(title: place.name, snippet: place.category),
      );
    });

    final userPosition = _userPosition;
    final userMarkers = userPosition == null
        ? <Marker>[]
        : [
            Marker(
              markerId: const MarkerId('user_location'),
              position: LatLng(userPosition.latitude, userPosition.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              infoWindow: const InfoWindow(title: 'Tu ubicación actual'),
            ),
          ];

    return {
      ...routeMarkers,
      ...placeMarkers,
      ...userMarkers,
    };
  }

  Future<void> _loadUserLocation() async {
    setState(() {
      _isLoadingLocation = true;
      _locationError = null;
    });

    try {
      final position = await widget.locationService.getCurrentPosition();
      if (!mounted) return;
      setState(() {
        _userPosition = position;
        _isLoadingLocation = false;
      });
      await _moveCameraToUser(position);
    } on LocationException catch (error) {
      if (!mounted) return;
      setState(() {
        _locationError = error;
        _userPosition = null;
        _isLoadingLocation = false;
      });
    }
  }

  Future<void> _moveCameraToUser(Position position) async {
    final controller = _mapController;
    if (controller == null) return;
    await controller.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(position.latitude, position.longitude), 14.5),
    );
  }

  Future<void> _openAppSettings() async {
    await widget.locationService.openAppSettings();
    await _loadUserLocation();
  }

  Future<void> _openLocationSettings() async {
    await widget.locationService.openLocationSettings();
    await _loadUserLocation();
  }

  Future<void> _openGoogleMaps(double lat, double lng) async {
    final uri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir Google Maps');
    }
  }
}

class _LocationStatusCard extends StatelessWidget {
  final bool isLoading;
  final Position? userPosition;
  final LocationException? error;
  final VoidCallback onRetry;
  final VoidCallback onOpenAppSettings;
  final VoidCallback onOpenLocationSettings;

  const _LocationStatusCard({
    required this.isLoading,
    required this.userPosition,
    required this.error,
    required this.onRetry,
    required this.onOpenAppSettings,
    required this.onOpenLocationSettings,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const _StatusSurface(
        icon: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        title: 'Buscando tu ubicación',
        message: 'Preparando el mapa con tu posición actual.',
      );
    }

    final locationError = error;
    if (locationError != null) {
      return _buildErrorStatus(locationError);
    }

    final position = userPosition;
    if (position != null) {
      return _StatusSurface(
        icon: const Icon(Icons.my_location, color: Colors.green),
        title: 'Ubicación activada',
        message:
            'Lat ${position.latitude.toStringAsFixed(4)}, lng ${position.longitude.toStringAsFixed(4)}',
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildErrorStatus(LocationException locationError) {
    switch (locationError.reason) {
      case LocationFailureReason.serviceDisabled:
        return _StatusSurface(
          icon: const Icon(Icons.location_disabled, color: Colors.orange),
          title: 'GPS apagado',
          message: locationError.message,
          actionLabel: 'Abrir ajustes',
          onAction: onOpenLocationSettings,
        );
      case LocationFailureReason.permissionDenied:
        return _StatusSurface(
          icon: const Icon(Icons.location_off, color: Colors.orange),
          title: 'Permiso denegado',
          message: locationError.message,
          actionLabel: 'Intentar de nuevo',
          onAction: onRetry,
        );
      case LocationFailureReason.permissionDeniedForever:
        return _StatusSurface(
          icon: const Icon(Icons.lock, color: Colors.red),
          title: 'Permiso bloqueado',
          message: locationError.message,
          actionLabel: 'Abrir app',
          onAction: onOpenAppSettings,
        );
    }
  }
}

class _StatusSurface extends StatelessWidget {
  final Widget icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _StatusSurface({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(message),
                ],
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(width: 8),
              TextButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
