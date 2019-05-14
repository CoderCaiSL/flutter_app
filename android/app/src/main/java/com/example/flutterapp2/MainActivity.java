package com.example.flutterapp2;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import com.example.flutterapp2.plugin.FlutterPluginGetDianl;
import com.example.flutterapp2.plugin.FlutterPluginJumpToAct;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {


  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    registerCustomPlugin(this);
  }
  private static void registerCustomPlugin(PluginRegistry registrar) {

    FlutterPluginJumpToAct.registerWith(registrar.registrarFor(FlutterPluginJumpToAct.CHANNEL));
    FlutterPluginGetDianl.registerWith(registrar.registrarFor(FlutterPluginGetDianl.CHANNEL));
  }

}
