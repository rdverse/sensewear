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


void main() => runApp(MaterialApp(
  home: Home(),
));

class Storage{

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return(dir.path);
  }
  Future<File> get localFile async {
    final path = await localPath;
    return(File('$path'));
  }

  Future<String> readData() async {
    try{
      final file = await localFile;
      String body = await file.readAsString();
      return body;
    }
    catch(e){print('Error incurred in reading file $e');}
  }

  Future<File> writeData(String data) async{
    final file = await localFile;
    return(file.writeAsString("$data"));
  }
}



//Stateless widget cannot change over time
class Home extends StatefulWidget{
  //override is to redefine the build menthod
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Storage storage;
  Home({Key key, @required this.storage}) : super(key: key);
  Color capColor = Colors.deepOrangeAccent;
  Color backColor = Colors.black12;

  AccelerometerEvent accelEvent;
  StreamSubscription accelStSub;

  GyroscopeEvent gyroEvent;
  StreamSubscription gyroStSub;

  Future<File> file;

  //Timer _timer;

  @override void initState()  {
    // THis sets up the csv we need to store the sensor data
    super.initState();
    this.file =  getFile();
  }

  Future<File> getFile() async{
    final directory =  await getApplicationDocumentsDirectory();
    final pathOfTheFileToWrite = 'data/app' + "/myCsvFile.csv";
    print(pathOfTheFileToWrite);
    File file =  File(pathOfTheFileToWrite);
    return file;
  }

  void writeToCsv(file, accelList, gyroList) async {
    List<double> row;
    row = accelList.add(gyroList);
    List<List<dynamic>> rows  = List<List<dynamic>>();
    rows.add(row);
    String csv = const ListToCsvConverter().convert(rows);
    file.writeAsString(csv);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
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

                    backColor= Colors.greenAccent;
                    capColor = Colors.green;
                    //sensor.captureFunction();
                    if(accelStSub == null) {

                      gyroStSub = gyroscopeEvents.listen((GyroscopeEvent eveG) {
                        setState(() {
                          gyroEvent = eveG;
                          writeToCsv(file, [accelEvent.x, accelEvent.y, accelEvent.z], [gyroEvent.x, gyroEvent.y, gyroEvent.z]);
                        });});

                      accelStSub = accelerometerEvents.listen((AccelerometerEvent eveA) {
                        setState(() {
                          accelEvent = eveA;
                        });});
                      if(accelStSub.isPaused){
                        accelStSub.resume();
                        gyroStSub.resume();
                      }
                    }
                  });
                },
                child: Text('Start'),
              ),
            ),

            Container(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    //accel= accel - 500;
                    //gyro = gyro - 100;
                    //sensor.isCapturing = false;
                    backColor = Colors.deepOrangeAccent;
                    capColor = Colors.red;
                    accelStSub.pause();
                    gyroStSub.pause();
                      });

                },
                child: Text('Stop'),
              ),
            ),
          ],
        ),
          //Display the text here
      if(accelEvent!=null)
      Text("Accel : x: ${accelEvent.x.round()}, y: ${accelEvent.y.round()}, z: ${accelEvent.z.round()}"),
          if(gyroEvent!=null)
            Text("Gyro: x: ${gyroEvent.x.round()},y: ${gyroEvent.y.round()},z: ${gyroEvent.z.round()}"),


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