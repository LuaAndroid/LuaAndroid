package dev.bnna.androlua;

import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.keplerproject.luajava.LuaException;
import org.keplerproject.luajava.LuaObject;
import org.keplerproject.luajava.LuaState;
import org.keplerproject.luajava.LuaStateFactory;
import org.keplerproject.luajava.ObjPrint;
import org.keplerproject.luajava.Printable;

import android.app.Activity;
import android.content.res.Resources;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import dev.bnna.androlua.R;

public class LuaActivity extends Activity implements OnClickListener {

	// Lua解析和执行由此对象完成
	public LuaState mLuaState;
	public TextView mDisplay;
	public LinearLayout mLayout;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.lua_main);
	
		mLuaState = LuaStateFactory.newLuaState();
		mLuaState.openLibs();

		initView();
	}
	
	private void initView() {
		findViewById(R.id.main_btn_1).setOnClickListener(this);
		findViewById(R.id.main_btn_2).setOnClickListener(this);
		findViewById(R.id.main_btn_3).setOnClickListener(this);
		findViewById(R.id.main_btn_4).setOnClickListener(this);
		findViewById(R.id.main_btn_5).setOnClickListener(this);
        findViewById(R.id.main_btn_6).setOnClickListener(this);
        findViewById(R.id.main_btn_7).setOnClickListener(this);
		mLayout = (LinearLayout) findViewById(R.id.layout);
		mDisplay = (TextView) mLayout.findViewById(R.id.display);
	}
	
	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		
		case R.id.main_btn_1:
			runLuaScript();
			break;
		case R.id.main_btn_2:
			runLuaFile();
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
            addButton();
            break;
        case R.id.main_btn_7:
            printLog("test from java");
        break;
	
		default:
			break;
		}
	}

    /**
     * 输出log日志
     * @param s string
     */
    private void printLog(String s) {
        mLuaState.LdoString(readStream(getResources().openRawResource(
                R.raw.log)));


        mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "printlog");
        // 将参数压入栈
        mLuaState.pushString("from java");
        mLuaState.call(1, 0);
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
		mLuaState.LdoString(readStream(getResources().openRawResource(
				R.raw.test)));
		// 找到functionInLuaFile函数
		mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "functionInLuaFile");
		// 将参数压入栈
		mLuaState.pushString("从Java中传递的参数");
		// functionInLuaFile函数有一个参数，一个返回结果
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
		mLuaState.LdoString(readStream(getResources().openRawResource(
				R.raw.test)));
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
		mLuaState.LdoString(readStream(getResources().openRawResource(
				R.raw.test)));
		// 找到functionInLuaFile函数
		mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "launchSetting");
		mLuaState.pushJavaObject(getApplicationContext());
		mLuaState.call(1, 0);

	}

    /**
     * lua调用启动新界面方法
     */
	public void launchActivity() {
	
		mLuaState.LdoString(readStream(getResources().openRawResource(
				R.raw.test)));
		// 找到functionInLuaFile函数
		mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "launchIntent");
		mLuaState.pushJavaObject(getApplicationContext());
		mLuaState.call(1, 0);

	}

	/**
	 * lua添加按钮并给按钮设置监听,设置背景颜色，图片，调用toast
	 */
	public void addButton() {
		try {
			Button button = new Button(this);
			button.setBackgroundColor(Color.BLACK);
//			button.setBackgroundResource(resid);
			
			mLuaState.LdoString(readStream(getResources().openRawResource(
					R.raw.test)));
			mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "addButton");
			mLuaState.pushJavaObject(getApplicationContext());// 第一个参数 context
			mLuaState.pushJavaObject(mLayout);// 第二个参数， Layout
			mLuaState.call(2, 0);// 2个参数，0个返回值

		} catch (Exception e) {
			e.printStackTrace();

		}
	}

	/**
	 * 读取lua脚本
	 * 
	 * @param is
	 * @return
	 */
	public String readStream(InputStream is) {
		try {
			ByteArrayOutputStream bo = new ByteArrayOutputStream();
			int i = is.read();
			while (i != -1) {
				bo.write(i);
				i = is.read();
			}
			return bo.toString();
		} catch (IOException e) {
			Log.e("ReadStream", "读取文件流失败");
			return "";
		}
	}

	/**
	 * 将/res/raw下面的资源复制到 /data/data/applicaton.package.name/files
	 */
	public void copyResourcesToLocal() {
		String name, sFileName;
		InputStream content;
		R.raw a = new R.raw();
		java.lang.reflect.Field[] t = R.raw.class.getFields();
		Resources resources = getResources();
		for (int i = 0; i < t.length; i++) {
			FileOutputStream fs = null;
			try {
				name = resources.getText(t[i].getInt(a)).toString();
				sFileName = name.substring(name.lastIndexOf('/') + 1,
						name.length());
				content = getResources().openRawResource(t[i].getInt(a));

				// Copies script to internal memory only if changes were made
				sFileName = getApplicationContext().getFilesDir() + "/"
						+ sFileName;

				Log.d("Copy Raw File", "Copying from stream " + sFileName);
				content.reset();
				int bytesum = 0;
				int byteread = 0;
				fs = new FileOutputStream(sFileName);
				byte[] buffer = new byte[1024];
				while ((byteread = content.read(buffer)) != -1) {
					bytesum += byteread; // 字节数 文件大小
					System.out.println(bytesum);
					fs.write(buffer, 0, byteread);
				}
				fs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	
		
	

}
