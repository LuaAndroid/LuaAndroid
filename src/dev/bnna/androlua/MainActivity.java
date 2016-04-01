package dev.bnna.androlua;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import org.keplerproject.luajava.JavaFunction;
import org.keplerproject.luajava.LuaException;
import org.keplerproject.luajava.LuaState;
import org.keplerproject.luajava.LuaStateFactory;
import dev.bnna.androlua.R;
import android.app.Activity;
import android.content.Intent;
import android.content.res.AssetManager;
import android.content.res.Resources;
import android.net.Uri;
import android.os.Bundle;
import android.util.*;
import android.os.Handler;
import android.text.method.ScrollingMovementMethod;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnLongClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity implements OnClickListener,
		OnLongClickListener {
	private final static int LISTEN_PORT = 3335;
	final StringBuilder output = new StringBuilder();

	Button execute;
	
	// public so we can play with these from Lua
	public TextView source;
	public TextView status;

	// Lua解析和执行由此对象完成
	public LuaState mLuaState;
	// 用于演示，显示数据
	private TextView mDisplay;
	// 用于演示
	private LinearLayout mLayout;
	Handler handler;
	ServerThread serverThread;
	

	private static byte[] readAll(InputStream input) throws Exception {
		ByteArrayOutputStream output = new ByteArrayOutputStream(4096);
		byte[] buffer = new byte[4096];
		int n = 0;
		while (-1 != (n = input.read(buffer))) {
			output.write(buffer, 0, n);
		}
		return output.toByteArray();
	}

	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);

		execute = (Button) findViewById(R.id.executeBtn);
		execute.setOnClickListener(this);

		source = (TextView) findViewById(R.id.source);
		source.setOnLongClickListener(this);
		source.setText("require 'import'\nprint(Math:sin(2.3))\n");

		status = (TextView) findViewById(R.id.statusText);
		status.setMovementMethod(ScrollingMovementMethod.getInstance());
		
//		mLuaState = LuaStateFactory.newLuaState();
//		mLuaState.openLibs();
		handler = new Handler();

		initLua();
	}

	private void initLua() {
		mLuaState = LuaStateFactory.newLuaState();
		mLuaState.openLibs();

		try {
			mLuaState.pushJavaObject(this);
			mLuaState.setGlobal("activity");

			JavaFunction print = new JavaFunction(mLuaState) {
				@Override
				public int execute() throws LuaException {
					for (int i = 2; i <= mLuaState.getTop(); i++) {
						int type = mLuaState.type(i);
						String stype = mLuaState.typeName(type);
						String val = null;
						if (stype.equals("userdata")) {
							Object obj = mLuaState.toJavaObject(i);
							if (obj != null)
								val = obj.toString();
						} else if (stype.equals("boolean")) {
							val = mLuaState.toBoolean(i) ? "true" : "false";
						} else {
							val = mLuaState.toString(i);
						}
						if (val == null)
							val = stype;						
						output.append(val);
						output.append("\t");
					}
					output.append("\n");					
					return 0;
				}
			};
			print.register("print");

			JavaFunction assetLoader = new JavaFunction(mLuaState) {
				@Override
				public int execute() throws LuaException {
					String name = mLuaState.toString(-1);

					AssetManager am = getAssets();
					try {
						InputStream is = am.open(name + ".lua");
						byte[] bytes = readAll(is);
						mLuaState.LloadBuffer(bytes, name);
						return 1;
					} catch (Exception e) {
						ByteArrayOutputStream os = new ByteArrayOutputStream();
						e.printStackTrace(new PrintStream(os));
						mLuaState.pushString("Cannot load module "+name+":\n"+os.toString());
						return 1;
					}
				}
			};
			
			mLuaState.getGlobal("package");            // package
			mLuaState.getField(-1, "loaders");         // package loaders
			int nLoaders = mLuaState.objLen(-1);       // package loaders
			
			mLuaState.pushJavaFunction(assetLoader);   // package loaders loader
			mLuaState.rawSetI(-2, nLoaders + 1);       // package loaders
			mLuaState.pop(1);                          // package
						
			mLuaState.getField(-1, "path");            // package path
			String customPath = getFilesDir() + "/?.lua";
			mLuaState.pushString(";" + customPath);    // package path custom
			mLuaState.concat(2);                       // package pathCustom
			mLuaState.setField(-2, "path");            // package
			mLuaState.pop(1);
		} catch (Exception e) {
			status.setText("Cannot override print");
		}
	}
	
	public void onClick(View v) {
		switch (v.getId()) {
		
		case R.id.executeBtn:
			executeBtn();
			break;


		default:
			break;
		}
		

	}

	private void executeBtn() {
		String src = source.getText().toString();
		status.setText("");
		try {
			String res = evalLua(src);
			status.append(res);
			status.append("Finished succesfully");
		} catch(LuaException e) {			
			Toast.makeText(this, e.getMessage(), Toast.LENGTH_LONG).show();			
		}
	}

	
	public void runStatement(View v) {

		// 定义一个Lua变量
		mLuaState
		.LdoString(" varSay = 'This is string in lua script statement.'");
		// 获取
		mLuaState.getGlobal("varSay");
		// 输出
		mDisplay.setText(mLuaState.toString(-1));

	}

	public void runFile(View v) {
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
	 * @param v
	 */
	public void callAndroidAPI(View v) {
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
	 * 读取lua脚本
	 * @param is
	 * @return
	 */
	private String readStream(InputStream is) {
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
	private void copyResourcesToLocal() {
		String name, sFileName;
		InputStream content;
		R.raw a = new R.raw();
		java.lang.reflect.Field[] t = R.raw.class.getFields();
		Resources resources = getResources();
		for (int i = 0; i < t.length; i++) {
			FileOutputStream fs = null;
			try {
				name = resources.getText(t[i].getInt(a)).toString();
				sFileName = name.substring(name.lastIndexOf('/') + 1, name
						.length());
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
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void addButton1(View v){
		try {
			mLuaState.LdoString(readStream(getResources().openRawResource(
					R.raw.test)));
			// 找到functionInLuaFile函数
			mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "addButton");
			mLuaState.pushJavaObject(getApplicationContext());// 第一个参数 context
			mLuaState.pushJavaObject(mLayout);//第二个参数， Layout
			mLuaState.call(2, 0);// 2个参数，0个返回值
		} catch (Exception e) {
			e.printStackTrace();

		}
		
	}
	
	/**
	 * 调用静态方法
	 * @param v
	 */
	public void launchIntent(View v){
	

			mLuaState.LdoString(readStream(getResources().openRawResource(
					R.raw.test)));
			// 找到functionInLuaFile函数
			mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "launchIntent");
			mLuaState.pushJavaObject(getApplicationContext());
			mLuaState.pushString("http://www.baidu.com");
			mLuaState.call(2, 0);
		Intent intent = new Intent();
		intent.setData(Uri.parse("http://www.baidu.com"));
	}
	
	/**
	 * 调用普通方法
	 * @param v
	 */
	public void launchActivity(View v){
		try {
			mLuaState.LdoString(readStream(getResources().openRawResource(
					R.raw.test)));
			// 找到functionInLuaFile函数
			mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "launchActivity");
			mLuaState.pushJavaObject(getApplicationContext());
			mLuaState.call(1, 0);
		} catch (Exception e) {
			e.printStackTrace();

		}
	}

	@Override
	protected void onResume() {
		super.onResume();
		serverThread = new ServerThread();
		serverThread.start();
	}

	@Override
	protected void onPause() {
		super.onPause();
		serverThread.stopped = true;
	}

	private class ServerThread extends Thread {
		public boolean stopped;

		@Override
		public void run() {
			stopped = false;
			try {
				ServerSocket server = new ServerSocket(LISTEN_PORT);
				show("Server started on port " + LISTEN_PORT);
				while (!stopped) {
					Socket client = server.accept();
					BufferedReader in = new BufferedReader(
							new InputStreamReader(client.getInputStream()));
					final PrintWriter out = new PrintWriter(client.getOutputStream());
					String line = null;
					while (!stopped && (line = in.readLine()) != null) {
						final String s = line.replace('\001', '\n');
						if (s.startsWith("--mod:")) {
							int i1 = s.indexOf(':'), i2 = s.indexOf('\n');
							String mod = s.substring(i1+1,i2); 
							String file = getFilesDir()+"/"+mod.replace('.', '/')+".lua";
							FileWriter fw = new FileWriter(file);
							fw.write(s);
							fw.close();	
							// package.loaded[mod] = nil
							mLuaState.getGlobal("package");
							mLuaState.getField(-1, "loaded");
							mLuaState.pushNil();
							mLuaState.setField(-2, mod);
							out.println("wrote " + file + "\n");
							out.flush();
						} else {
							handler.post(new Runnable() {
								public void run() {
									String res = safeEvalLua(s);
									res = res.replace('\n', '\001');
									out.println(res);
									out.flush();
								}
							});
						}
					}
				}
				server.close();
			} catch (Exception e) {
				show(e.toString());
			}
		}

		private void show(final String s) {
			handler.post(new Runnable() {
				public void run() {
					status.setText(s);
				}
			});
		}
	}	

	private String safeEvalLua(String src) {
		String res = null;	
		try {
			res = evalLua(src);
		} catch(LuaException e) {
			res = e.getMessage()+"\n";
		}
		return res;		
	}
	
	private String evalLua(String src) throws LuaException {
		mLuaState.setTop(0);
		int ok = mLuaState.LloadString(src);
		if (ok == 0) {
			mLuaState.getGlobal("debug");
			mLuaState.getField(-1, "traceback");
			mLuaState.remove(-2);
			mLuaState.insert(-2);
			ok = mLuaState.pcall(0, 0, -2);
			if (ok == 0) {				
				String res = output.toString();
				output.setLength(0);
				return res;
			}
		}
		throw new LuaException(errorReason(ok) + ": " + mLuaState.toString(-1));
		//return null;		
		
	}

	
	private String errorReason(int error) {
		switch (error) {
		case 4:
			return "Out of memory";
		case 3:
			return "Syntax error";
		case 2:
			return "Runtime error";
		case 1:
			return "Yield error";
		}
		return "Unknown error " + error;
	}

	public boolean onLongClick(View view) {
		source.setText("");
		return true;
	}
}