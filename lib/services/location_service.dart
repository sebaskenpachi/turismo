import 'package:geolocator/geolocator.dart';

typedef LocationServiceEnabledResolver = Future<bool> Function();
typedef LocationPermissionChecker = Future<LocationPermission> Function();
typedef LocationPermissionRequester = Future<LocationPermission> Function();
typedef CurrentPositionResolver = Future<Position> Function({LocationSettings? locationSettings});
typedef LocationSettingsOpener = Future<bool> Function();

enum LocationFailureReason {
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
}

class LocationException implements Exception {
  final LocationFailureReason reason;
  final String message;

  const LocationException(this.reason, this.message);

  @override
  String toString() => message;
}

class LocationService {
  final LocationServiceEnabledResolver _isLocationServiceEnabled;
  final LocationPermissionChecker _checkPermission;
  final LocationPermissionRequester _requestPermission;
  final CurrentPositionResolver _getCurrentPosition;
  final LocationSettingsOpener _openLocationSettings;
  final LocationSettingsOpener _openAppSettings;

  LocationService({
    LocationServiceEnabledResolver? isLocationServiceEnabled,
    LocationPermissionChecker? checkPermission,
    LocationPermissionRequester? requestPermission,
    CurrentPositionResolver? getCurrentPosition,
    LocationSettingsOpener? openLocationSettings,
    LocationSettingsOpener? openAppSettings,
  })  : _isLocationServiceEnabled = isLocationServiceEnabled ?? Geolocator.isLocationServiceEnabled,
        _checkPermission = checkPermission ?? Geolocator.checkPermission,
        _requestPermission = requestPermission ?? Geolocator.requestPermission,
        _getCurrentPosition = getCurrentPosition ?? _resolveCurrentPosition,
        _openLocationSettings = openLocationSettings ?? Geolocator.openLocationSettings,
        _openAppSettings = openAppSettings ?? Geolocator.openAppSettings;

  Future<Position> getCurrentPosition() async {
    final serviceEnabled = await _isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException(
        LocationFailureReason.serviceDisabled,
        'El GPS está apagado. Actívalo para usar la ruta inteligente.',
      );
    }

    var permission = await _checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(
        LocationFailureReason.permissionDeniedForever,
        'El permiso de ubicación está bloqueado. Actívalo desde la configuración de la app.',
      );
    }

    if (permission == LocationPermission.denied) {
      throw const LocationException(
        LocationFailureReason.permissionDenied,
        'No tenemos permiso de ubicación. Actívalo para recomendar lugares cercanos.',
      );
    }

    return _getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Future<bool> openLocationSettings() => _openLocationSettings();

  Future<bool> openAppSettings() => _openAppSettings();

  static Future<Position> _resolveCurrentPosition({LocationSettings? locationSettings}) {
    return Geolocator.getCurrentPosition(locationSettings: locationSettings);
  }
}
