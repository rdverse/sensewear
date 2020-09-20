// import 'package:flutter/material.dart';
// import 'package:flutter_wear/flutter_wear.dart';
// import 'package:flutter_wear/mode.dart';
// import 'package:flutter_wear/shape.dart';
// import 'package:flutter_wear/wear_mode.dart';
// import 'package:flutter_wear/wear_shape.dart';
// import 'package:ppg/ppg.dart';
// import 'package:flutter/foundation.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
//
//
// class _MyAppState extends State<MyApp> {
//   Color _containerColor;
//   Color _textColor;
//   List<double> _ppgValues;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     _containerColor = Colors.white;
//     _textColor = Colors.black;
//     ppgEvents.listen((PPGEvent event) {
//       _ppgValues = event.x;
//     });
//     }
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
//                     FlutterLogo(size: 150),
//
//                     Text(
//                       'Shape: ${shape == Shape.round ? _ppgValues : 'square'}',
//                       style: TextStyle(color: _textColor),
//                     ),
//                     Text(
//                       'Mode: ${mode == Mode.active ? 'Active' : 'Ambient'}',
//                       style: TextStyle(color: _textColor),
//                     ),
//                 ],
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
//


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


import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veepoo_sdk/model/ecg_data.dart';
import 'package:veepoo_sdk/model/hr_data.dart';
import 'package:veepoo_sdk/model/origin_v3_data.dart';
import 'package:veepoo_sdk/model/search_result.dart';
import 'package:veepoo_sdk/model/sleep_data.dart';
import 'package:veepoo_sdk/model/spo2h_data.dart';
import 'package:veepoo_sdk/model/spo2h_origin_data.dart';
import 'package:veepoo_sdk/veepoo_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<SearchResult> listDevice = new List<SearchResult>();
  bool isScanning = false;
  int connectStatus = 0;

  String _hrValue = "HR: N/a";
  String _spo2Value = "SPO2: N/a";
  String _process = "Loading: --";

  @override
  void initState() {
    super.initState();

    VeepooSdk.eventChannel()
        .receiveBroadcastStream()
        .listen(_onEvent, onError: _onError);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Veepoo SDK example'),
          ),
          body: Column(
            children: <Widget>[
              buildConnectStatus(context),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text('ReScan'),
                    onPressed: _onRefresh,
                  ),
                  RaisedButton(
                    child: Text('QConnect'),
                    onPressed: _quickConnect,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text('Disconnect'),
                    onPressed: _disconnect,
                  ),
                  RaisedButton(
                    child: Text('Auth'),
                    onPressed: _bind,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text('HR start'),
                    onPressed: _startDetectHeart,
                  ),
                  RaisedButton(
                    child: Text('HR stop'),
                    onPressed: _stopDetectHeart,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text('SPO2 start'),
                    onPressed: _startDetectSPO2H,
                  ),
                  RaisedButton(
                    child: Text('SPO2 stop'),
                    onPressed: _stopDetectSPO2H,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text('Set info'),
                    onPressed: _syncPersonInfo,
                  ),
                  RaisedButton(
                    child: Text('TEST'),
                    onPressed: _sdkTest,
                  ),
                  RaisedButton(
                    child: Text('readOriginData'),
                    onPressed: _readOriginData,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text('readSleepData'),
                    onPressed: _readSleepData,
                  ),
                  RaisedButton(
                    child: Text('readSpo2hOrigin'),
                    onPressed: _readSpo2hOrigin,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text('t'),
                    onPressed: _dummyTest,
                  ),
                ],
              ),
              Text('Health data'),
              Text(_hrValue),
              Text(_spo2Value),
              Text(_process),
              Text('Device list'),
              new Expanded(
                child: createListView(context),
              )
            ],
          ),
        ));
  }

  Widget buildConnectStatus(BuildContext context) {
    if (connectStatus == 0) {
      return Text("Disconnected");
    } else if (connectStatus == 1) {
      return Text("Connected");
    } else {
      return Text("Connecting");
    }
  }

  Widget createListView(BuildContext context) {
    if (isScanning) {
      return ListTile(title: Text('Scanning device...'));
    }

    if (listDevice.length < 1) {
      return ListTile(title: Text('No device found'));
    }

    return new ListView.builder(
      itemCount: listDevice.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(
                  "${listDevice[index].name} - ${listDevice[index].mac} - ${listDevice[index].rssi}"),
              onTap: () => onTapped(index),
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  Future<List<SearchResult>> startScanDevice() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      List<SearchResult> result = await VeepooSdk.scanDevice();

      setState(() {
        listDevice.addAll(result);
      });
    } on PlatformException {}

    setState(() {
      isScanning = false;
    });

    return listDevice;
  }

  void _onRefresh() {
    if (isScanning) {
      return;
    }

    setState(() {
      isScanning = true;
      listDevice.clear();
    });

    startScanDevice();
  }

  void onTapped(index) async {
    setState(() {
      connectStatus = 2;
    });

    bool isConnected = await VeepooSdk.connect(listDevice[index].mac);

    if (!isConnected) {
      setState(() {
        connectStatus = 0;
      });

      return;
    }

    await _bind();

    setState(() {
      connectStatus = 1;
    });
  }

  void _quickConnect() async {
//    bool status = await VeepooSdk.connect('F4:D1:24:B8:C5:48');
    bool status = await VeepooSdk.connect('F8:58:E7:56:7A:97');

    if (status) {
      _bind();
    }
  }

  void _disconnect() async {
    try {
      await VeepooSdk.disconnect();
    } catch (e) {
      print(e);
    }

    setState(() {
      connectStatus = 0;
    });
  }

  void _bind() {
    VeepooSdk.bind('0000', true);
  }

  void _startDetectHeart() async {
    await VeepooSdk.startDetectHeart();
  }

  void _stopDetectHeart() {
    VeepooSdk.stopDetectHeart();
  }

  void _startDetectSPO2H() async {
    await VeepooSdk.startDetectSPO2H();
  }

  void _stopDetectSPO2H() {
    VeepooSdk.stopDetectSPO2H();
  }

  void _syncPersonInfo() {
    VeepooSdk.syncPersonInfo(true, 170, 60, 24, 5000);
  }

  void _readOriginData() async {
    OriginV3Data originV3Data = await VeepooSdk.readOrigin3Data();
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxx');
    print(originV3Data.toJson());
    print(originV3Data.originData3s);
    print(originV3Data.hrvOriginData);
    print(originV3Data.spo2hOriginData);
    inspect(originV3Data);
//    List<OriginData> data = await VeepooSdk.readOriginData();
//
//    print(data.length);
//
//    data.forEach((element) {
//      print(element.toJson());
//    });
  }

  void _readSpo2hOrigin() async {
    List<Spo2hOriginData> data = await VeepooSdk.readSpo2hOrigin();

    data.forEach((element) {
      print(element.toJson());
    });
  }

  void _readSleepData() async {
    List<SleepData> sleepData = await VeepooSdk.readSleepData();

    print(sleepData);
    inspect(sleepData);
  }

  void _sdkTest() {
    VeepooSdk.sdkTest();
  }

  void _onEvent(Object event) {
    Map<String, dynamic> e = json.decode(event);

    String action = e["action"];

    if (action == "onSpO2HADataChange") {
      String rawJson = e["payload"];
      Spo2hData spo2hData = Spo2hData.fromJson(json.decode(rawJson));

      setState(() {
        _spo2Value = "SPO2: ${spo2hData.value}";
      });
    }
    if (action == "onHrDataChange") {
      String rawJson = e["payload"];
      HrData hrData = HrData.fromJson(json.decode(rawJson));

      setState(() {
        _hrValue = "HR: ${hrData.data}";
      });
    }
    if (action == "onReadOriginProgress") {
      String raw = e["payload"];

      setState(() {
        _process = "Process: ${raw}";
      });
    }
  }

  void _onError(Object error) {
    print(error);
  }

  void _dummyTest() async {
    List<EcgDetectResult> list = await VeepooSdk.readECGData();
    print(list);
    inspect(list);
//    VeepooSdk.dummyTest();
  }
}