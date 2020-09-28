// import 'dart:async';
// import 'package:path_provider/path_provider.dart';
// import 'package:csv/csv.dart';
// import 'dart:convert' show utf8;
// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'dart:isolate';
//
// Isolate isolate;
//
// class isolateDispatch {
//   Isolate isolate;
//   ReceivePort recievePort;
//   List<List<dynamic>> meanList;
//
//   isolateDispatch(){
//     this.recievePort = ReceivePort();
//   }
//
//   void createIsolate(){
//     Isolate.spawn(capturehome., recievePort.sendPort);
//
//
//   }
//
// }
//
//
// Future<String> get localPath async {
//   final dir = await getApplicationDocumentsDirectory();
//   return(dir.path);
// }
// //values, type
//
// void Write(SendPort sendPort) {
//   List<List<dynamic>> toStore = new List<List<dynamic>>();
//   // Initial a csv file and push this on top of that
//   //toStore.add(values);
//   toStore = values;
//   final directory =  await localPath;
//   String filename = '/';
//   filename = filename + DateTime.now().toString();
//   filename = filename + type;
//   filename = filename + ".csv";
//   final pathOfTheFileToWrite = directory + filename;
//   //  print(pathOfTheFileToWrite);
//   File file =   File(pathOfTheFileToWrite);
//   //   String csv = const ListToCsvConverter().convert(toStore);
//   //   file.writeAsString(csv);
//   //   uploadFile(pathOfTheFileToWrite, file);
//  // return(file);
// }
//
// Future uploadFile(fileName, csvFile) async {
//   StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
//   StorageUploadTask uploadTask = reference.putFile(csvFile);
//   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
// }
//
// void Read() async{
//   final directory =  await localPath;
//   final pathOfTheFileToWrite = directory + "/myFile.csv";
//   print(pathOfTheFileToWrite);
//   File file = File(pathOfTheFileToWrite);
//   final Stream<List> contents = await file.openRead();
//   contents
//       .transform(utf8.decoder)
//       .transform(new LineSplitter()).listen((String line) async {
//     await print('Contents are $line');
//   });
// }