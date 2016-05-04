package dev.bnna.androlua;

import android.app.Activity;
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
