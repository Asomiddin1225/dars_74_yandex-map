// import 'package:dars_74_yandex/models/location_view_model.dart';
// import 'package:dars_74_yandex/services/yandex_services.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late YandexMapController mapController;
//   Point? myLocation;
//   List<Point> myPositions = [];
//   Set<MapObject> mapObjects = {};

//   void onMapCreated(YandexMapController controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }

//   void addMarker() async {
//     if (myLocation == null) return;

//     final markerId = MapObjectId(UniqueKey().toString());
//     mapObjects.add(
//       PlacemarkMapObject(
//         mapId: markerId,
//         point: myLocation!,
//         icon: PlacemarkIcon.single(
//           PlacemarkIconStyle(
//             image: BitmapDescriptor.fromAssetImage('assets/image.png'),
//             scale: 0.5,
//           ),
//         ),
//       ),
//     );

//     myPositions.add(myLocation!);

//     if (myPositions.length == 2) {
//       final polylines = await YandexMapService.getDirection(
//         myPositions[0],
//         myPositions[1],
//       );
//       mapObjects.addAll(polylines);
//     }

//     setState(() {});
//   }

//   void resetMarkers() {
//     mapObjects.clear();
//     myPositions.clear();
//     setState(() {});
//   }

//   void handlePlaceSelected(Point location) async {
//     final position =
//         Point(latitude: location.latitude, longitude: location.longitude);
//     mapController.moveCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: position, zoom: 15),
//       ),
//     );
//     setState(() {
//       myLocation = position;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var locationViewModel = context.watch<LocationViewModel>();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[300],
//         title: TextField(
//           onSubmitted: (query) async {
//             final result = await YandexMapService.searchPlace(query);
//             if (result != null) {
//               handlePlaceSelected(result);
//             }
//           },
//           decoration: InputDecoration(
//             hintText: "Manzil izlash...",
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide.none,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             contentPadding: EdgeInsets.all(16),
//           ),
//         ),
//         actions: [
//           IconButton(onPressed: () {}, icon: Icon(Icons.near_me_sharp)),
//           PopupMenuButton<MapType>(
//             onSelected: (MapType type) {
//               locationViewModel.changeMapType(type);
//             },
//             itemBuilder: (context) => [
//               PopupMenuItem(
//                 value: MapType.vector,
//                 child: Text("Normal Ko'rinish"),
//               ),
//               PopupMenuItem(
//                 value: MapType.satellite,
//                 child: Text("Satellite Ko'rinish"),
//               ),
//               PopupMenuItem(
//                 value: MapType.hybrid,
//                 child: Text("Hybrid Ko'rinish"),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           YandexMap(
//             onMapCreated: onMapCreated,
//             onCameraPositionChanged: (position, _, __) {
//               myLocation = position.target;
//               setState(() {});
//             },
//             mapObjects: mapObjects.toList(),
//           ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           FloatingActionButton(
//             onPressed: addMarker,
//             child: const Icon(Icons.add),
//           ),
//           SizedBox(height: 8),
//           FloatingActionButton(
//             onPressed: resetMarkers,
//             child: const Icon(Icons.refresh),
//           ),
//         ],
//       ),
//     );
//   }
// }

//=================================================

// import 'package:dars_74_yandex/services/yandex_services.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late YandexMapController mapController;
//   String currentLocationName = "";
//   List<MapObject> markers = [];
//   List<PolylineMapObject> polylines = [];
//   List<Point> positions = [];
//   Point? myLocation;
//   Point najotTalim = const Point(
//     latitude: 41.2856806,
//     longitude: 69.2034646,
//   );

//   void onMapCreated(YandexMapController controller) {
//     setState(() {
//       mapController = controller;

//       mapController.moveCamera(
//         animation: const MapAnimation(
//           type: MapAnimationType.smooth,
//           duration: 1,
//         ),
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: najotTalim,
//             zoom: 18,
//           ),
//         ),
//       );
//     });
//   }

//   void onCameraPositionChanged(
//     CameraPosition position,
//     CameraUpdateReason reason,
//     bool finish,
//   ) {
//     myLocation = position.target;
//     setState(() {});
//   }

//   void addMarker() async {
//     markers.add(
//       PlacemarkMapObject(
//         mapId: MapObjectId(UniqueKey().toString()),
//         point: myLocation!,
//         opacity: 1,
//         icon: PlacemarkIcon.single(
//           PlacemarkIconStyle(
//             image: BitmapDescriptor.fromAssetImage(
//               "assets/placemark.png",
//             ),
//             scale: 0.5,
//           ),
//         ),
//       ),
//     );

//     positions.add(myLocation!);

//     if (positions.length == 2) {
//       polylines = await YandexMapService.getDirection(
//         positions[0],
//         positions[1],
//       );
//     }

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(currentLocationName),
//         actions: [
//           Icon(Icons.navigation_outlined),
//           IconButton(
//             onPressed: () async {
//               currentLocationName =
//                   await YandexMapService.searchPlace(myLocation!);
//               setState(() {});
//             },
//             icon: const Icon(Icons.search),
//           ),
//           IconButton(
//             onPressed: () {
//               mapController.moveCamera(
//                 // animation: const MapAnimation(
//                 //   type: MapAnimationType.smooth,
//                 //   duration: 1,
//                 // ),
//                 CameraUpdate.zoomOut(),
//               );
//             },
//             icon: const Icon(Icons.remove_circle),
//           ),
//           IconButton(
//             onPressed: () {
//               mapController.moveCamera(
//                 // animation: const MapAnimation(
//                 //   type: MapAnimationType.smooth,
//                 //   duration: 1,
//                 // ),
//                 CameraUpdate.zoomIn(),
//               );
//             },
//             icon: const Icon(Icons.add_circle),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           YandexMap(
//             onMapCreated: onMapCreated,
//             onCameraPositionChanged: onCameraPositionChanged,
//             mapType: MapType.map,
//             mapObjects: [
//               PlacemarkMapObject(
//                 mapId: const MapObjectId("najotTalim"),
//                 point: najotTalim,
//                 opacity: 1,
//                 icon: PlacemarkIcon.single(
//                   PlacemarkIconStyle(
//                     image: BitmapDescriptor.fromAssetImage(
//                       "assets/placemark.png",
//                     ),
//                     scale: 0.5,
//                   ),
//                 ),
//               ),
//               ...markers,
//               PlacemarkMapObject(
//                 mapId: const MapObjectId("meningJoylashuvim"),
//                 point: myLocation ?? najotTalim,
//                 icon: PlacemarkIcon.single(
//                   PlacemarkIconStyle(
//                     image: BitmapDescriptor.fromAssetImage(
//                       "assets/bluemarker.png",
//                     ),
//                     scale: 0.5,
//                   ),
//                 ),
//               ),
//               PolylineMapObject(
//                 mapId: const MapObjectId("UydanNajotTalimgacha"),
//                 polyline: Polyline(
//                   points: [
//                     najotTalim,
//                     myLocation ?? najotTalim,
//                   ],
//                 ),
//               ),
//               ...polylines,
//             ],
//           ),
//           const Align(
//             child: Icon(
//               Icons.place,
//               size: 60,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: addMarker,
//         child: const Icon(Icons.add_location),
//       ),
//     );
//   }
// }

//================================================

// import 'package:dars_74_yandex/services/yandex_services.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late YandexMapController mapController;
//   String currentLocationName = "";
//   List<MapObject> markers = [];
//   List<PolylineMapObject> polylines = [];
//   List<Point> positions = [];
//   Point? myLocation;
//   Point najotTalim = const Point(
//     latitude: 41.2856806,
//     longitude: 69.2034646,
//   );

//   void onMapCreated(YandexMapController controller) {
//     setState(() {
//       mapController = controller;

//       mapController.moveCamera(
//         animation: const MapAnimation(
//           type: MapAnimationType.smooth,
//           duration: 1,
//         ),
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: najotTalim,
//             zoom: 18,
//           ),
//         ),
//       );
//     });
//   }

//   void onCameraPositionChanged(
//     CameraPosition position,
//     CameraUpdateReason reason,
//     bool finish,
//   ) {
//     myLocation = position.target;
//     setState(() {});
//   }

//   void addMarker() async {
//     markers.add(
//       PlacemarkMapObject(
//         mapId: MapObjectId(UniqueKey().toString()),
//         point: myLocation!,
//         opacity: 1,
//         icon: PlacemarkIcon.single(
//           PlacemarkIconStyle(
//             image: BitmapDescriptor.fromAssetImage(
//               "assets/placemark.png",
//             ),
//             scale: 0.5,
//           ),
//         ),
//       ),
//     );

//     positions.add(myLocation!);

//     if (positions.length == 2) {
//       polylines = await YandexMapService.getDirection(
//         positions[0],
//         positions[1],
//       );
//     }

//     setState(() {});
//   }

//   void resetMarkers() {
//     setState(() {
//       markers.clear();
//       polylines.clear();
//       positions.clear();
//     });
//   }

//   Future<void> searchCurrentLocation() async {
//     if (myLocation != null) {
//       currentLocationName = await YandexMapService.searchPlace(myLocation!);
//       setState(() {});
//     }
//   }

//   Future<void> showMyLocation() async {
//     if (myLocation != null) {
//       await mapController.moveCamera(
//         animation: const MapAnimation(
//           type: MapAnimationType.smooth,
//           duration: 1,
//         ),
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: myLocation!,
//             zoom: 18,
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(currentLocationName),
//         actions: [
//           IconButton(
//             onPressed: searchCurrentLocation,
//             icon: const Icon(Icons.search),
//           ),
//           IconButton(
//             onPressed: showMyLocation,
//             icon: const Icon(Icons.navigation_outlined),
//           ),
//           IconButton(
//             onPressed: () {
//               mapController.moveCamera(
//                 CameraUpdate.zoomOut(),
//               );
//             },
//             icon: const Icon(Icons.remove_circle),
//           ),
//           IconButton(
//             onPressed: () {
//               mapController.moveCamera(
//                 CameraUpdate.zoomIn(),
//               );
//             },
//             icon: const Icon(Icons.add_circle),
//           ),
//           IconButton(
//             onPressed: resetMarkers,
//             icon: const Icon(Icons.restart_alt),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           YandexMap(
//             onMapCreated: onMapCreated,
//             onCameraPositionChanged: onCameraPositionChanged,
//             mapType: MapType.map,
//             mapObjects: [
//               PlacemarkMapObject(
//                 mapId: const MapObjectId("najotTalim"),
//                 point: najotTalim,
//                 opacity: 1,
//                 icon: PlacemarkIcon.single(
//                   PlacemarkIconStyle(
//                     image: BitmapDescriptor.fromAssetImage(
//                       "assets/placemark.png",
//                     ),
//                     scale: 0.5,
//                   ),
//                 ),
//               ),
//               ...markers,
//               PlacemarkMapObject(
//                 mapId: const MapObjectId("meningJoylashuvim"),
//                 point: myLocation ?? najotTalim,
//                 icon: PlacemarkIcon.single(
//                   PlacemarkIconStyle(
//                     image: BitmapDescriptor.fromAssetImage(
//                       "assets/bluemarker.png",
//                     ),
//                     scale: 0.5,
//                   ),
//                 ),
//               ),
//               PolylineMapObject(
//                 mapId: const MapObjectId("UydanNajotTalimgacha"),
//                 polyline: Polyline(
//                   points: [
//                     najotTalim,
//                     myLocation ?? najotTalim,
//                   ],
//                 ),
//               ),
//               ...polylines,
//             ],
//           ),
//           const Align(
//             child: Icon(
//               Icons.place,
//               size: 60,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: addMarker,
//         child: const Icon(Icons.add_location),
//       ),
//     );
//   }
// }

//=====================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:location/location.dart';
import 'package:dars_74_yandex/models/location_view_model.dart';
import 'package:dars_74_yandex/services/yandex_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late YandexMapController mapController;
  LocationData? myLocation;

  Point najotTalim = Point(latitude: 41.2856806, longitude: 69.2034646);
  Point? meningJoylashuvim;
  List<Point> myPositions = [];
  List<PlacemarkMapObject> myMarkers = [];
  List<PolylineMapObject> polylines = [];

  void onMapCreated(YandexMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void onCameraMove(CameraPosition position) {
    meningJoylashuvim = position.target;
    setState(() {});
  }

  void addMarker() async {
    if (meningJoylashuvim == null) return;

    myMarkers.add(
      PlacemarkMapObject(
        mapId: MapObjectId(UniqueKey().toString()),
        point: meningJoylashuvim!,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/marker.png'),
        )),
      ),
    );

    myPositions.add(meningJoylashuvim!);

    if (myPositions.length == 2) {
      final points = await LocationService.getPolylines(
        myPositions[0],
        myPositions[1],
      );

      polylines.add(
        PolylineMapObject(
          mapId: MapObjectId(UniqueKey().toString()),
          polyline: Polyline(
            points: points,
            strokeColor: Colors.blue,
            strokeWidth: 5,
          ),
        ),
      );
    }

    setState(() {});
  }

  void resetMarkers() {
    myMarkers.clear();
    myPositions.clear();
    polylines.clear();
    setState(() {});
  }

  // void handlePlaceSelected(Prediction prediction) async {
  //   // Implement Yandex Place details API
  // }

  @override
  Widget build(BuildContext context) {
    var locationViewModel = context.watch<LocationViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text("Manzil izlash.."),
        actions: [
          PopupMenuButton<MapType>(
            onSelected: (MapType type) {
              locationViewModel.changeMapType(type);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MapType.vector,
                child: Text("Normal Ko'rinish"),
              ),
              PopupMenuItem(
                value: MapType.satellite,
                child: Text("Satellite Ko'rinish"),
              ),
              PopupMenuItem(
                value: MapType.hybrid,
                child: Text("Hybrid Ko'rinish"),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: onMapCreated,
            mapObjects: [
              PlacemarkMapObject(
                mapId: MapObjectId("MeningJoylashuvim"),
                point: meningJoylashuvim ?? najotTalim,
                icon: PlacemarkIcon.single(PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage('assets/marker.png'),
                )),
                opacity: 0.7,
                onTap: (PlacemarkMapObject self, Point point) {
                  print('Tapped me at $point');
                },
              ),
              ...myMarkers,
              // ...polylines,
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: addMarker,
            child: const Icon(Icons.add),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: resetMarkers,
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

class Polyline {
  final List<Point> points;
  final Color strokeColor;
  final double strokeWidth;

  Polyline({
    required this.points,
    required this.strokeColor,
    required this.strokeWidth,
  });
}

class PolylineMapObject {
  final MapObjectId mapId;
  final Polyline polyline;

  PolylineMapObject({
    required this.mapId,
    required this.polyline,
  });
}
