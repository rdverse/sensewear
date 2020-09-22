import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

import 'package:flutter_wear/mode.dart';
import 'package:flutter_wear/shape.dart';
import 'package:flutter_wear/wear_mode.dart';
import 'package:flutter_wear/wear_shape.dart';


void main() => runApp(MaterialApp(
  home: Home(),
));

//Stateless widget cannot change over time
class Home extends StatefulWidget{
  //override is to redefine the build menthod
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int accel =0;
  int gyro = 0;
  bool isCapturing = false;
  List<double> accelList;
  List<double> gyroList;
  Color capColor = Colors.deepOrangeAccent;
  var sensor = new Sensors.setCap(false);
  AccelerometerEvent acceleration;
  StreamSubscription<AccelerometerEvent> _streamSubscription;
  List<StreamSubscription<dynamic>> _streamSubscriptions =   <StreamSubscription<dynamic>>[];
  Timer _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 200, 250, 0.8),
        title: Text('Sensors Data',
          style: TextStyle(color : Colors.black.withOpacity(0.8),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'BadScript'
          ),
        ),
        centerTitle: true,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Container(child: Text('Capture',
            style: TextStyle(fontWeight: FontWeight.bold
              ),
            ),
                padding: EdgeInsets.fromLTRB(3, 20, 3, 20),
                color: capColor,
              ),

            Container(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    accel+=1000;
                    gyro+=2000;
                    sensor.isCapturing = true;
                    capColor = Colors.greenAccent;
                    sensor.captureFunction();
                  });
                },
                child: Text('Start'),
              ),
            ),

            Container(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    accel= accel - 500;
                    gyro = gyro - 100;
                    sensor.isCapturing = false;
                    capColor = Colors.deepOrangeAccent;
                      });

                },
                child: Text('Stop'),
              ),
            ),
          ],
        ),
          //Display the text here
          Text("Accel : ${sensor.accel}"),
          Text("Gyro: ${sensor.gyro}"),
      ]
      ),
    );
  }
}



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