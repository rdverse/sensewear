package com.example.flutter_sensors_wearos
//
//import io.flutter.embedding.android.FlutterActivity
//
//class MainActivity: FlutterActivity() {
//}


//// Except the package name
//// Replace everything
//

import android.net.wifi.p2p.WifiP2pManager
import android.os.Bundle

import io.flutter.app.FlutterActivity
//import io.flutter.plugin.common.MethodChannel
//import io.flutter.plugins.GeneratedPluginRegistrant
i//mport io.flutter.embedding.engine.FlutterEngine

//import androidx.wear.ambient.AmbientMode

////import com.souvikbiswas.flutter_wear.FlutterAmbientCallback
////import com.souvikbiswas.flutter_wear.getChannel
//
class MainActivity: FlutterActivity() {
    //private val CHANNEL = "com.flutter.epic/test"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//    GeneratedPluginRegistrant.registerWith(this)
//        MethodChannel(flutterView,CHANNEL).setMethodCallHandler{
//            methodCall, result ->
//            val arguments = methodCall.arguments<Map<String, Any>>()
//
//            if(methodCall.method == "printy"){
//
//                var val1  = arguments["val1"]
//                if(val1 == "1"){
//                    result.success("Yaaaaaay")
//                } else {
//                    result.success("Naaaaaaaay")
//                }
//
//                result.success("Inside the Kothlin")
//            }
//        }

    }

    }


//
//import androidx.annotation.NonNull;
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugins.GeneratedPluginRegistrant
//
//class MainActivity: FlutterActivity() {
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine);




//package com.mjohnsullivan.flutterwear.wearexample

//import android.os.Bundle
//
//import io.flutter.app.FlutterActivity
//import io.flutter.plugins.GeneratedPluginRegistrant
//
//import android.support.wear.ambient.AmbientMode
//
//import com.mjohnsullivan.flutterwear.wear.FlutterAmbientCallback
//import com.mjohnsullivan.flutterwear.wear.getChannel
//
//class MainActivity: FlutterActivity(), AmbientMode.AmbientCallbackProvider {
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        GeneratedPluginRegistrant.registerWith(this)
//
//        // Wire up the activity for ambient callbacks
//        AmbientMode.attachAmbientSupport(this)
//    }
//
//    override fun getAmbientCallback(): AmbientMode.AmbientCallback {
//        return FlutterAmbientCallback(getChannel(flutterView))
//    }
//}