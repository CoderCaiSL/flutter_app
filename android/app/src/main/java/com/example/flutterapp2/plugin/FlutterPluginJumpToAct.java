package com.example.flutterapp2.plugin;

import android.app.Activity;
import android.content.Intent;

import com.example.VideoPlayActivity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * 跳转原生activity
 */
public class FlutterPluginJumpToAct implements MethodChannel.MethodCallHandler {


    public static String CHANNEL = "jump/plugin";
    static MethodChannel channel;

    private Activity activity;

    private FlutterPluginJumpToAct(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new MethodChannel(registrar.messenger(), CHANNEL);
        FlutterPluginJumpToAct instance = new FlutterPluginJumpToAct(registrar.activity());
        //setMethodCallHandler在此通道上接收方法调用的回调
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall.method.equals("ACT")){
            //解析参数
            String text = methodCall.argument("flutter");
            //带参数跳转到指定Activity
            Intent intent = new Intent(activity, VideoPlayActivity.class);
            intent.putExtra("videoPath", text);
            activity.startActivity(intent);
            //返回给flutter的参数
            result.success("success");
        }else {
            result.notImplemented();
        }
    }
}
