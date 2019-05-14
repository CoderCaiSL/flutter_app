package com.example;

import android.app.Activity;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.ImageView;

import com.example.flutterapp2.R;

import cn.jzvd.Jzvd;
import cn.jzvd.JzvdStd;


public class VideoPlayActivity extends Activity {

    public String videoPath =  "";

    public JzvdStd jzvdStd ;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_video);
        videoPath = getIntent().getStringExtra("videoPath");
        jzvdStd = findViewById(R.id.jz_video);
        jzvdStd.setUp(videoPath
                , ""
                , Jzvd.SCREEN_WINDOW_NORMAL);
        jzvdStd.thumbImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
    }


    @Override
    protected void onDestroy() {
        super.onDestroy();
        JzvdStd.releaseAllVideos();
    }
}
