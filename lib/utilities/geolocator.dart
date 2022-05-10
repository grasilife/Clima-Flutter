import 'package:geolocator/geolocator.dart';

final List<PositionItem> positionItems = <PositionItem>[];
final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
const String kLocationServicesDisabledMessage =
    'Location services are disabled.';
const String kPermissionDeniedMessage = 'Permission denied.';
const String kPermissionDeniedForeverMessage = 'Permission denied forever.';
const String kPermissionGrantedMessage = 'Permission granted.';
enum PositionItemType {
  log,
  position,
}

class PositionItem {
  PositionItem(this.type, this.displayValue);

  final PositionItemType type;
  final String displayValue;
}

void updatePositionList(PositionItemType type, String displayValue) {
  positionItems.add(PositionItem(type, displayValue));
}

Future<bool> handlePermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    updatePositionList(
      PositionItemType.log,
      kLocationServicesDisabledMessage,
    );

    return false;
  }

  permission = await geolocatorPlatform.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await geolocatorPlatform.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      updatePositionList(
        PositionItemType.log,
        kPermissionDeniedMessage,
      );

      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    updatePositionList(
      PositionItemType.log,
      kPermissionDeniedForeverMessage,
    );

    return false;
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  updatePositionList(
    PositionItemType.log,
    kPermissionGrantedMessage,
  );
  return true;
}

class Location {
  double latitude;
  double longitude;
  Future<void> getCurrentLoacation() async {
    final hasPermission = await handlePermission();
    if (!hasPermission) {
      return;
    }
    Position position = await geolocatorPlatform.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;
  }
}
