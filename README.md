# sensewear

Application to stream accelerometer data on an android smartwatch.

## Current Issue

Accelelerometer sampling rate is getting effected when a "write to csv" function is called or during file upload to firebase.

## Fix 

Use different isolates and run parts of program on different threads.

