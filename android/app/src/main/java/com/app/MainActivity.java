package com.app.yase.yasepythonserver; 
import io.flutter.embedding.android.FlutterActivity; 
import android.os.Bundle; 
//import com.app.yase.yasepythonserver;

public class MainActivity extends FlutterActivity { 

   @Override 
   protected void onCreate(Bundle savedInstanceState) { 
       super.onCreate(savedInstanceState); 
       ServiceSrv.prepare(this); 
       ServiceSrv.start(this, ""); 
       }
   
   //needed if service is not foreground/sticky
   @Override
   protected void onResume () {
       ServiceSrv.start(this, "");
       super.onResume();
   }
} 