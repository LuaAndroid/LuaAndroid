package dev.bnna.androlua;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.view.Gravity;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import org.keplerproject.luajava.LuaState;
import org.keplerproject.luajava.LuaStateFactory;

public class CustomViewActivity extends Activity {
    final int MARGIN = 10;
    public LuaState mLuaState;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.customview_activity);
        mLuaState = LuaStateFactory.newLuaState();
        mLuaState.openLibs();

        LinearLayout linearLayout = (LinearLayout) this.findViewById(R.id.custom_view);
        addLuaView(linearLayout);




	}


    public void addLuaView(final LinearLayout linearLayout){

        new Thread(){
            @Override
            public void run() {
                super.run();
                final String str =  NetUtil.getString(Constant.VIEW);
//                Log.e("lua",str);
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        mLuaState.LdoString(str);
                        mLuaState.getField(LuaState.LUA_GLOBALSINDEX, "mainView");
                        mLuaState.pushJavaObject(getApplicationContext());// 第一个参数 context
                        mLuaState.pushJavaObject(linearLayout);// 第二个参数， Layout
                        mLuaState.call(2, 0);// 2个参数，0个返回值

                    }
                });
            }
        }.start();


    }
    public void showView(){



    }


    private LinearLayout mainView(Context context){
        LinearLayout linearLayout = new LinearLayout(context);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        linearLayout.setOrientation(LinearLayout.HORIZONTAL);
        linearLayout.setLayoutParams(layoutParams);


        linearLayout.addView(viewWithText(context,R.drawable.ic_choose_title,"会员抢购不限时","新辣道","Y81.5",R.drawable.ic_specials));
        linearLayout.addView(viewWithOneIcon(context,R.drawable.ic_store_title,"到店支付五折起",R.drawable.ic_store_pic));
        linearLayout.addView(viewWithOneIcon(context,R.drawable.ic_store_title,"到店支付五折起",R.drawable.ic_store_pic));


        return linearLayout;
    }


    /**
     * 包含特价的View
     * @param context context
     * @param titlePic 标题图片
     * @param subTitleText 副标题文本
     * @param specialTitle 特价标题
     * @param specialText 特价内容
     * @return
     */
    private LinearLayout viewWithText(Context context,int titlePic,String subTitleText,String specialTitle,String specialText,int specialTextPic){
        LinearLayout linearLayout = new LinearLayout(context);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT,1);
        layoutParams.gravity = Gravity.CENTER_HORIZONTAL;
        layoutParams.setMargins(MARGIN,MARGIN,MARGIN,MARGIN);


        linearLayout.setOrientation(LinearLayout.VERTICAL);
        linearLayout.setLayoutParams(layoutParams);
        linearLayout.setBackgroundColor(Color.LTGRAY);

        Bitmap bitmap = BitmapFactory.decodeFile(FileUtil.getSDCARDFilePath("icon.png"));
        // titlePic
        ImageView titleImg = new ImageView(context);
//        titleImg.setImageResource(titlePic);
        titleImg.setImageBitmap(bitmap);
        //subTitleText
        TextView subTitleTv = new TextView(context);
        subTitleTv.setText(subTitleText);
        subTitleTv.setTextColor(Color.BLACK);
        subTitleTv.setGravity(Gravity.CENTER_HORIZONTAL);


        //subTitleText
        TextView specialTitleTV = new TextView(context);
        specialTitleTV.setText(specialTitle);
        specialTitleTV.setTextColor(Color.BLACK);
        specialTitleTV.setGravity(Gravity.CENTER_HORIZONTAL);


        //subTitleText
        TextView specialTextTv = new TextView(context);
        specialTextTv.setText(specialText);
        specialTextTv.setTextColor(Color.RED);
        specialTextTv.setGravity(Gravity.CENTER_HORIZONTAL);

        Drawable drawable = context.getResources().getDrawable(specialTextPic);
        specialTextTv.setCompoundDrawablesWithIntrinsicBounds(null,null,drawable,null);

        drawable.setBounds(0, 0, drawable.getMinimumWidth(), drawable.getMinimumHeight());//必须设置图片大小，否则不显示
//        specialTextTv.setCompoundDrawables(null,null,drawable,null);

        specialTextTv.setGravity(Gravity.CENTER_HORIZONTAL);


        // add view
        linearLayout.addView(titleImg);
        linearLayout.addView(subTitleTv);
        linearLayout.addView(specialTitleTV);
        linearLayout.addView(specialTextTv);


        return linearLayout;
    }

    /**
     *  包含一个标题，一个副标题，一个主图的View
     * @param context context
     * @param titlePic 标题图片
     * @param subTitleText 副标题文本
     * @param mainPic 主图
     * @return
     */
    private LinearLayout viewWithOneIcon(Context context,int titlePic,String subTitleText,int mainPic){
        LinearLayout linearLayout = new LinearLayout(context);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT,1);
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        linearLayout.setGravity(Gravity.HORIZONTAL_GRAVITY_MASK);
        linearLayout.setLayoutParams(layoutParams);
        linearLayout.setBackgroundColor(Color.LTGRAY);
        layoutParams.setMargins(MARGIN,MARGIN,MARGIN,MARGIN);

        // titlePic
        ImageView titleImg = new ImageView(context);
        titleImg.setImageResource(titlePic);


        //subtitle
        TextView subTitleTv = new TextView(context);
        subTitleTv.setText(subTitleText);
        subTitleTv.setGravity(Gravity.CENTER_HORIZONTAL);
        //mainPic
        ImageView mainImg = new ImageView(context);
        mainImg.setImageResource(mainPic);


                linearLayout.addView(titleImg);
        linearLayout.addView(subTitleTv);
        linearLayout.addView(mainImg);


        return linearLayout;
    }





}
