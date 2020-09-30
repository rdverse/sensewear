import 'package:flutter/material.dart';
//import 'package:sensewear/dispatcher.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'dart:convert' show utf8;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:isolate';

//import 'package:wakelock/wakelock.dart';

import 'package:wakelock/wakelock.dart';
import 'dart:math';


class capturehome extends StatefulWidget {
 // const capturehome({Key key}) : super(key: key);
  @override
  _capturehomeState createState() => _capturehomeState();
}

// Add Widget binding serveer to hour _capturehomestage
// initstate
// dispose
// didChangeAppLigecycleState



class _capturehomeState extends State<capturehome> {




  Isolate isolate;
  //Variables to initialize
  Color capColor = Colors.deepOrangeAccent;
  Color backColor = Colors.white60;

  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;

  double start = DateTime
                    .now()
                    .millisecondsSinceEpoch
                    .toDouble();

  List<List<dynamic>> accelList = List<List<dynamic>>();
  List<List<dynamic>> userAccelList = List<List<dynamic>>();

  List<List<dynamic>> meanAccelList = List<List<dynamic>>();
  List<List<dynamic>> meanUserAccelList = List<List<dynamic>>();


  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];
  // This widget is the root of your application.

  File file;
  var sink;
  String pathOfTheFileToWrite;

  @override
  Widget build(BuildContext context) {
  return(MaterialApp(
    home: Scaffold(
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
    body: Column(
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
                    //createNewIsolate();

                 //   Wakelock.enable();

                    Wakelock.enable();

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

                    backColor = Colors.deepOrangeAccent;
                    capColor = Colors.red;
               //     Read();
                 //   Wakelock.disable();
                    quitStream();
                  });
                },
                child: Text('Stop'),

              ),
            ),
          ],
        ),
          //Display the text here




          //
          // if(_accelerometerValues!=null)
          //   Text("accel: x: ${_accelerometerValues
          //       .map((e) => e.toInt())
          //       .toList()
          //       .sublist(0,3)}"),

        ]
    ),
    ),

  )
  );//return
  } //build



  List<double> calcMean(List<List<dynamic>>findMean){

    var x = findMean.map((element) => element[0]).toList();
    var y = findMean.map((element) => element[1]).toList();
    var z = findMean.map((element) => element[2]).toList();

    double xval = x.reduce((curr, next) => curr+next)/x.length;
    double yval = y.reduce((curr, next) => curr+next)/y.length;
    double zval = z.reduce((curr, next) => curr+next)/z.length;


    List<double> meanVal = [tval, xval, yval, zval];

    List<double> meanVal = [xval, yval, zval];
    print(meanVal);

    return(meanVal);
  }

  

  
  @override
  void quitStream() {
 //   super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  double getEuc(xyz){
    double res = pow(xyz[0], 2) + pow(xyz[1], 2) + pow(xyz[2], 2);
    res = sqrt(res);
    return(res);
  }

  void beginInitState() {
    int count = 0;

    int uploadCount = 0;
    int ucount = 0;
    int uuploadCount = 0;


    int ucount=0;
    int uuploadCount=0;

   List<List<dynamic>> meanAccelList = List<List<dynamic>>();

   var stwatch = new Stopwatch()..start();


   this._streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        this._accelerometerValues =  <double>[getTime(),event.x, event.y, event.z];

         meanAccelList.add(_accelerometerValues);
        count =  count+1;


        if(count ==50){
           print("$count");
           print("Need to reset the stopwatch now : ${stwatch.elapsedMilliseconds}");
           //accelList.add(_accelerometerValues);
           List<double> meanVal = calcMean(meanAccelList);
           stwatch.reset();
           accelList.add(meanVal);
           uploadCount = uploadCount+1;
          count =  0;
          meanAccelList = List<List<dynamic>>();
        }

        if(uploadCount==10){
          Write(accelList, "accel");
          accelList = List<List<dynamic>>();
          uploadCount=0;
        }
      });
    }));

    //
    // this._streamSubscriptions

   // this._streamSubscriptions
   //      .add(accelerometerEvents.listen((AccelerometerEvent event) {
   //    setState(() {
   //      this._accelerometerValues =  <double>[getTime(),event.x, event.y, event.z];
   //
   //       meanAccelList.add(_accelerometerValues);
   //      // print(meanAccelList);
   //      count =  count+1;
   //    //  sendPort.send(_accelerometerValues);
   //
   //      if(count ==50){
   //         print("$count");
   //         //print("$stwatch.elapsedMilliseconds");
   //         print("Need to reset the stopwatch now : ${stwatch.elapsedMilliseconds}");
   //         //accelList.add(_accelerometerValues);
   //         List<double> meanVal = calcMean(meanAccelList);
   //         stwatch.reset();
   //         //print("Need to reset the stopwatch now : ${meanVal.toString()}");
   //        count =  0;
   //       // meanAccelList = List<List<dynamic>>();
   //      }
   //      print("${meanAccelList.length}");
   //      if(meanAccelList.length==10){
   //        Write(meanAccelList, "accel");
   //      }
   //      //check if it has been past 30 minutes , if so then
   //  //    double present = getTime();
   //        if(count == 5000) {
   //        //  Write(accelList, "_accel");
   //        }
   //    });
   //  }));

    //
    // _streamSubscriptions
>>>>>>> revive
    //     .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
    //   setState(()  {
    //
    //     this._userAccelerometerValues = <double>[getTime(), event.x, event.y, event.z];
    //
    //     meanUserAccelList.add(_userAccelerometerValues);
    //     ucount =  ucount+1;
    //
    //
    //     if(ucount ==5){
    //       List<double> meanUserVal = calcMean(meanUserAccelList);
    //       stwatch.reset();
    //       userAccelList.add(meanUserVal);
    //       uuploadCount = uuploadCount+1;
    //       print(uuploadCount);
    //       ucount =  0;
    //       meanUserAccelList = List<List<dynamic>>();
    //     }
    //
    //     if(uuploadCount==1000 ){
    //       Write(userAccelList, "_user_accel");
    //       userAccelList = List<List<dynamic>>();
    //       uuploadCount=0;
    //     }
    //
    //   });
    // }));
<<<<<<< HEAD
=======
    this._streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(()  {

        this._userAccelerometerValues = <double>[getTime(), event.x, event.y, event.z];

        meanUserAccelList.add(_userAccelerometerValues);
        ucount =  ucount+1;


        if(ucount ==5){
          List<double> meanUserVal = calcMean(meanUserAccelList);
          stwatch.reset();
          //add time and resultant acceleration to the meanUserVal list
          meanUserVal.add(getEuc(meanUserVal));
          meanUserVal.insert(0, getTime());

          userAccelList.add(meanUserVal);

          uuploadCount = uuploadCount+1;
          print(uuploadCount);
          ucount =  0;
          meanUserAccelList = List<List<dynamic>>();
        }

        if(uuploadCount==1000 ){
          Write(userAccelList, "_user_accel");
          userAccelList = List<List<dynamic>>();
          uuploadCount=0;
        }
      });
    }));


>>>>>>> revive

  }

  double Resultant_Acc(){

  }


  double getTime(){
    return(DateTime.now().millisecondsSinceEpoch.toDouble());
  }

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return(dir.path);
  }
//values, type

  void Write(values, type) async {
    List<List<dynamic>> toStore = new List<List<dynamic>>();
    // Initial a csv file and push this on top of that
    //toStore.add(values);
    toStore = values;
    final directory =  await localPath;
    String filename = '/';
    filename = filename + DateTime.now().toString();
    filename = filename + type;
    filename = filename + ".csv";
    final pathOfTheFileToWrite = directory + filename;
    //  print(pathOfTheFileToWrite);
    File file =   File(pathOfTheFileToWrite);
       String csv = const ListToCsvConverter().convert(toStore);
       file.writeAsString(csv);
       uploadFile(filename, file);
    // return(file);
  }

  Future uploadFile(fileName, csvFile) async {
<<<<<<< HEAD
     fileName = "data" + fileName;
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(csvFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print("Upload complete for the file $fileName");
    });
=======
    final StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = reference.putFile(csvFile);
    // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // setState(() {
    //   print("Upload complete for the file $fileName");
    // });
>>>>>>> revive
  }

}//class

