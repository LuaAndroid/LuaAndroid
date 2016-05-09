package dev.bnna.androlua;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.support.percent.PercentLayoutHelper;
import android.support.percent.PercentRelativeLayout;
import android.util.AttributeSet;
import android.util.Log;
import android.util.Xml;
import android.view.Gravity;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import org.keplerproject.luajava.LuaState;
import org.keplerproject.luajava.LuaStateFactory;
import org.xmlpull.v1.XmlPullParser;

import java.io.IOException;

import dev.bnna.androlua.utils.Constant;
import dev.bnna.androlua.utils.FileUtil;
import dev.bnna.androlua.utils.NetUtil;

public class CustomViewActivity extends Activity {
    final int MARGIN = 10;
    public LuaState mLuaState;
    public static final String TAG = "Lua";
    private static final int TITLE = 1000;
    private static final int SUB_TITLE = 2000;
    public LinearLayout linearLayout;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

        setLuaView();

//        linearLayout.addView(rectHView(this,"电影",1000,"伦敦",R.drawable.icon,true));
//        linearLayout.addView(rectVView(this,"电影",2000,"伦敦",R.drawable.icon,true));
//        linearLayout.addView(rectPercentView(this,"电影",2000,"伦敦",R.drawable.icon,true));

//        setPercentView();
    }

    private void setLuaView() {
        setContentView(R.layout.customview_activity);
        long startTime = System.currentTimeMillis();
        mLuaState = LuaStateFactory.newLuaState();
        mLuaState.openLibs();

        linearLayout = (LinearLayout) this.findViewById(R.id.custom_view);

////        linearLayout.setOrientation(LinearLayout.HORIZONTAL);
        addLuaView(linearLayout, Constant.VIEW,"mainView");
        long endTime = System.currentTimeMillis();
        Log.e(TAG, "onCreate: "+(endTime-startTime));

    }

    public void luaButton(View v){
//        linearLayout.removeAllViews();
        addLuaView(linearLayout,Constant.VIEW,"rectView");

        Toast.makeText(CustomViewActivity.this, "luaButton", Toast.LENGTH_SHORT).show();


    }

    private void setPercentView() {
        setContentView(R.layout.percent_view);
        PercentRelativeLayout relativeLayout = (PercentRelativeLayout) findViewById(R.id.percentile_view);

        PercentRelativeLayout.LayoutParams layoutParams = (PercentRelativeLayout.LayoutParams) relativeLayout.getLayoutParams();

        PercentLayoutHelper.PercentLayoutInfo percentLayoutInfo = layoutParams.getPercentLayoutInfo();
        percentLayoutInfo.leftMarginPercent = 15 * 0.01f; //15 is the percentage value you want to set it to
        relativeLayout.setLayoutParams(layoutParams);
        relativeLayout.requestLayout();
        try {
            relativeLayout.addView(rectPercentView(this,"电影",2000,"伦敦",R.drawable.icon,true));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public void addLuaView(final LinearLayout linearLayout,final String path,final String function){
        long startTime = System.currentTimeMillis();
        new Thread(){
            @Override
            public void run() {
                super.run();


                final String str =  NetUtil.getString(path);
//

                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        if (str == null) {
                            mLuaState.LdoString(FileUtil.readStreamFromAssets(CustomViewActivity.this,"view.lua"));
                        }else {
                            mLuaState.LdoString(str);
                        }
                        mLuaState.getField(LuaState.LUA_GLOBALSINDEX,function);
                        mLuaState.pushJavaObject(getApplicationContext());// 第一个参数 context
                        mLuaState.pushJavaObject(linearLayout);// 第二个参数， Layout
                        mLuaState.call(2, 0);// 2个参数，0个返回值

                    }
                });
            }
        }.start();


        long endTime = System.currentTimeMillis();
        Log.e(TAG, "runOnUiThread: "+(endTime-startTime));

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


    /**
     * 豆腐块
     * @param context context
     * @param title
     * @param subTitle
     * @param icon
     * @param special
     */
    @SuppressWarnings("ResourceType")
    public RelativeLayout rectVView(Context context, String title,int titleId, String subTitle, int icon, boolean special){
        RelativeLayout relativeLayout = new RelativeLayout(context);
        relativeLayout.setBackgroundColor(Color.WHITE);
//        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(400,600);
        relativeLayout.setLayoutParams(layoutParams);
        TextView titleTv = new TextView(context);
        titleTv.setText(title);
        titleTv.setTextColor(Color.BLUE);
        titleTv.setId(titleId);

        layoutParams.addRule(RelativeLayout.ALIGN_LEFT);
        TextView subTitleTv = new TextView(context);
        int subTitleId = titleId + 100;
        subTitleTv.setText(subTitle);
        subTitleTv.setTextColor(Color.RED);
        layoutParams.addRule(RelativeLayout.BELOW,titleId);

        RelativeLayout.LayoutParams ivParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
        ImageView iconIv = new ImageView(context);

        iconIv.setImageResource(icon);
        ivParams.addRule(RelativeLayout.BELOW,subTitleId);
        ivParams.addRule(RelativeLayout.CENTER_VERTICAL);
        ivParams.addRule(RelativeLayout.ALIGN_LEFT);

        relativeLayout.addView(titleTv);
        relativeLayout.addView(subTitleTv,layoutParams);
        relativeLayout.addView(iconIv,ivParams);

        View view = new View(context);

        return relativeLayout;


    }

    public RelativeLayout rectHView(Context context, String title,int titleId, String subTitle, int icon, boolean special){
        RelativeLayout relativeLayout = new RelativeLayout(context);
        relativeLayout.setBackgroundColor(Color.WHITE);
//        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(500,500);
        relativeLayout.setLayoutParams(layoutParams);
        TextView titleTv = new TextView(context);
        titleTv.setText(title);
        titleTv.setTextColor(Color.BLUE);
        titleTv.setId(titleId);


        TextView subTitleTv = new TextView(context);
        subTitleTv.setText(subTitle);
        subTitleTv.setTextColor(Color.RED);
        layoutParams.addRule(RelativeLayout.BELOW,titleId);

        RelativeLayout.LayoutParams ivParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
        ImageView iconIv = new ImageView(context);

        iconIv.setImageResource(icon);
        ivParams.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
        ivParams.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);

        relativeLayout.addView(titleTv);
        relativeLayout.addView(subTitleTv,layoutParams);
        relativeLayout.addView(iconIv,ivParams);

        return relativeLayout;

    }

    public PercentRelativeLayout rectPercentView(Context context, String title,int titleId, String subTitle, int icon, boolean special) throws IOException {

//        XmlPullParser parser = Xml.newPullParser();
//        try {
//            parser.setInput(context.getAssets().open("percent_view.xml"), "UTF-8");// 设置数据源编码
//        } catch (XmlPullParserException e) {
//            e.printStackTrace();
//        }
        XmlPullParser parser = getResources().getXml(R.xml.attrs);
        AttributeSet attrs = Xml.asAttributeSet(parser);
        PercentRelativeLayout relativeLayout = new PercentRelativeLayout(context,attrs);
//        relativeLayout.setBackgroundColor(Color.WHITE);
//        PercentRelativeLayout.LayoutParams layoutParams = new PercentRelativeLayout.LayoutParams(100,100);
//        PercentRelativeLayout.LayoutParams layoutParams = new PercentRelativeLayout.LayoutParams(context,attrs);
//        relativeLayout.setLayoutParams(layoutParams);
//        TypedArray typeArray = context.obtainStyledAttributes(attrs,
//                R.styleable.PercentLayout_Layout);
//        layoutParams.setBaseAttributes(typeArray,50,50);
//PercentRelativeLayout relativeLayout = new PercentRelativeLayout(context);


 PercentRelativeLayout.LayoutParams params = (PercentRelativeLayout.LayoutParams) relativeLayout.getLayoutParams();
// This will currently return null, if it was not constructed from XML.
        PercentLayoutHelper.PercentLayoutInfo info = params.getPercentLayoutInfo();
        info.heightPercent = 0.60f;
        relativeLayout.requestLayout();

//        PercentRelativeLayout relativeLayout = new PercentRelativeLayout(context);
//        relativeLayout.setBackgroundColor(Color.WHITE);
//        PercentRelativeLayout.LayoutParams layoutParams = new PercentRelativeLayout.LayoutParams(500,500);
//        relativeLayout.setLayoutParams(layoutParams);
        // 百分比

//        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT,RelativeLayout.LayoutParams.WRAP_CONTENT);







//        layoutParams.addRule(PercentRelativeLayout);
        TextView titleTv = new TextView(context);
//        titleTv.set
        titleTv.setText(title);
        titleTv.setTextColor(Color.BLUE);
        titleTv.setId(titleId);
        titleTv.setBackgroundColor(Color.YELLOW);
        PercentRelativeLayout.LayoutParams tvPramas = new PercentRelativeLayout.LayoutParams(500,500);
//                (PercentRelativeLayout.LayoutParams) titleTv.getLayoutParams();
//
//        layoutParams.la
//        PercentLayoutHelper.PercentLayoutInfo info = layoutParams.getPercentLayoutInfo();
//        info.widthPercent = 0.80f;
//        info.heightPercent = 0.50f;
//        titleTv.requestLayout();


        TextView subTitleTv = new TextView(context);
        subTitleTv.setText(subTitle);
        subTitleTv.setTextColor(Color.RED);
        PercentRelativeLayout.LayoutParams subTitleTvParams = new PercentRelativeLayout.LayoutParams(PercentRelativeLayout.LayoutParams.WRAP_CONTENT,PercentRelativeLayout.LayoutParams.WRAP_CONTENT);
        subTitleTvParams.addRule(PercentRelativeLayout.BELOW,titleId);



        RelativeLayout.LayoutParams ivParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
        ImageView iconIv = new ImageView(context);

        iconIv.setImageResource(icon);
        ivParams.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
        ivParams.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);

//        relativeLayout.addView(titleTv,tvPramas);
//        relativeLayout.addView(subTitleTv,subTitleTvParams);
//        relativeLayout.addView(iconIv,ivParams);
//        relativeLayout.requestLayout();
        return relativeLayout;

    }


}
