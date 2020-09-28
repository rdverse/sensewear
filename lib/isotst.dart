// import 'dart:async';
// import 'dart:io';
// import 'dart:isolate';
// import 'package:random_string/random_string.dart';
//
// class istst {
//
//   List<List<dynamic>> meanList;
// List<String> testList;
//   istst(){
// meanList = List<List<dynamic>>();
// testList = List<String>();
//
// }
//   void createNewIsolate() {
//     Isolate isolate;
//     ReceivePort receivePort = ReceivePort();
//     Isolate.spawn(isolateMain, receivePort.sendPort)
//         .then((_isolate) {
//       isolate = _isolate;
//       print('isolate: $isolate');
//       receivePort.listen((messages) {
//         //Calculate mean
//         this.testList.add(messages);
//         //store in a list
//
//         //save csv if a condition is met
//             //upload it to firebase
//
//         print('new message from ISOLATE ${this.testList}');
//
//       });
//     });
//   }
//
// }
//
//
// void isolateMain(SendPort sendPort) {
//   int i = 0;
//   Timer.periodic(new Duration(seconds: 2), (Timer t) {
//     if (i == 5) exit(0);
//     i += 1;
//     sendPort.send(
//       'RANDOM STRING: ${randomString(10)}; RANDOM INTEGER: ${randomNumeric(
//           10)}');
//   });
// }
//
// main() {
//   istst iso = istst();
//   print("running dart program");
//   print('Start');
//   iso.createNewIsolate();
//   print("stop");
// }