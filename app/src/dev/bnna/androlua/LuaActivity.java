package dev.bnna.androlua;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.Display;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import org.keplerproject.luajava.LuaState;
import org.keplerproject.luajava.LuaStateFactory;

import dev.bnna.androlua.utils.Constant;
import dev.bnna.androlua.utils.FileUtil;
import dev.bnna.androlua.utils.NetUtil;


public class LuaActivity extends Activity implements OnClickListener {

    private static final String TAG = LuaActivity.class.getSimpleName();
    // Lua解析和执行由此对象完成
	public LuaState mLuaState;
	public TextView mDisplay;
	public LinearLayout mLayout;
	public LinearLayout addLyout;

    public String zipFile = "lua.zip";
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.lua_main);
	
		mLuaState = LuaStateFactory.newLuaState();
		mLuaState.openLibs();
		initView();
        float scale = getResources().getDisplayMetrics().density;
        getDisplay();
    }

    private void getDisplay() {
        DisplayMetrics metrics = new DisplayMetrics();
        WindowManager WM = (WindowManager) this.getSystemService(Context.WINDOW_SERVICE);
        Display display = WM.getDefaultDisplay();
        display.getMetrics(metrics);
        int height = metrics.heightPixels; // 屏幕高
        int width = metrics.widthPixels; // 屏幕的宽
        float scale = getResources().getDisplayMetrics().density;


    }


    private void initView() {
		findViewById(R.id.main_btn_1).setOnClickListener(this);
		findViewById(R.id.main_btn_2).setOnClickListener(this);
		findViewById(R.id.main_btn_3).setOnClickListener(this);
		findViewById(R.id.main_btn_4).setOnClickListener(this);
		findViewById(R.id.main_btn_5).setOnClickListener(this);
        findViewById(R.id.main_btn_6).setOnClickListener(this);
        findViewById(R.id.main_btn_7).setOnClickListener(this);
        findViewById(R.id.main_btn_8).setOnClickListener(this);
        findViewById(R.id.main_btn_9).setOnClickListener(this);

//        PercentRelativeLayout
		mLayout = (LinearLayout) findViewById(R.id.layout);
        addLyout = (LinearLayout) findViewById(R.id.add_lyout);
		mDisplay = (TextView) mLayout.findViewById(R.id.display);

	}
	
	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		
		case R.id.main_btn_1:
            showImage();
//			runLuaScript();
			break;
		case R.id.main_btn_2:
//			runLuaFile();
            testImport();
			break;
		case R.id.main_btn_3:
			callAndroidAPI();
			break;
		case R.id.main_btn_4:
			launchSetting();
			break;
		case R.id.main_btn_5:
			launchActivity();
			break;
        case R.id.main_btn_6:
//            addButton();
            showButton();
            break;
        case R.id.main_btn_7:
            printLog("test from java");
        break;
        case R.id.main_btn_8:
            showText();
        break;
        case R.id.main_btn_9:
            getZipFile(zipFile);

        break;
	
		default:
			break;
		}
	}

    private void getZipFile(final String file) {
        new Thread(){
            @Override
            public void run() {
                super.run();
                NetUtil.downloadFile(file);

//                runOnUiThread(new Runnable() {
//                    @Override
//                    public void run() {
//
//                    }
//                });


            }
        }.start();

    }



    /**
	 * 运行lua脚本语句
	 */
	public void runLuaScript() {
		// 定义一个Lua变量
		mLuaState
				.LdoString(" varSay = 'This is string in lua script statement.'");
		// 获取
		mLuaState.getGlobal("varSay");
		// 输出
		mDisplay.setText(mLuaState.toString(-1));

	}

	/**
	 * 运行lua脚本文件
	 */
	public void runLuaFile() {
        // 读取文件
		mLuaState.LdoString(FileUtil.readStreamFromAssets(this,"file.lua"));
        // 查找方法
		mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "read_files");
        // 添加参数
        mLuaState.pushString("读取SDCard中的文件内容..");

		// read_files，一个返回结果
		int paramCount = 1;
		int resultCount = 1;
		mLuaState.call(paramCount, resultCount);
		// 将结果保存到resultKey中
		mLuaState.setField(LuaState.LUA_GLOBALSINDEX, "resultKey");
		// 获取
		mLuaState.getGlobal("resultKey");
		// 输出
		mDisplay.setText(mLuaState.toString(-1));
	}

	/**
	 * lua 调用 android api
	 * 
	 */
	public void callAndroidAPI() {
//		mLuaState.LdoString(FileUtil.readFile("test.lua"));
        mLuaState.LdoString(FileUtil.readStreamFromAssets(this,"test.lua"));
		// 找到functionInLuaFile函数
		mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "callAndroidApi");
		mLuaState.pushJavaObject(getApplicationContext());
		mLuaState.pushJavaObject(mLayout);
		mLuaState.pushString("设置到TextView的数据");
		mLuaState.call(3, 0);
	}

	/**
	 * 跳转到设置界面
	 */
	public void launchSetting() {

//		mLuaState.LdoString(FileUtil.readStream(getResources().openRawResource(
//				R.raw.test)));
        mLuaState.LdoString(FileUtil.readStreamFromAssets(this,"test.lua"));


        // 找到functionInLuaFile函数
		mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "launchSetting");
		mLuaState.pushJavaObject(getApplicationContext());
		mLuaState.call(1, 0);

	}

    public void testImport(){

                        mLuaState.LdoString(FileUtil.readStreamFromAssets(this,"testimport.lua"));
                        mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "showToast");
                        mLuaState.pushJavaObject(getApplicationContext());
                        mLuaState.call(1, 0);

    }

    /**
     * lua调用启动新界面方法
     */
	public void launchActivity() {

        mLuaState.LdoString(FileUtil.readStreamFromAssets(this,"test.lua"));
		// 通过Intent启动 浏览器
		//mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "launchIntent");

        // 启动Activity
		mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "launchActivity");


		mLuaState.pushJavaObject(getApplicationContext());
		mLuaState.call(1, 0);

	}

	/**
	 * lua添加按钮并给按钮设置监听,设置背景颜色，图片，调用toast
	 */
	public void addButton() {
		try {
			Button button = new Button(this);
			button.setBackgroundColor(Color.GREEN);
//			button.setBackgroundResource(resid);

			mLuaState.LdoString(FileUtil.readStreamFromAssets(this,"test.lua"));
			mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "addButton");

			mLuaState.pushJavaObject(getApplicationContext());// 第一个参数 context
			mLuaState.pushJavaObject(addLyout);// 第二个参数， Layout
			mLuaState.call(2, 0);// 2个参数，0个返回值

		} catch (Exception e) {
			e.printStackTrace();

		}
	}


    /**
     * 输出log日志
     * @param s string
     */
    private void printLog(String s) {
        mLuaState.LdoString(FileUtil.readStreamFromAssets(this,"log.lua"));
        mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "printlog");
        // 将参数压入栈
        mLuaState.pushString("from java");
        mLuaState.call(1, 0);
    }




    public void showImage(){
//
//        final String url = "http://f.hiphotos.baidu.com/image/w%3D2048/sign=3b06d28fc91349547e1eef6462769358/d000baa1cd11728b22c9e62ccafcc3cec2fd2cd3.jpg";
        new Thread(){
            @Override
            public void run() {
                super.run();

                final Bitmap bitmap = NetUtil.getBitmap(Constant.LOCAL_PATH+"girl.jpg");
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        ImageView img = (ImageView) findViewById(R.id.iv_img);
                        img.setImageBitmap(bitmap);
                    }
                });
            }
        }.start();

    }

    public void showText(){

        new Thread(){
            @Override
            public void run() {
                super.run();
                final String str =  NetUtil.getString(Constant.VIEW);
//                Log.e("lua",str);
                LuaActivity.this.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        mLuaState.LdoString(str);
                        mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "getHttpFromJava");
                        mLuaState.pushString("get result from http ");
                        mLuaState.call(1, 1);
                        mLuaState.setField(LuaState.LUA_GLOBALSINDEX, "resultKey");
                        mLuaState.getGlobal("resultKey");
                        mDisplay.setText(mLuaState.toString(-1));
                    }
                });
            }
        }.start();

    }

    public void showButton(){

        new Thread(){
            @Override
            public void run() {
                super.run();
//                final String str =  NetUtil.getString(Constant.TEST);
//                Log.e("lua",str);
                LuaActivity.this.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
//
                        try {
//
                            mLuaState.LdoString(FileUtil.readStreamFromAssets(getApplicationContext(),Constant.TEST));

                        mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "addButton");

                        mLuaState.pushJavaObject(getApplicationContext());// 第一个参数 context
                        mLuaState.pushJavaObject(addLyout);// 第二个参数， Layout
                        Bitmap bitmap = BitmapFactory.decodeResource(getResources(),R.drawable.icon);
                            Drawable drawable =new BitmapDrawable(bitmap);
                        mLuaState.pushJavaObject(drawable);
                        mLuaState.pushJavaObject(bitmap);
                        mLuaState.call(4, 0);// 2个参数，0个返回值
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                });
            }
        }.start();

    }








}
