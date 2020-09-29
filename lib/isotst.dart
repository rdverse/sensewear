// // import 'dart:async';
// // import 'dart:io';
// // import 'dart:isolate';
// // import 'package:random_string/random_string.dart';
// //
// // class istst {
// //
// //   List<List<dynamic>> meanList;
// // List<String> testList;
// //   istst(){
// // meanList = List<List<dynamic>>();
// // testList = List<String>();
// //
// // }
// //   void createNewIsolate() {
// //     Isolate isolate;
// //     ReceivePort receivePort = ReceivePort();
// //     Isolate.spawn(isolateMain, receivePort.sendPort)
// //         .then((_isolate) {
// //       isolate = _isolate;
// //       print('isolate: $isolate');
// //       receivePort.listen((messages) {
// //         //Calculate mean
// //         this.testList.add(messages);
// //         //store in a list
// //
// //         //save csv if a condition is met
// //             //upload it to firebase
// //
// //         print('new message from ISOLATE ${this.testList}');
// //
// //       });
// //     });
// //   }
// //
// // }
// //
// //
// // void isolateMain(SendPort sendPort) {
// //   int i = 0;
// //   Timer.periodic(new Duration(seconds: 2), (Timer t) {
// //     if (i == 5) exit(0);
// //     i += 1;
// //     sendPort.send(
// //       'RANDOM STRING: ${randomString(10)}; RANDOM INTEGER: ${randomNumeric(
// //           10)}');
// //   });
// // }
// //
// // main() {
// //   istst iso = istst();
// //   print("running dart program");
// //   print('Start');
// //   iso.createNewIsolate();
// //   print("stop");
// // }
//
// void createNewIsolate() {
//
//   ReceivePort receivePort = ReceivePort();
//   Isolate.spawn(tryFunc, receivePort.sendPort)
//       .then((isolate) {
//     //isolate = isolate;
//     print('isolate: $isolate');
//     receivePort.listen((messages) {
//       //Calculate mean
//       List<double> meanVal = calcMean(messages);
//       //store in a list
//
//       meanAccelList.add(meanVal);
//       //save csv if a condition is met
//
//       if(meanAccelList.length==300){
//         Write(meanAccelList, "accel");
//       }
//       //upload it to firebase
//
//
//     });
//   });
// }
//
//
// void tryFunc(SendPort sendPort){
//   int count = 0;
//   List<List<dynamic>> meanAccelList = List<List<dynamic>>();
//   //   List<List<dynamic>> meanUserAccelList = List<List<dynamic>>();
//
//   var stwatch = new Stopwatch()..start();
//   List<StreamSubscription<dynamic>> _streamSubscriptions =
//   <StreamSubscription<dynamic>>[];
// //  WidgetsFlutterBinding.ensureInitialized();
//   _streamSubscriptions
//       .add(accelerometerEvents.listen((AccelerometerEvent event) { //setState(() {
//     List<double> _accelerometerValues =  <double>[event.x, event.y, event.z];
//
//     meanAccelList.add(_accelerometerValues);
//     count =  count+1;
//
//     if(count ==50){
//       print("$count");
//       //print("$stwatch.elapsedMilliseconds");
//       print("Need to reset the stopwatch now : ${stwatch.elapsedMilliseconds}");
//       //accelList.add(_accelerometerValues);
//       stwatch.reset();
//       print("Need to reset the stopwatch now : ${stwatch.elapsedMilliseconds}");
//       count =  0;
//     }
//     //check if it has been past 30 minutes , if so then
//     //    double present = getTime();
//     if(count == 5000) {
//       //  Write(accelList, "_accel");
//     }
//     sendPort.send(_accelerometerValues);
//
//     //});
//   }));
//
//
// }