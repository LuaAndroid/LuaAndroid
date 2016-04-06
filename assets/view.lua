

Color = luajava.newInstance("android.graphics.Color")
drawableClazz = luajava.bindClass("dev.bnna.androlua.R$drawable")

null = nil
-- init tables
specials = {"特价优惠","海底捞","￥81","特价" }
titles = {"到店付五折起","狂享折上折" }
-- 获取本地图片
icDrawables = {drawableClazz.ic_choose_title,drawableClazz.ic_specials,
    drawableClazz.ic_store_title,drawableClazz.ic_store_pic,
    drawableClazz.ic_daily_title,drawableClazz.ic_daily_pic}



MARGIN = 0 

--icon_name={choose="ic_choose_title",special="ic_special",store_title="ic_store_title",store_pic="ic_store_pic",daily_title="ic_daily_title",daily_pic="ic_daily_pic"}

-- 添加的主要视图
function mainView(context,layout)
    -- 通过加载sdcard中的文件
    viewWithSpecials(context,layout,"/sdcard/lua/ic_choose_title.png",specials[1],specials[2],specials[3],icDrawables[2])

    --viewWithSpecials(context,layout,icDrawables[1],specials[1],specials[2],specials[3],icDrawables[2])
    viewWithText(context,layout,icDrawables[3],titles[1],icDrawables[4])
    viewWithText(context,layout,icDrawables[5],titles[2],icDrawables[6])
end

--printlog
function printlog(str)
    nmdebug.logd("lua log : "..str)
end

-- 特价item context,titlePic,subTitleText,specialTitle,specialText,specialTextPic
function viewWithSpecials(context,layout,titlePic,subTitleText,specialTitle,specialText,specialTextPic)
    local MARGIN = 10 
    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    -- local linearLayoutClazz = luajava.newInstance("android.widget.LinearLayout")
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.WRAP_CONTENT,1) 
    --local gravityClazz = luajava.bindClass("android.view.Gravity")
    -- local g =
    -- layoutParams.grativy = gravityClazz,gravityClazz.CENTER
    layoutParams:setMargins(MARGIN,MARGIN,MARGIN,MARGIN) 

    local linearLayoutClazz = luajava.bindClass("android.widget.LinearLayout")
    linearLayoutView:setOrientation(linearLayoutClazz.VERTICAL) 
    linearLayoutView:setLayoutParams(layoutParams) 
    linearLayoutView:setBackgroundColor(Color.LTGRAY) 


    --    titlePic
    local titleImg = luajava.newInstance("android.widget.ImageView",context)
    -- titleImg:setImageResource(titlePic)

--    通过
--    Bitmap bitmap = BitmapFactory.decodeFile(FileUtil.getFilePath("icon.png"));
    BitmapFactory  = luajava.bindClass("android.graphics.BitmapFactory")
    bitmap = BitmapFactory.decodeFile(BitmapFactory,titlePic)
    titleImg:setImageBitmap(bitmap)


    -- 特价
    local  subTitleTv = luajava.newInstance("android.widget.TextView",context)
    subTitleTv:setText(subTitleText) 
    subTitleTv:setTextColor(Color.BLACK) 
    subTitleTv:setGravity(1) 

    -- specialTitleTV
    local  specialTitleTV = luajava.newInstance("android.widget.TextView",context)
    specialTitleTV:setText(specialTitle) 
    specialTitleTV:setTextColor(Color.BLACK) 
    specialTitleTV:setGravity(1) 


    -- specialTextTv
    local  specialTextTv =luajava.newInstance("android.widget.TextView",context)
    specialTextTv:setText(specialText) 
    specialTextTv:setTextColor(Color.RED) 
    local drawable =  context:getResources():getDrawable(specialTextPic)
--    drawable:setBounds(0, 0, drawable:getMinimumWidth(), drawable:getMinimumHeight())
--    specialTextTv:setCompoundDrawables(nil,nil,drawable,nil);
    specialTextTv:setCompoundDrawablesWithIntrinsicBounds(nil,nil,drawable,nil)
    specialTextTv:setGravity(1) 

    --add view
    --    linearLayoutView:addView(viewWithSpecials(context,"1","会员不限时抢购","新辣道","￥81.5","1"))
    linearLayoutView:addView(titleImg) 
    linearLayoutView:addView(subTitleTv) 
    linearLayoutView:addView(specialTitleTV) 
    linearLayoutView:addView(specialTextTv) 
    layout:addView(linearLayoutView) 
end

-- contains two picture and one text
function viewWithText(context,layout,titleImg,subTitleText,mainImg)

    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    -- local linearLayoutClazz = luajava.newInstance("android.widget.LinearLayout")
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.WRAP_CONTENT,1) 
    --local gravityClazz = luajava.bindClass("android.view.Gravity")
    -- local g =
    -- layoutParams.grativy = gravityClazz,gravityClazz.CENTER 
    --layoutParams:setMargins(MARGIN,MARGIN,MARGIN,MARGIN) 

    local linearLayoutClazz = luajava.bindClass("android.widget.LinearLayout")
    linearLayoutView:setOrientation(linearLayoutClazz.VERTICAL) 
    linearLayoutView:setLayoutParams(layoutParams) 
    linearLayoutView:setBackgroundColor(Color.LTGRAY) 

    --  titlePic
    local  titleIv = luajava.newInstance("android.widget.ImageView",context)
    titleIv:setImageResource(titleImg) 

    --  subTitle
    local  subTitleTv = luajava.newInstance("android.widget.TextView",context)
    subTitleTv:setText(subTitleText) 
    subTitleTv:setTextColor(Color.BLACK) 
    subTitleTv:setGravity(1) 

    --  mainImg
    local  mainIv = luajava.newInstance("android.widget.ImageView",context)
    mainIv:setImageResource(mainImg)

    --add view
    linearLayoutView:addView(titleIv) 
    linearLayoutView:addView(subTitleTv) 
    linearLayoutView:addView(mainIv) 

    layout:addView(linearLayoutView) 
end


function getHttpFromJava(key)
    --HttpURLConnection conn = null;
    --URL myFileUrl = null;
--    url = luajava.bindClass("java.net.URL")
--    url1 = luajava.newInstance("java.net.URL","http://www.baidu.com")
    return   ' Function in Lua file  : '..key..'!'
end

function getHttpFromLua(key)
    --HttpURLConnection conn = null;
    --URL myFileUrl = null;
    --    url = luajava.bindClass("java.net.URL")
    --    url1 = luajava.newInstance("java.net.URL","http://www.baidu.com")

end


