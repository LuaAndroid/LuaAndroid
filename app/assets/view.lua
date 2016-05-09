

Color = luajava.newInstance("android.graphics.Color")
drawableClazz = luajava.bindClass("dev.bnna.androlua.R$drawable")
null = nil
titleTextSize = 20;
subTilteTextSize = 12;

-- init tables
specials = {"特价优惠大促销","海底捞","￥81","特价" }
titles = {"到店付","到店付五折起","每日惠","狂享折上折" }
rectTitles = {"电影特惠","新客专享","舒适足疗","K歌钜惠","储值卡","外卖到家","天天特价","自助钜惠" }
rectSubTitles = {"伦敦陷落","相叠加优惠","全场19起","立享折扣","7.5折起","新用户立减","门票3折起","最高免单" }
colorTitle = {Color.BLACK,Color.LTGRAY,Color.WHITE,
   Color.RED,Color.GREEN,Color.BLUE,Color.YELLOW,Color.MAGENTA}

-- 获取本地图片
icDrawables = {drawableClazz.ic_choose_title,drawableClazz.ic_specials,
    drawableClazz.ic_store_title,drawableClazz.ic_store_pic,
    drawableClazz.ic_daily_title,drawableClazz.ic_daily_pic}


MARGIN = 0

--icon_name={choose="ic_choose_title",special="ic_special",store_title="ic_store_title",store_pic="ic_store_pic",daily_title="ic_daily_title",daily_pic="ic_daily_pic"}

-- 添加的主要视图
function mainView(context,layout)
    -- 通过加载sdcard中的文件
--    viewWithSpecials(context,layout,"/sdcard/lua/ic_choose_title.png",specials[1],specials[2],specials[3],icDrawables[2])


    -- top
    local horizontalViewTop = horizontalLinearLayout(context)
    horizontalViewTop:addView( viewWithSpecials(context,titles[1],specials[1],specials[2],specials[3],icDrawables[2]))
    horizontalViewTop:addView(viewWithText(context,titles[1],colorTitle[4],titles[2],icDrawables[4]))
    horizontalViewTop:addView(viewWithText(context,titles[3],colorTitle[5],titles[2],icDrawables[6]))

    layout:addView(horizontalViewTop);

end

-- rectView
function rectView(context,layout)
    -- 通过加载sdcard中的文件
    -- top
    local horizontalViewTop = horizontalLinearLayout(context)
    horizontalViewTop:addView( viewWithSpecials(context,titles[1],specials[1],specials[2],specials[3],icDrawables[2]))
    horizontalViewTop:addView(viewWithText(context,titles[1],colorTitle[4],titles[2],icDrawables[4]))
    horizontalViewTop:addView(viewWithText(context,titles[3],colorTitle[5],titles[2],icDrawables[6]))


    -- middle
    local horizontalViewMiddle1 = horizontalLinearLayout(context)
    horizontalViewMiddle1:addView(rectVerticalview(context,rectTitles[1],colorTitle[4],rectSubTitles[1],icDrawables[6]))
--    horizontalViewMiddle1:addView(line(context))
    horizontalViewMiddle1:addView(rectVerticalview(context,rectTitles[2],colorTitle[5],rectSubTitles[2],icDrawables[6]))
 -- middle2
    local horizontalViewMiddle2 = horizontalLinearLayout(context)
    horizontalViewMiddle2:addView(rectVerticalview(context,rectTitles[3],colorTitle[6],rectSubTitles[3],icDrawables[6]))
--    horizontalViewMiddle2:addView(line(context,1))
    horizontalViewMiddle2:addView(rectVerticalview(context,rectTitles[4],colorTitle[7],rectSubTitles[4],icDrawables[6]))



    -- bottom
    local horizontalViewBottom = horizontalLinearLayout(context)
    horizontalViewBottom:addView(rectHorizontalView(context,rectTitles[5],colorTitle[1],rectSubTitles[5],icDrawables[6]))
    horizontalViewBottom:addView(rectHorizontalView(context,rectTitles[6],colorTitle[2],rectSubTitles[6],icDrawables[6]))
    horizontalViewBottom:addView(rectHorizontalView(context,rectTitles[7],colorTitle[7],rectSubTitles[7],icDrawables[6]))
    horizontalViewBottom:addView(rectHorizontalView(context,rectTitles[8],colorTitle[4],rectSubTitles[8],icDrawables[6]))

    layout:addView(horizontalViewTop);
    layout:addView(horizontalViewMiddle1);
    layout:addView(horizontalViewMiddle2);
    layout:addView(horizontalViewBottom);

end


function horizontalLinearLayout(context)
    local MARGIN = 10
    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,300)
    layoutParams:setMargins(MARGIN,MARGIN,MARGIN,MARGIN)

    local linearLayoutClazz = luajava.bindClass("android.widget.LinearLayout")
    linearLayoutView:setOrientation(linearLayoutClazz.HORIZONTAL)
    linearLayoutView:setLayoutParams(layoutParams)
    return linearLayoutView
end

--printlog
function printlog(str)
    nmdebug.logd("lua log : "..str)
end

-- 特价item context,titlePic,subTitleText,specialTitle,specialText,specialTextPic
function viewWithSpecials(context,titlePic,subTitleText,specialTitle,specialText,specialTextPic)
    local MARGIN = 10
    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT,1)
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
    local BitmapFactory  = luajava.bindClass("android.graphics.BitmapFactory")
    local bitmap = BitmapFactory.decodeFile(BitmapFactory,titlePic)
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

    local listener = luajava.createProxy("android.view.View$OnClickListener", {

        onClick = function(v)
            local Toast = luajava.bindClass('android.widget.Toast')
            Toast:makeText(context, specialTitle, Toast.LENGTH_SHORT):show()
        end

    })
    linearLayoutView:setOnClickListener(listener)

    return linearLayoutView
end

-- contains two picture and one text
function viewWithText(context,titleText,titleColor,subTitleText,mainImg)

    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    -- local linearLayoutClazz = luajava.newInstance("android.widget.LinearLayout")
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT,1)
    --local gravityClazz = luajava.bindClass("android.view.Gravity")
    -- local g =
    -- layoutParams.grativy = gravityClazz,gravityClazz.CENTER
    --layoutParams:setMargins(MARGIN,MARGIN,MARGIN,MARGIN)

    local linearLayoutClazz = luajava.bindClass("android.widget.LinearLayout")
    linearLayoutView:setOrientation(linearLayoutClazz.VERTICAL)
    linearLayoutView:setLayoutParams(layoutParams)
    linearLayoutView:setBackgroundColor(Color.LTGRAY)

    --  titlePic
    local  titleTv = luajava.newInstance("android.widget.TextView",context)
    titleTv:setText(titleText)
    titleTv:setTextSize(20)
    titleTv:setTextColor(titleColor)
    local textPaint = titleTv:getPaint()
    textPaint:setFakeBoldText(true)
    titleTv:setGravity(1)

    --  subTitle
    local  subTitleTv = luajava.newInstance("android.widget.TextView",context)
    subTitleTv:setText(subTitleText)
    subTitleTv:setTextColor(Color.BLACK)
    subTitleTv:setGravity(1)

    --  mainImg
    local  mainIv = luajava.newInstance("android.widget.ImageView",context)
    mainIv:setImageResource(mainImg)

    --add view
    linearLayoutView:addView(titleTv)
    linearLayoutView:addView(subTitleTv)
    linearLayoutView:addView(mainIv)

    return linearLayoutView
end


function getHttpFromJava(key)
    --HttpURLConnection conn = null;
    --URL myFileUrl = null;
--    url = luajava.bindClass("java.net.URL")
--    url1 = luajava.newInstance("java.net.URL","http://www.baidu.com")
    return   ' Function in Lua file  : '..key..'!'
end


-- 豆腐块的竖向列表
function rectHorizontalView(context,titleText,titleColor,subTitleText,mainImg)

    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    -- local linearLayoutClazz = luajava.newInstance("android.widget.LinearLayout")
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT,1)


    local linearLayoutClazz = luajava.bindClass("android.widget.LinearLayout")
    linearLayoutView:setOrientation(linearLayoutClazz.VERTICAL)
    linearLayoutView:setLayoutParams(layoutParams)


    --  titlePic
--    local  titleIv = luajava.newInstance("android.widget.ImageView",context)
--    titleIv:setImageResource(titleImg)
    local  titleTv = luajava.newInstance("android.widget.TextView",context)
    titleTv:setText(titleText)
    titleTv:setTextSize(20)
    titleTv:setTextColor(titleColor)
    local textPaint = titleTv:getPaint()
    textPaint:setFakeBoldText(true)

    --  subTitle
    local  subTitleTv = luajava.newInstance("android.widget.TextView",context)
    subTitleTv:setText(subTitleText)
    subTitleTv:setTextColor(Color.BLACK)

    --  mainImg
    local  mainIv = luajava.newInstance("android.widget.ImageView",context)
    mainIv:setImageResource(mainImg)
--    local BitmapFactory  = luajava.bindClass("android.graphics.BitmapFactory")
--    local bitmap = BitmapFactory.decodeFile(BitmapFactory,mainImg)
--    mainIv:setImageBitmap(bitmap)

    --add view
    linearLayoutView:addView(titleTv)
    linearLayoutView:addView(subTitleTv)
    linearLayoutView:addView(mainIv)
    local listener = luajava.createProxy("android.view.View$OnClickListener", {

        onClick = function(v)
            local Toast = luajava.bindClass('android.widget.Toast')
            Toast:makeText(context, titleText, Toast.LENGTH_SHORT):show()
        end

    })
    linearLayoutView:setOnClickListener(listener)
    return linearLayoutView
end






--豆腐块的 四宫格
function rectVerticalview(context,titleText,titleColor,subTitleText,mainImg)
    local margin = 20
    local relativeLayoutView = luajava.newInstance("android.widget.RelativeLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.RelativeLayout$LayoutParams")
--    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT)
    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",500,300)
    local relativeLayoutClazz = luajava.bindClass("android.widget.RelativeLayout")
    layoutParams:setMargins(margin,margin,margin,margin)
    relativeLayoutView:setLayoutParams(layoutParams)
    relativeLayoutView:setBackgroundColor(Color.WHITE)



--    --  titlePic
    local  titleTv = luajava.newInstance("android.widget.TextView",context)
    titleTv:setText(titleText)
    titleTv:setTextSize(20)
    titleTv:setTextColor(titleColor)
    local textPaint = titleTv:getPaint()
    textPaint:setFakeBoldText(true)
    local titleTvId = 100
    titleTv:setId(titleTvId)

    local titleParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    titleParams:addRule(relativeLayoutClazz.ALIGN_PARENT_TOP)
    titleParams:setMargins(margin,margin,margin,margin)
--
--
--    --  subTitle
    local  subTitleTv = luajava.newInstance("android.widget.TextView",context)
    subTitleTv:setText(subTitleText)
--    subTitleTv:setTextSize(subTitleTextSize)
    subTitleTv:setTextColor(Color.DKGRAY)
    local subTitleParams =luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    subTitleParams:addRule(relativeLayoutClazz.BELOW,titleTvId)
    subTitleParams:addRule(relativeLayoutClazz.ALIGN_LEFT,titleTvId)
--
--
--    --  mainImg
    local  mainIv = luajava.newInstance("android.widget.ImageView",context)
    mainIv:setImageResource(mainImg)
    local mainIvParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",150,150)
--    local mainIvParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    mainIvParams:addRule(relativeLayoutClazz.ALIGN_PARENT_RIGHT)
    mainIvParams:addRule(relativeLayoutClazz.ALIGN_PARENT_BOTTOM)
--
--
--
--    --add view
    relativeLayoutView:addView(titleTv,titleParams)
--    relativeLayoutView:addView(titleIv)
    relativeLayoutView:addView(subTitleTv,subTitleParams)
    relativeLayoutView:addView(mainIv,mainIvParams)

--    layout:addView(relativeLayoutView)


    local listener = luajava.createProxy("android.view.View$OnClickListener", {

        onClick = function(v)
            local Toast = luajava.bindClass('android.widget.Toast')
            Toast:makeText(context, titleText, Toast.LENGTH_SHORT):show()
        end

    })
    relativeLayoutView:setOnClickListener(listener)

    return relativeLayoutView
end

-- oretation : 1  横线， 0 竖线
function line(context)

    local  view = luajava.newInstance("android.widget.ImageView",context)
    view:setBackgroundColor(Color.GRAY)
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    local layoutParams  = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT)
--    local layoutParams  = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT)
--    end

    view.setLayoutParams(layoutParams)
    return view
end





