// import 'package:flutter/material.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

// class LocationViewModel extends ChangeNotifier {
//   MapType _currentMapType = MapType.vector;

//   MapType get currentMapType => _currentMapType;

//   void changeMapType(MapType mapType) {
//     _currentMapType = mapType;
//     notifyListeners();
//   }
// }







import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationViewModel with ChangeNotifier {
  MapType _currentMapType = MapType.vector;

  MapType get currentMapType => _currentMapType;

  void changeMapType(MapType mapType) {
    _currentMapType = mapType;
    notifyListeners();
  }
}
