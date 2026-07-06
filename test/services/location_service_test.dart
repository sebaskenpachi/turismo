import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rutas_panama_mvp/services/location_service.dart';

void main() {
  group('LocationService', () {
    test('returns current position when permission is granted', () async {
      var permissionRequested = false;
      final service = LocationService(
        isLocationServiceEnabled: () async => true,
        checkPermission: () async => LocationPermission.whileInUse,
        requestPermission: () async {
          permissionRequested = true;
          return LocationPermission.whileInUse;
        },
        getCurrentPosition: _fakeCurrentPosition,
      );

      final position = await service.getCurrentPosition();

      expect(position.latitude, 8.9824);
      expect(position.longitude, -79.5199);
      expect(permissionRequested, isFalse);
    });

    test('requests permission when it is initially denied', () async {
      var permissionRequested = false;
      final service = LocationService(
        isLocationServiceEnabled: () async => true,
        checkPermission: () async => LocationPermission.denied,
        requestPermission: () async {
          permissionRequested = true;
          return LocationPermission.whileInUse;
        },
        getCurrentPosition: _fakeCurrentPosition,
      );

      final position = await service.getCurrentPosition();

      expect(position.latitude, 8.9824);
      expect(permissionRequested, isTrue);
    });

    test('throws when location service is disabled', () async {
      final service = LocationService(
        isLocationServiceEnabled: () async => false,
      );

      await expectLater(
        service.getCurrentPosition(),
        throwsA(
          isA<LocationException>().having(
            (error) => error.reason,
            'reason',
            LocationFailureReason.serviceDisabled,
          ),
        ),
      );
    });

    test('throws when permission remains denied', () async {
      final service = LocationService(
        isLocationServiceEnabled: () async => true,
        checkPermission: () async => LocationPermission.denied,
        requestPermission: () async => LocationPermission.denied,
      );

      await expectLater(
        service.getCurrentPosition(),
        throwsA(
          isA<LocationException>().having(
            (error) => error.reason,
            'reason',
            LocationFailureReason.permissionDenied,
          ),
        ),
      );
    });

    test('throws when permission is permanently denied', () async {
      final service = LocationService(
        isLocationServiceEnabled: () async => true,
        checkPermission: () async => LocationPermission.deniedForever,
      );

      await expectLater(
        service.getCurrentPosition(),
        throwsA(
          isA<LocationException>().having(
            (error) => error.reason,
            'reason',
            LocationFailureReason.permissionDeniedForever,
          ),
        ),
      );
    });
  });
}

Future<Position> _fakeCurrentPosition({LocationSettings? locationSettings}) async {
  expect(locationSettings, isA<LocationSettings>());
  return Position(
    latitude: 8.9824,
    longitude: -79.5199,
    timestamp: DateTime(2026),
    accuracy: 8,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );
}
