

Color = luajava.newInstance("android.graphics.Color")
drawableClazz = luajava.bindClass("dev.bnna.androlua.R$drawable")
null = nil
scale = 3
width = 1080
height = 1821
itemHeight = 60
verticalItemHeight = 100
imageSize = 50

titleTextSize = 20;
subTilteTextSize = 12;

-- init tables
specials = {"特价优惠大促销","海底捞","￥81","特价" }
titles = {"到店付","到店付五折起","每日惠","狂享折上折" }
rectTitles = {"电影特惠","新客专享","舒适足疗","K歌钜惠","储值卡","外卖到家","天天特价","自助钜惠" }
rectSubTitles = {"伦敦陷落","相叠加优惠","全场19起","立享折扣","7.5折起","新用户立减","门票3折起","最高免单" }
colorTitle = {Color.BLACK,Color.WHITE,Color.WHITE,
    Color.RED,Color.GREEN,Color.BLUE,Color.YELLOW,Color.MAGENTA}

-- 获取本地图片
icDrawables = {drawableClazz.ic_choose_title,drawableClazz.ic_specials,
    drawableClazz.ic_store_title,drawableClazz.ic_store_pic,
    drawableClazz.ic_daily_title,drawableClazz.ic_daily_pic}


MARGIN = 0

--icon_name={choose="ic_choose_title",special="ic_special",store_title="ic_store_title",store_pic="ic_store_pic",daily_title="ic_daily_title",daily_pic="ic_daily_pic"}

-- 获取屏幕信息，尺寸比例，宽度，高度
function getScreen(context,_scale,_width,_height)
    scale = _scale;
    width = _width;
    height = _height;
--    printlogView("_scale,_width,_height  :  "  )
--    local Toast = luajava.bindClass("android.widget.Toast")
--    Toast:makeText(context, scale+"/"+width+"/"+height , Toast.LENGTH_SHORT):show()
end

-- 添加的主要视图
function mainView(context,layout)
    -- 通过加载sdcard中的文件
    --    t10SpecialsView(context,layout,"/sdcard/lua/ic_choose_title.png",specials[1],specials[2],specials[3],icDrawables[2])


    -- top
    local horizontalViewTop = horizontalLinearLayout(context)
    horizontalViewTop:addView(t10SpecialsView(context,titles[1],specials[1],specials[2],specials[3],icDrawables[2]))
    horizontalViewTop:addView(t10NormalView(context,titles[1],colorTitle[4],titles[2],icDrawables[4]))
    horizontalViewTop:addView(t10NormalView(context,titles[3],colorTitle[5],titles[2],icDrawables[6]))

    layout:addView(horizontalViewTop);

end

-- rectView
function rectView(context,layout)
    -- 通过加载sdcard中的文件
    -- top
    local horizontalViewTop = horizontalLinearLayout(context)
    horizontalViewTop:addView( t10SpecialsView(context,titles[1],specials[1],specials[2],specials[3],icDrawables[2]))
    horizontalViewTop:addView(t10NormalView(context,titles[1],colorTitle[4],titles[2],icDrawables[4]))
    horizontalViewTop:addView(t10NormalView(context,titles[3],colorTitle[5],titles[2],icDrawables[6]))


    -- categoryTitle
    local categoryTitleView = horizontalLinearLayout(context)
    categoryTitleView:addView(categoryTitle(context,"天天美味",icDrawables[6],rectTitles[1],colorTitle[4],rectSubTitles[1],colorTitle[4]))
    local lineView = horizontalLinearLayout(context)

    -- middle
    local horizontalViewMiddle1 = horizontalLinearLayout(context)
    horizontalViewMiddle1:addView(normalHorizontalView(context,rectTitles[1],colorTitle[4],rectSubTitles[1],icDrawables[6]))
    horizontalViewMiddle1:addView(divLine(context,0,1,scale * itemHeight))
    horizontalViewMiddle1:addView(normalHorizontalView(context,rectTitles[2],colorTitle[5],rectSubTitles[2],icDrawables[6]))
    -- middle2
    local horizontalViewMiddle2 = horizontalLinearLayout(context)
    horizontalViewMiddle2:addView(normalHorizontalView(context,rectTitles[3],colorTitle[6],rectSubTitles[3],icDrawables[6]))
    horizontalViewMiddle2:addView(divLine(context,0,1,scale * itemHeight))
    horizontalViewMiddle2:addView(normalHorizontalView(context,rectTitles[4],colorTitle[7],rectSubTitles[4],icDrawables[6]))



    -- bottom
    local horizontalViewBottom = horizontalLinearLayout(context)
    horizontalViewBottom:addView(normalVerticalView(context,rectTitles[5],colorTitle[1],rectSubTitles[5],icDrawables[6]))
    horizontalViewBottom:addView(divLine(context,0,1,scale * verticalItemHeight))
    horizontalViewBottom:addView(normalVerticalView(context,rectTitles[6],colorTitle[2],rectSubTitles[6],icDrawables[6]))
    horizontalViewBottom:addView(divLine(context,0,1,scale * verticalItemHeight))
    horizontalViewBottom:addView(normalVerticalView(context,rectTitles[7],colorTitle[7],rectSubTitles[7],icDrawables[6]))
    horizontalViewBottom:addView(divLine(context,0,1,scale * verticalItemHeight))
    horizontalViewBottom:addView(normalVerticalView(context,rectTitles[8],colorTitle[4],rectSubTitles[8],icDrawables[6]))

    layout:addView(horizontalViewTop);
    layout:addView(categoryTitleView);
    layout:addView(horizontalViewMiddle1);
    layout:addView(divLine(context,0,width,1));
    layout:addView(horizontalViewMiddle2);
    layout:addView(horizontalViewBottom);


end


function horizontalLinearLayout(context)
    local MARGIN = 0
    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.WRAP_CONTENT)
    layoutParams:setMargins(MARGIN,MARGIN,MARGIN,MARGIN)
    linearLayoutView:setBackgroundColor(Color.WHITE)
    local linearLayoutClazz = luajava.bindClass("android.widget.LinearLayout")
    linearLayoutView:setOrientation(linearLayoutClazz.HORIZONTAL)
    linearLayoutView:setLayoutParams(layoutParams)
    return linearLayoutView
end

--printlog
function printlog(str)
    nmdebug.logd("lua log : "..str)
end

-- t10精选抢购item
function t10SpecialsView(context,titlePic,subTitleText,specialTitle,specialText,specialTextPic)
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
    linearLayoutView:setBackgroundColor(Color.WHITE)


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
    --    linearLayoutView:addView(t10SpecialsView(context,"1","会员不限时抢购","新辣道","￥81.5","1"))
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

-- t10普通运营位
function t10NormalView(context,titleText,titleColor,subTitleText,mainImg)

    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    -- local linearLayoutClazz = luajava.newInstance("android.widget.LinearLayout")
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT,1)
    local gravityClazz = luajava.bindClass("android.view.Gravity")
    local linearLayoutClazz = luajava.bindClass("android.widget.LinearLayout")
    linearLayoutView:setOrientation(linearLayoutClazz.VERTICAL)
    linearLayoutView:setGravity(gravityClazz.CENTER_HORIZONTAL)
    linearLayoutView:setLayoutParams(layoutParams)
    linearLayoutView:setBackgroundColor(Color.WHITE)

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
    local mainIvWidth = scale * 50
    local mainIvHeight = scale * 50
    local mainIvParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",mainIvWidth,mainIvHeight)

    --add view
    linearLayoutView:addView(titleTv)
    linearLayoutView:addView(subTitleTv)
    linearLayoutView:addView(mainIv,mainIvParams)

    return linearLayoutView
end



-- 竖向item，标题，副标题，图片竖直排列
function normalVerticalView(context,titleText,titleColor,subTitleText,mainImg)
    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    -- local linearLayoutClazz = luajava.newInstance("android.widget.LinearLayout")
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT,1)
    local gravityClazz = luajava.bindClass("android.view.Gravity")
    local linearLayoutClazz = luajava.bindClass("android.widget.LinearLayout")
    linearLayoutView:setOrientation(linearLayoutClazz.VERTICAL)
    linearLayoutView:setGravity(gravityClazz.CENTER_HORIZONTAL)
    linearLayoutView:setLayoutParams(layoutParams)
    linearLayoutView:setBackgroundColor(Color.WHITE)


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
    local mainIvWidth = scale * 50
    local mainIvHeight = scale * 50
    local mainIvParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",mainIvWidth,mainIvHeight)
    --    local BitmapFactory  = luajava.bindClass("android.graphics.BitmapFactory")
    --    local bitmap = BitmapFactory.decodeFile(BitmapFactory,mainImg)
    --    mainIv:setImageBitmap(bitmap)

    --add view
    linearLayoutView:addView(titleTv)
    linearLayoutView:addView(subTitleTv)
    linearLayoutView:addView(mainIv,mainIvParams)
    local listener = luajava.createProxy("android.view.View$OnClickListener", {

        onClick = function(v)
            local Toast = luajava.bindClass('android.widget.Toast')
            Toast:makeText(context, titleText, Toast.LENGTH_SHORT):show()
        end

    })
    linearLayoutView:setOnClickListener(listener)
    return linearLayoutView
end






--横向item  标题、副标题竖向，图片横向排列
function normalHorizontalView(context,titleText,titleColor,subTitleText,mainImg)
    local margin = 20
    local relativeLayoutView = luajava.newInstance("android.widget.RelativeLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.RelativeLayout$LayoutParams")
    --    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT)
    local layoutHeight = scale * itemHeight
    local layoutwidth = width / 2
    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutwidth,layoutHeight)
    local relativeLayoutClazz = luajava.bindClass("android.widget.RelativeLayout")
--    layoutParams:setMargins(margin,margin,margin,margin)
    relativeLayoutView:setLayoutParams(layoutParams)
    relativeLayoutView:setBackgroundColor(Color.BLUE)



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
    local mainIvSize = scale * imageSize
    local mainIvParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",mainIvSize,mainIvSize)
    --    local mainIvParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    mainIvParams:addRule(relativeLayoutClazz.ALIGN_PARENT_RIGHT)
    mainIvParams:addRule(relativeLayoutClazz.CENTER_VERTICAL)
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

-- 分类标题
function categoryTitle(context,path,mainImg,titleText,titleColor,subTitleText,subTitleColor)
    local margin = scale * 4
    local relativeLayoutView = luajava.newInstance("android.widget.RelativeLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.RelativeLayout$LayoutParams")
    --    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT)
    local titleHeight = scale * 40
    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,titleHeight)
    local relativeLayoutClazz = luajava.bindClass("android.widget.RelativeLayout")
    relativeLayoutView:setLayoutParams(layoutParams)
    relativeLayoutView:setBackgroundColor(Color.GREEN)


    --    --  mainImg
    local  mainIv = luajava.newInstance("android.widget.ImageView",context)
    mainIv:setImageResource(mainImg)
    local mainIvSize = scale * 30
    local mainIvParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",mainIvSize,mainIvSize)
    --    local mainIvParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    mainIvParams:addRule(relativeLayoutClazz.CENTER_VERTICAL)
    local mainIvId = 200
    mainIv:setId(mainIvId)


    --    --  titleTv
    local  titleTv = luajava.newInstance("android.widget.TextView",context)
    titleTv:setText(titleText)
    titleTv:setTextSize(20)
    titleTv:setTextColor(titleColor)
    local textPaint = titleTv:getPaint()
    textPaint:setFakeBoldText(true)
--    local titleTvId = 201
--    titleTv:setId(titleTvId)

    local titleParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    titleParams:addRule(relativeLayoutClazz.CENTER_VERTICAL)
    titleParams:addRule(relativeLayoutClazz.RIGHT_OF,mainIvId)
    titleParams:setMargins(margin,0,0,0)


        --  subTitle
    local  subTitleTv = luajava.newInstance("android.widget.TextView",context)
    subTitleTv:setText(subTitleText)
    --    subTitleTv:setTextSize(subTitleTextSize)
    subTitleTv:setTextColor(subTitleColor)
    local subTitleParams =luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    subTitleParams:addRule(relativeLayoutClazz.ALIGN_PARENT_RIGHT)
    subTitleParams:addRule(relativeLayoutClazz.CENTER_VERTICAL)

    --    --add view
    relativeLayoutView:addView(mainIv,mainIvParams)
    relativeLayoutView:addView(titleTv,titleParams)
    relativeLayoutView:addView(subTitleTv,subTitleParams)

    --    layout:addView(relativeLayoutView)


    local listener = luajava.createProxy("android.view.View$OnClickListener", {

        onClick = function(v)
            local Toast = luajava.bindClass('android.widget.Toast')
            Toast:makeText(context, path, Toast.LENGTH_SHORT):show()
        end

    })
    relativeLayoutView:setOnClickListener(listener)

    return relativeLayoutView




end






-- oretation : 1  横线， 0 竖线
function divLine(context,orientation,width,height)
--    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
--    local  view = luajava.newInstance("android.widget.ImageView",context)
--
--    view:setBackgroundColor(Color.BLACK)
--    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
--    local layoutParams  = luajava.newInstance("android.widget.LinearLayout$LayoutParams",width,height)
--    view.setLayoutParams(layoutParams)
    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",width,height)
    -- local g =
    -- layoutParams.grativy = gravityClazz,gravityClazz.CENTER

    local linearLayoutClazz = luajava.bindClass("android.widget.LinearLayout")

    if orientation == 0 then
        linearLayoutView:setOrientation(linearLayoutClazz.HORIZONTAL)
    else
        linearLayoutView:setOrientation(linearLayoutClazz.VERTICAL)
    end

    linearLayoutView:setLayoutParams(layoutParams)
    linearLayoutView:setBackgroundColor(Color.GRAY)
    return linearLayoutView
end

local function printlogView(str)
    nmdebug.logd("lua log : "..str)
end



