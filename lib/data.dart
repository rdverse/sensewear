import 'package:sensors/sensors.dart';






class Sensors{
  List<double> accel;
  List<double> gyro;
  bool isCapturing = false;

  Sensors(this.accel, this.gyro);
  Sensors.setCap(this.isCapturing);

  void setVals(){
    accelerometerEvents.listen((AccelerometerEvent event) {
      accel = [event.x, event.y, event.z];
      print(event);
    });
// [AccelerometerEvent (x: 0.0, y: 9.8, z: 0.0)]

    gyroscopeEvents.listen((GyroscopeEvent event) {
      gyro = [event.x, event.y, event.z];
      print(event);
    });

// [GyroscopeEvent (x: 0.0, y: 0.0, z: 0.0)]
  }


  Future<void> captureFunction() async {

    while(isCapturing) {
      await Future.delayed(Duration.zero);
      //print('text');
      setVals();
    }


  }
}


