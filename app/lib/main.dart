import 'package:flutter/material.dart';
import 'package:gemini/routes.dart';

void main() {
  runApp(Routes());
}

//  import 'package:gemini/route.dart';

// // void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'GEMINI',
//       initialRoute: '/',
//       debugShowCheckedModeBanner: false,
//       onUnknownRoute: (RouteSettings setting) {
//         return new MaterialPageRoute(builder: (context) => PageNotFound());
//       },
      
//       onGenerateRoute: (RouteSettings settings) {
//         final args = settings.arguments;
//         return MaterialPageRoute(          
//           builder: (BuildContext context) => makeRoute(
//             context: context,
//             routeName: settings.name!,
//             arguments: args!,
//           ),
//           maintainState: true,
//           fullscreenDialog: false,
//         );
//       },
//     );
//   }
// }


