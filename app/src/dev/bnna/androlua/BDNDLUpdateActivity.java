package dev.bnna.androlua;

import android.app.Activity;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.drawable.ShapeDrawable;
import android.graphics.drawable.shapes.Shape;
import android.os.Bundle;
import android.os.SystemClock;

public class BDNDLUpdateActivity extends Activity {
    private long startTime;
    private long endTime;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_update);


        startTime = SystemClock.currentThreadTimeMillis();
    }

    @Override
    protected void onResume() {
        super.onResume();

        checkUpdate();
    }

    private void checkUpdate() {


        ShapeDrawable shapeDrawable = new ShapeDrawable();
        Shape s = new Shape() {
            @Override
            public void draw(Canvas canvas, Paint paint) {

            }
        };
        dynamicUpdate();

    }

    private void dynamicUpdate() {

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        endTime = System.currentTimeMillis();

    }
}
