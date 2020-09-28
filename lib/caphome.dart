import 'package:flutter/material.dart';
//import 'package:sensewear/dispatcher.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'dart:convert' show utf8;
import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:isolate';


class capturehome extends StatefulWidget {
  @override
  _capturehomeState createState() => _capturehomeState();
}


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
                    dispose();
                  });
                },
                child: Text('Stop'),

              ),
            ),
          ],
        ),
          //Display the text here




          if(_accelerometerValues!=null)
            Text("accel: x: ${_accelerometerValues
                .map((e) => e.toInt())
                .toList()
                .sublist(0,3)}"),

        ]
    ),
    ),

  )
  );//return
  } //build

  List<double> calcMean(List<List<dynamic>>findMean){
    var t = findMean.map((element) => element[0]).toList();
    var x = findMean.map((element) => element[1]).toList();
    var y = findMean.map((element) => element[2]).toList();
    var z = findMean.map((element) => element[3]).toList();
    
    double tval = t.reduce((curr, next) => curr+next)/t.length;
    double xval = x.reduce((curr, next) => curr+next)/x.length;
    double yval = y.reduce((curr, next) => curr+next)/y.length;
    double zval = z.reduce((curr, next) => curr+next)/z.length;

    List<double> meanVal = [tval, xval, yval, zval];
    print(meanVal);
    return(meanVal);
  }

  
  void createNewIsolate() {

    ReceivePort receivePort = ReceivePort();
    Isolate.spawn(tryFunc, receivePort.sendPort)
        .then((isolate) {
      //isolate = isolate;
      print('isolate: $isolate');
      receivePort.listen((messages) {
        //Calculate mean
        List<double> meanVal = calcMean(messages);
        //store in a list

        meanAccelList.add(meanVal);
        //save csv if a condition is met

        if(meanAccelList.length==300){
          Write(meanAccelList, "accel");
        }
        //upload it to firebase
        

      });
    });
  }
  
  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
 
  void beginInitState() {
    int count = 0;
   List<List<dynamic>> meanAccelList = List<List<dynamic>>();
 //   List<List<dynamic>> meanUserAccelList = List<List<dynamic>>();

   var stwatch = new Stopwatch()..start();

   this._streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        this._accelerometerValues =  <double>[getTime(),event.x, event.y, event.z];

         meanAccelList.add(_accelerometerValues);
        // print(meanAccelList);
        count =  count+1;
      //  sendPort.send(_accelerometerValues);

        if(count ==50){
           print("$count");
           //print("$stwatch.elapsedMilliseconds");
           print("Need to reset the stopwatch now : ${stwatch.elapsedMilliseconds}");
           //accelList.add(_accelerometerValues);
           List<double> meanVal = calcMean(meanAccelList);
           stwatch.reset();
           //print("Need to reset the stopwatch now : ${meanVal.toString()}");
          count =  0;
         // meanAccelList = List<List<dynamic>>();
        }
        print("${meanAccelList.length}");
        if(meanAccelList.length==10){
          Write(meanAccelList, "accel");
        }
        //check if it has been past 30 minutes , if so then
    //    double present = getTime();
          if(count == 5000) {
          //  Write(accelList, "_accel");
          }
      });
    }));


    // _streamSubscriptions
    //     .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
    //   setState(()  {
    //
    //     this._userAccelerometerValues = <double>[event.x, event.y, event.z];
    //     _userAccelerometerValues.insert(0,DateTime.now()
    //         .millisecondsSinceEpoch
    //         .toDouble());
    //
    //     Timer.periodic(Duration(seconds : 1), (timer) {
    //       userAccelList.add(_userAccelerometerValues);
    //     });
    //     //printy();
    //     //check if it has been past 30 minutes , if so then
    //     double present = getTime();
    //
    //     if(getDiff(present, start)>26){
    //       Write(userAccelList, "_accel_cal");
    //     }
    //   });
    // }));
  }

  double getTime(){
    return(DateTime.now().millisecondsSinceEpoch.toDouble());
  }

  double getDiff(present,start){
    return((present-start)/60000);

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
       uploadFile(pathOfTheFileToWrite, file);
    // return(file);
  }

  Future uploadFile(fileName, csvFile) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(csvFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print("Upload complete for the file $fileName");
    });
  }




}//class

void tryFunc(SendPort sendPort){
  int count = 0;
  List<List<dynamic>> meanAccelList = List<List<dynamic>>();
  //   List<List<dynamic>> meanUserAccelList = List<List<dynamic>>();

  var stwatch = new Stopwatch()..start();
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];
//  WidgetsFlutterBinding.ensureInitialized();
  _streamSubscriptions
      .add(accelerometerEvents.listen((AccelerometerEvent event) { //setState(() {
      List<double> _accelerometerValues =  <double>[event.x, event.y, event.z];

      meanAccelList.add(_accelerometerValues);
      count =  count+1;

      if(count ==50){
        print("$count");
        //print("$stwatch.elapsedMilliseconds");
        print("Need to reset the stopwatch now : ${stwatch.elapsedMilliseconds}");
        //accelList.add(_accelerometerValues);
        stwatch.reset();
        print("Need to reset the stopwatch now : ${stwatch.elapsedMilliseconds}");
        count =  0;
      }
      //check if it has been past 30 minutes , if so then
      //    double present = getTime();
      if(count == 5000) {
        //  Write(accelList, "_accel");
      }
      sendPort.send(_accelerometerValues);

    //});
  }));


}