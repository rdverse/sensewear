import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';
import 'package:conditional_builder/conditional_builder.dart';
import 'dart:io';
import 'package:flutter_wear/mode.dart';
import 'package:flutter_wear/shape.dart';
import 'package:flutter_wear/wear_mode.dart';
import 'package:flutter_wear/wear_shape.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter_sensors_wearos/Home.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));


//
// Center(
// //image : AssetImage('images/sensor.jpg'),
// child: WearShape(
// builder: (context, shape) => WearMode(builder: (context, mode){
// return Container(
// color: Colors.black12,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children : <Widget>[
// Icon(Icons.ac_unit),
// RaisedButton.icon(
// icon : Icon(Icons.add_link
// ),
// label : Text('Sense'
// ),
// onPressed: () {
// print('button is clicked');
// },
// ),
// FloatingActionButton(
// onPressed: () {},
// child: Text('Cap'),
// backgroundColor: Color.alphaBlend(Colors.black, Colors.white),
// ),
// Row(),
// Text('Sensors zoo'
// ),
// ],
// ),
// );
// }),
// ),
// ),


// void main() => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   Color _containerColor;
//   Color _textColor;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _containerColor = Colors.white;
//     _textColor = Colors.black;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: WearShape(
//             builder: (context, shape) => WearMode(builder: (context, mode) {
//               if (mode == Mode.active) {
//                 _containerColor = Colors.white;
//                 _textColor = Colors.black;
//               } else {
//                 _containerColor = Colors.black;
//                 _textColor = Colors.white;
//               }
//               return Container(
//                 color: _containerColor,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Row(),
//                     FlutterLogo(size: 100),
//                     Text(
//                       'Shape: ${shape == Shape.round ? 'round' : 'square'}',
//                       style: TextStyle(color: _textColor),
//                     ),
//                     Text(
//                       'Mode: ${mode == Mode.active ? 'Active' : 'Ambient'}',
//                       style: TextStyle(color: _textColor),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }