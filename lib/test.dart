import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


void main() => runApp(MaterialApp(
  home: Test(),
));

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return(dir.path);
  }

  Future<File> Write() async{

    List<List<dynamic>> toStore = [[1,2],[3,4],[5,6]];
    // Initial a csv file and push this on top of that
    final directory =  await localPath;
    final pathOfTheFileToWrite = directory + "/myFile.csv";
    print(pathOfTheFileToWrite);
    File file =   File(pathOfTheFileToWrite);
    String csv =  const ListToCsvConverter().convert(toStore);
    file.writeAsString(csv);
    return(file);
  }

  void Read(file) async{
    final directory =  await localPath;
    final pathOfTheFileToWrite = directory + "/myFile.csv";
    print(pathOfTheFileToWrite);
    File file =   File(pathOfTheFileToWrite);
    final Stream<List> contents = await file.openRead();
    contents
        .transform(utf8.decoder)
        .transform(new LineSplitter()).listen((String line) async {
      await print('Contents are $line');
    });
  }


  @override
  Widget build(BuildContext context) {
    //Future<String> pathOfTheFileToWrite;
    Future<File> file;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : <Widget>[
            Container(
            child : FloatingActionButton(
                child: Text('Store'),
                onPressed: ()  {
                  setState(()  {
               file = Write();
              });
            }),
            ),
            Container(
              child: FloatingActionButton(
                  child: Text('Read'),
                  onPressed: (){
                    setState((){
                Read(file);
                });
              }),
            )
          ]
      )
  );
  }
}
