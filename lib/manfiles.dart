import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class manfiles extends StatefulWidget {
  @override
  _manfilesState createState() => _manfilesState();
}

class _manfilesState extends State<manfiles> {
  String status = "idle";
  Color capColor = Colors.deepOrangeAccent;
  Color backColor = Colors.white60;
  int fileCount = 0;

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      home: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(15, 200, 250, 0.8),
          title: Text(
            'Sensors Data',
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'BadScript'),
          ),
          centerTitle: true,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: new FloatingActionButton(
                        heroTag: "up",
                        child: Text("Upload"),
                        onPressed: () {
                          setState(() {
                            status = "upload";
                            handleFiles(status);
                          });
                        }),
                  ),
                  Container(
                    child: FloatingActionButton(
                        heroTag: "down",
                        child: Text("Erase"),
                        onPressed: () {
                          setState(() {
                            status = "erase";
                            handleFiles(status);
                          });
                        }),
                  ),
                  Container(
                    child: new FloatingActionButton(
                        heroTag: "list",
                        child: Text("List"),
                        onPressed: () {
                          setState(() {
                            status = "list";
                            handleFiles(status);
                          });
                        }),
                  ),
                ],
              ),
              Container(
                child: Text("Status : $status"),
              ),
              Container(
                child: RaisedButton(
                  child: Text("Back"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ]),
      ),
    ));
  }

  Future<Directory> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return (dir);
  }

  void handleFiles(action) async {
    fileCount = 0;
    final dir = await localPath;
    dir
        .list(recursive: true, followLinks: true)
        .listen((FileSystemEntity entity) {

      String fileName = entity.path;

      if (fileName.substring(fileName.length - 3) == "csv") {
        fileCount += 1;

        switch (action) {
          case "upload":
            {
              uploadFile(entity.path);
            }
            break;

          case "erase":
            {
              deleteFile(fileName);
            }
            break;

          case "list":
            {
              setState(() {
                status = fileCount.toString() + " files";
              });
            }
            break;
        }
      }
      else{
        if(fileCount==0){
          setState(() {
            status= "No files";
          });
        }
      }

    });
  }

  Future<void> uploadFile(fileName) async {
    File csvFile = File(fileName);
    fileName = "/backup" + fileName;
    final StorageReference reference =
        await FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = await reference.putFile(csvFile);
    }

  Future<void> deleteFile(fileName) async {
    print("file is deleted : $fileName");

    try {
      var file = File(fileName);

      if (await file.exists()) {
        await file.delete();
         print("file is deleted : $fileName");
      }
    } catch (e) {
      print(e);
    }
  }
}