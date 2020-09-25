//Stateless widget cannot change over time

import 'dart:ffi';

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
import 'dart:convert' show utf8;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:ppg/ppg.dart';
import 'package:flutter/services.dart';


class Home extends StatefulWidget{
  //override is to redefine the build menthod



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

 // static const platformk = const MethodChannel('com.flutter.epic/test');
 // static const platform = const MethodChannel("com.flutter.javahr/heartrate");

  Color capColor = Colors.deepOrangeAccent;
  Color backColor = Colors.black12;

  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  List<double> _ppgValues;
  double start = DateTime.now()
      .millisecondsSinceEpoch
      .toDouble();

  List<List<dynamic>> accelList = List<List<dynamic>>();
  List<List<dynamic>> gyroList = List<List<dynamic>>();
  List<List<dynamic>> userAccelList = List<List<dynamic>>();
  List<List<dynamic>> ppgList = List<List<dynamic>>();
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  File file;
  var sink;
  String pathOfTheFileToWrite;

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return(dir.path);
  }

  Future<File> Write(values, type) async{
    List<List<dynamic>> toStore = new List<List<dynamic>>();
    // Initial a csv file and push this on top of that
    //toStore.add(values);
    toStore = values;
    final directory =  await localPath;
    String filename = '/';
    filename = filename + DateTime.now().toString();
    filename = filename + type;

    final pathOfTheFileToWrite = directory + "/myFile.csv";
    print(pathOfTheFileToWrite);
    File file =   File(pathOfTheFileToWrite);
    String csv = const ListToCsvConverter().convert(toStore);
    file.writeAsString(csv);
    return(file);
  }

  void Read() async{
    final directory =  await localPath;
    final pathOfTheFileToWrite = directory + "/myFile.csv";
    print(pathOfTheFileToWrite);
    File file = File(pathOfTheFileToWrite);
    final Stream<List> contents = await file.openRead();
    contents
        .transform(utf8.decoder)
        .transform(new LineSplitter()).listen((String line) async {
      await print('Contents are $line');
    });
  }


  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
    _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> gyroscope =
    _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        ?.toList();

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
                      beginInitState();
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
                      Write(gyroList, "gyro");
                      Read();
                      dispose();
                    });
                  },
                  child: Text('Stop'),

                ),
              ),
            ],
          ),
            //Display the text here


            //Text("$HeartRate()"),
            if(_ppgValues!=null)
            Text("PPG :  ${_ppgValues
                .map((e) => e.toInt())
                .toList()}"),

            if(_gyroscopeValues!=null)
              Text("Gyro: x: ${_gyroscopeValues
                .map((e) => e.toInt())
                .toList()
                .sublist(1,4)}"),

          ]
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  void beginInitState() {
    // super.initState();
   // printy();
   // HeartRate();
    int counter = 0;
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() async{
        this._gyroscopeValues = <double>[event.x, event.y, event.z];
        _gyroscopeValues.insert(0,getTime());
        gyroList.add(_gyroscopeValues);
      //  printy();

        //check if it has been past 30 minutes , if so then
        double present = getTime();

        if(getDiff(present, start)>44){
            await Write(gyroList, "_gyro");
        }
        });
    }));

    this._streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() async{
        this._accelerometerValues = <double>[event.x, event.y, event.z];
        _accelerometerValues.insert(0,getTime());
        accelList.add(_accelerometerValues);
        //printy();
        //check if it has been past 30 minutes , if so then
        double present = getTime();

        if(getDiff(present, start)>30){
          await Write(accelList, "_accel");

        }
      });
    }));


    // this._streamSubscriptions
    //     .add(ppgEvents.listen((PPGEvent event) {
    //   setState(() {
    //     this._ppgValues = event.x;//<double>[event.x,event.t];
    //     _ppgValues.insert(0,DateTime.now()
    //         .millisecondsSinceEpoch
    //         .toDouble());
    //     ppgList.add(_ppgValues);
    //   });
    // }));


    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() async {
        this._userAccelerometerValues = <double>[event.x, event.y, event.z];
        _userAccelerometerValues.insert(0,DateTime.now()
            .millisecondsSinceEpoch
            .toDouble());
        userAccelList.add(_userAccelerometerValues);
        //printy();
        //check if it has been past 30 minutes , if so then
        double present = getTime();

        if(getDiff(present, start)>26){
          await Write(userAccelList, "_accel_cal");
        }
      });


         }));
  //  print('${this._streamSubscriptions}');
  }

  // void printy() async {
  //   String value;
  //   var sendMap = <String, dynamic> {
  //     "val1" : "1",
  //     "val2" : "2"
  //   };
  //
  //   try{
  //     value = await platformk.invokeMethod("printy", sendMap);
  //   } catch(e) {
  //     print(e);
  //   }
  // print(value);
  //
  // }
double getTime(){
    return(DateTime.now().millisecondsSinceEpoch.toDouble());
}

double getDiff(present,start){
  return((present-start)/60000);

}
  // void HeartRate() async {
  //   String value;
  //   try{
  //     value = await platform.invokeMethod("heartrate");
  //   } catch(e){
  //     print("$e");
  //   }
  //   print("$value");
  //    // return(value);
  // }


}
