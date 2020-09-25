package io.flutter.plugins;
import android.app.Activity;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.support.wearable.view.WatchViewStub;
import android.util.Log;
import android.view.WindowManager;
import android.widget.TextView;

import androidx.annotation.NonNull;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import java.text.SimpleDateFormat;
import java.util.Calendar;
//
//public class MainActivity extends Activity implements SensorEventListener {
//
//    private static final String TAG = "MainActivity";
//    private TextView mTextViewStepCount;
//    private TextView mTextViewStepDetect;
//    private TextView mTextViewHeart;
//
////    @Override
////    protected void onCreate(Bundle savedInstanceState) {
////
////        // Keep the Wear screen always on (for testing only!)
////        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
////
////        super.onCreate(savedInstanceState);
////        setContentView(R.layout.activity_main);
////
////        final WatchViewStub stub = (WatchViewStub) findViewById(R.id.watch_view_stub);
////        stub.setOnLayoutInflatedListener(new WatchViewStub.OnLayoutInflatedListener() {
////            @Override
////            public void onLayoutInflated(WatchViewStub stub) {
////                mTextViewStepCount = (TextView) stub.findViewById(R.id.step_count);
////                mTextViewStepDetect = (TextView) stub.findViewById(R.id.step_detect);
////                mTextViewHeart = (TextView) stub.findViewById(R.id.heart);
////                getStepCount();
////            }
////        });
////    }
//
//    private void getStepCount() {
//        SensorManager mSensorManager = ((SensorManager)getSystemService(SENSOR_SERVICE));
//        Sensor mHeartRateSensor = mSensorManager.getDefaultSensor(Sensor.TYPE_HEART_RATE);
//        Sensor mStepCountSensor = mSensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER);
//        Sensor mStepDetectSensor = mSensorManager.getDefaultSensor(Sensor.TYPE_STEP_DETECTOR);
//
//        mSensorManager.registerListener(this, mHeartRateSensor, SensorManager.SENSOR_DELAY_NORMAL);
//        mSensorManager.registerListener(this, mStepCountSensor, SensorManager.SENSOR_DELAY_NORMAL);
//        mSensorManager.registerListener(this, mStepDetectSensor, SensorManager.SENSOR_DELAY_NORMAL);
//    }
//
//    private String currentTimeStr() {
//        Calendar c = Calendar.getInstance();
//        SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
//        return df.format(c.getTime());
//    }
//
//    public void onAccuracyChanged(Sensor sensor, int accuracy) {
//        Log.d(TAG, "onAccuracyChanged - accuracy: " + accuracy);
//    }
//
//    public void onSensorChanged(SensorEvent event) {
//        if (event.sensor.getType() == Sensor.TYPE_HEART_RATE) {
//            String msg = "" + (int)event.values[0];
//            mTextViewHeart.setText(msg);
//            Log.d(TAG, msg);
//        }
//        else if (event.sensor.getType() == Sensor.TYPE_STEP_COUNTER) {
//            String msg = "Count: " + (int)event.values[0];
//            mTextViewStepCount.setText(msg);
//            Log.d(TAG, msg);
//        }
//        else if (event.sensor.getType() == Sensor.TYPE_STEP_DETECTOR) {
//            String msg = "Detected at " + currentTimeStr();
//            mTextViewStepDetect.setText(msg);
//            Log.d(TAG, msg);
//        }
//        else
//            Log.d(TAG, "Unknown sensor type");
//    }
//
//}


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.flutter.javahr/heartrate";

    @Override
    protected void onCreate(Bundle savedINstancetate){
        super.onCreate(savedINstancetate);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall methodcall, @NonNull MethodChannel.Result result) {

                if(methodcall.method.equals("heartrate")){
                    result.success("Sucess from the java world");
                }

                else{
                    result.success("Failure on executing method function");
                }
            }
        });
    }

    }





