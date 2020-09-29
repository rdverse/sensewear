import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_wear/flutter_wear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wear/mode.dart';
import 'package:flutter_wear/shape.dart';
import 'package:flutter_wear/wear_mode.dart';
import 'package:flutter_wear/wear_shape.dart';



void main() => runApp(MaterialApp(
  home: TestHome(),
));

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     title: 'Flutter Wear App',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     home: WatchScreen(),
//     debugShowCheckedModeBanner: false,
//   );
// }
//
// class WatchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     builder: (context, shape) => WearShape(
//
//         builder: (context, mode) =>
//         mode == Mode.active ? TestHome() : TestHome(),
//       ),
//
//   );
// }



class TestHome extends StatefulWidget {
  @override
  _TestHomeState createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> with WidgetsBindingObserver {
//Declare the constructor here to make this work


  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
@override
  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.paused:
        print("Paused");
        break;
      case AppLifecycleState.resumed:
        print("Resumed");
        break;
      case AppLifecycleState.inactive:
        print("inactive");
        break;
      case AppLifecycleState.detached:

        print("detached");
        break;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
