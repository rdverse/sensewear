import 'package:flutter/material.dart';
import 'package:flutter_wear/flutter_wear.dart';
import 'package:flutter_wear/mode.dart';
import 'package:flutter_wear/shape.dart';
import 'package:flutter_wear/wear_mode.dart';
import 'package:flutter_wear/wear_shape.dart';
import 'package:ppg/ppg.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  Color _containerColor;
  Color _textColor;
  List<double> _ppgValues;



  @override
  void initState() {
    super.initState();

    _containerColor = Colors.white;
    _textColor = Colors.black;
    ppgEvents.listen((PPGEvent event) {
      _ppgValues = event.x;
    });
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: WearShape(
            builder: (context, shape) => WearMode(builder: (context, mode) {
              if (mode == Mode.active) {
                _containerColor = Colors.white;
                _textColor = Colors.black;
              } else {
                _containerColor = Colors.black;
                _textColor = Colors.white;
              }
              return Container(
                color: _containerColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(),
                    FlutterLogo(size: 150),

                    Text(
                      'Shape: ${shape == Shape.round ? _ppgValues : 'square'}',
                      style: TextStyle(color: _textColor),
                    ),
                    Text(
                      'Mode: ${mode == Mode.active ? 'Active' : 'Ambient'}',
                      style: TextStyle(color: _textColor),
                    ),
                ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}



// ppgEvents.listen((PPGEvent event) {
// print(event);
// });
// [PPGEvent (x: [0.0, 0.0], t: 0.0)]

// hrEvents.listen((HREvent event) {
// print(event);
// });
// // [HREvent (x: 0.0, t: 0.0)]




// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

////////////////////////////////////

//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:sensors/sensors.dart';
//
// import 'snake.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sensors Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   static const int _snakeRows = 20;
//   static const int _snakeColumns = 20;
//   static const double _snakeCellSize = 10.0;
//
//   List<double> _accelerometerValues;
//   List<double> _userAccelerometerValues;
//   List<double> _gyroscopeValues;
//   List<StreamSubscription<dynamic>> _streamSubscriptions =
//   <StreamSubscription<dynamic>>[];
//
//   @override
//   Widget build(BuildContext context) {
//     final List<String> accelerometer =
//     _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
//     final List<String> gyroscope =
//     _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
//     final List<String> userAccelerometer = _userAccelerometerValues
//         ?.map((double v) => v.toStringAsFixed(1))
//         ?.toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sensor Example'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Center(
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 border: Border.all(width: 1.0, color: Colors.black38),
//               ),
//               child: SizedBox(
//                 height: _snakeRows * _snakeCellSize,
//                 width: _snakeColumns * _snakeCellSize,
//                 child: Snake(
//                   rows: _snakeRows,
//                   columns: _snakeColumns,
//                   cellSize: _snakeCellSize,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text('Accelerometer: $accelerometer'),
//               ],
//             ),
//             padding: const EdgeInsets.all(16.0),
//           ),
//           Padding(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text('UserAccelerometer: $userAccelerometer'),
//               ],
//             ),
//             padding: const EdgeInsets.all(16.0),
//           ),
//           Padding(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text('Gyroscope: $gyroscope'),
//               ],
//             ),
//             padding: const EdgeInsets.all(16.0),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
//       subscription.cancel();
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _streamSubscriptions
//         .add(accelerometerEvents.listen((AccelerometerEvent event) {
//       setState(() {
//         _accelerometerValues = <double>[event.x, event.y, event.z];
//       });
//     }));
//     _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
//       setState(() {
//         _gyroscopeValues = <double>[event.x, event.y, event.z];
//       });
//     }));
//     _streamSubscriptions
//         .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
//       setState(() {
//         _userAccelerometerValues = <double>[event.x, event.y, event.z];
//       });
//     }));
//   }
// }



//


