


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
void main() => runApp(myApp());


class myApp extends StatefulWidget {

  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  StreamController<double> controller = StreamController<double>.broadcast();
  StreamSubscription streamSubscription;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demo for stream',
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                    child: Text('Sub'),
                    color: Colors.amber,
                    onPressed: () {
                      Stream stream  = controller.stream;
                      streamSubscription = stream.listen((value) {
                        print('value from the controller : $value');
                      });
                    }),
                MaterialButton(
                    color : Colors.blue,
                    child:Text('Rel'),
                    onPressed: (){
                      controller.add(12);
                    }),
                MaterialButton(
                    color : Colors.green,
                    child: Text('Unsub'),
                    onPressed: (){
                      streamSubscription?.cancel();
                    }
                    ),
                MaterialButton(color : Colors.purple,
                    child : Text('ManStream'),
                    onPressed: () async{
                    getDelayedRandomValues().listen((value){
                      print('Value from manual Subscriptions : $value');
                    });

                    }),
              ],
            ),
          ),
        )
    );
  }
   //Building manual streams
  Stream<double> getDelayedRandomValues() async* {
    var random = Random();
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield random.nextDouble();
    }
  }


}



