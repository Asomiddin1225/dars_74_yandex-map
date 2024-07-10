// import 'package:dars_74_yandex/screens/home_screen.dart';
// import 'package:flutter/material.dart';
// // import 'package:yandex_mapkit/yandex_mapkit.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeScreen()
//     );
//   }
// }

// import 'package:dars_74_yandex/models/location_view_model.dart';
// import 'package:dars_74_yandex/screens/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => LocationViewModel(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const HomeScreen(),
//     );
//   }
// }












//============================================




import 'package:dars_74_yandex/models/location_view_model.dart';
import 'package:dars_74_yandex/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen  (),
    );
  }
}
