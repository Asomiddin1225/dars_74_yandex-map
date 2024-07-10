







// import 'package:flutter/material.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

// class YandexMapService {
//   static Future<List<PolylineMapObject>> getDirection(
//     Point from,
//     Point to,
//   ) async {
//     final (drivingSession, drivingResultFuture) = await YandexDriving.requestRoutes(
//       points: [
//         RequestPoint(
//           point: from,
//           requestPointType: RequestPointType.wayPoint,
//         ),
//         RequestPoint(
//           point: to,
//           requestPointType: RequestPointType.wayPoint,
//         ),
//       ],
//       drivingOptions: const DrivingOptions(
//         initialAzimuth: 1,
//         routesCount: 2,
//         avoidTolls: true,
//       ),
//     );

//     final drivingResults = await drivingResultFuture;

//     if (drivingResults.error != null) {
//       print("Yo'lni ololmadi");
//       return [];
//     }

//     return drivingResults.routes!.map((route) {
//       return PolylineMapObject(
//         mapId: MapObjectId(UniqueKey().toString()),
//         polyline: route.geometry,
//         strokeColor: Colors.orange,
//         strokeWidth: 5,
//       );
//     }).toList();
//   }

//   static Future<String> searchPlace(Point location) async {
//     final (searchSession, searchResultFuture) = await YandexSearch.searchByPoint(
//       point: location,
//       searchOptions: const SearchOptions(
//         searchType: SearchType.geo,
//       ),
//     );

//     final searchResults = await searchResultFuture;

//     if (searchResults.error != null) {
//       print("Joylashuv nomini bilmadim");
//       return "Joy topilmadi";
//     }

//     print(searchResults.items?.first.toponymMetadata?.address.formattedAddress);

//     return searchResults.items!.first.name;
//   }
// }













//=============================================

import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:location/location.dart';

class LocationService {
  static final _location = Location();

  static bool _serviceEnabled = false;
  static PermissionStatus _permissionStatus = PermissionStatus.denied;
  static LocationData? currentLocation;

  static Future<void> init() async {
    await _checkService();
    if (_serviceEnabled) {
      await _checkPermission();
    }
  }

  static Future<void> _checkService() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }
  }

  static Future<void> _checkPermission() async {
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
    }
  }

  static Future<void> fetchCurrentLocation() async {
    if (_serviceEnabled && _permissionStatus == PermissionStatus.granted) {
      currentLocation = await _location.getLocation();
    }
  }

  static Stream<LocationData> fetchLiveLocation() async* {
    yield* _location.onLocationChanged;
  }

  static Future<List<Point>> getPolylines(Point from, Point to) async {
    // Implement the Yandex MapKit polyline fetching here.
    // Return a list of points that represent the polyline between from and to.
    return [];
  }

  static getPlaceDetails(String s) {
    // Implement Yandex Place details API
  }
}
