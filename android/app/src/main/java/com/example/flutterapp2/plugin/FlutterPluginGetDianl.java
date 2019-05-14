package com.example.flutterapp2.plugin;

import android.app.Activity;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.util.Log;
import android.widget.Toast;

import com.example.flutterapp2.MainActivity;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import static android.content.Context.BATTERY_SERVICE;

public class FlutterPluginGetDianl implements MethodChannel.MethodCallHandler {

    public static String CHANNEL = "dianliang/plugin";

    static MethodChannel channel;

    private Activity activity;


    private FlutterPluginGetDianl(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new MethodChannel(registrar.messenger(), CHANNEL);
        FlutterPluginGetDianl instance = new FlutterPluginGetDianl(registrar.activity());
        //setMethodCallHandler在此通道上接收方法调用的回调
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall.method.equals("getBatteryLevel")) {
            int batteryLevel = getBatteryLevel();
            if (batteryLevel != -1) {
                Log.e("输出电量",batteryLevel+"");
                Toast.makeText(activity,"输出",Toast.LENGTH_LONG).show();
                result.success(batteryLevel);
            } else {
                result.error("UNAVAILABLE", "Battery level not available.", null);
            }
        }else {
            result.notImplemented();
        }

    }




    //获取电量
    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) activity.getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(activity.getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }
        return batteryLevel;
    }
}
