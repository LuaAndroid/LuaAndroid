--
--require("dkjson")
--require("jsondata")
require("log")

----------init class--------------
local Color = luajava.newInstance("android.graphics.Color")
local ColorClazz = luajava.bindClass("android.graphics.Color")
local drawableClazz = luajava.bindClass("dev.bnna.androlua.R$drawable")


function getItemSize(size,_scale)
    return size / 2 * _scale
end

---------------init params -----------------------
local null = nil
local scale = 3
local width = 1080
local height = 1821
local horizontalItemHeight = getItemSize(140,scale)
local verticalItemHeight = getItemSize(240,scale)
local t10ItemWidth = width / 3
local t10VerticalItemHeight = getItemSize(250,scale)
local categoryItemHeight = getItemSize(90,scale)
local topMargin = getItemSize(26,scale)
local leftMargin = getItemSize(26,scale)
local rightMargin = getItemSize(26,scale)
local bottomMargin = getItemSize(26,scale)
local layoutSpacing = getItemSize(20,scale)
local imageSize = getItemSize(140,scale)
local categoryImageSize = getItemSize(80,scale)
local divLineSize = 1

---------------init  table------------------

fontSize = {
    categoryTextSize = 20,
    titleTextSize = 16,
    subTitleTextSize = 14
}
fontColor = {


}

local titleTextSize = 16;
local subTilteTextSize = 12;

local specials = {"特价优惠大促销","海底捞","￥81","特价" }
local titles = {"到店付","到店付五折起","每日惠","狂享折上折" }
local rectTitles = {"电影特惠","新客专享","舒适足疗","K歌钜惠","储值卡","外卖到家","天天特价","自助钜惠" }
local rectSubTitles = {"伦敦陷落","相叠加优惠","全场19起","立享折扣","7.5折起","新用户立减","门票3折起","最高免单" }
local colorTitle = {Color.BLACK,Color.WHITE,Color.WHITE,
    Color.RED,Color.GREEN,Color.BLUE,Color.YELLOW,Color.MAGENTA}

-- 获取本地图片
local icDrawables = {drawableClazz.ic_choose_title,drawableClazz.ic_specials,
    drawableClazz.ic_store_title,drawableClazz.ic_store_pic,
    drawableClazz.ic_daily_title,drawableClazz.ic_daily_pic,drawableClazz.icon_arrows_gray_right}


local MARGIN = 0

--icon_name={choose="ic_choose_title",special="ic_special",store_title="ic_store_title",store_pic="ic_store_pic",daily_title="ic_daily_title",daily_pic="ic_daily_pic"}




-- 获取屏幕信息，尺寸比例，宽度，高度




local function getScreen(context,_scale,_width,_height)
    scale = _scale;
    width = _width;
    height = _height;
--    printlogView("_scale,_width,_height  :  "  )
--    local Toast = luajava.bindClass("android.widget.Toast")
--    Toast:makeText(context, scale+"/"+width+"/"+height , Toast.LENGTH_SHORT):show()
end

---- add onClick listener
local function onClick(context,view,str)
    local listener = luajava.createProxy("android.view.View$OnClickListener", {

        onClick = function(v)
            local Toast = luajava.bindClass('android.widget.Toast')
            Toast:makeText(context, str, Toast.LENGTH_SHORT):show()
        end

    })
    view:setOnClickListener(listener)
end

---------- 添加的主要视图 -----------------
function mainView(context,layout)
    -- 通过加载sdcard中的文件
    --    t10SpecialsView(context,layout,"/sdcard/lua/ic_choose_title.png",specials[1],specials[2],specials[3],icDrawables[2])


    -- top
    local horizontalViewTop = horizontalLinearLayout(context)
    horizontalViewTop:addView(t10SpecialsView(context,titles[1],specials[1],specials[2],specials[3],icDrawables[2]))
    horizontalViewTop:addView(t10NormalView(context,titles[1],colorTitle[4],titles[2],icDrawables[4]))
    horizontalViewTop:addView(t10NormalView(context,titles[3],colorTitle[5],titles[2],icDrawables[6]))

--    layout:addView(horizontalViewTop);

end

-- rectView
function rectView(context,layout)

    layout:addView(operationWithCategoryViewItem(context,false,6));
--    main();
    layout:addView(operationWithCategoryViewItem(context,true,7));
    layout:addView(operationWithCategoryViewItem(context,true,8));
end



---------- 添加的布局 -----------------
function horizontalLinearLayout(context,width,height)
    local MARGIN = 0
    local layoutParams
    local _width = width
    local _height = width
    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    if _width == nil and _height == nil then
        layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.WRAP_CONTENT)
    else
        layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",_width,_height)
    end

    layoutParams:setMargins(MARGIN,MARGIN,MARGIN,MARGIN)
    linearLayoutView:setBackgroundColor(Color.WHITE)
    local linearLayoutClazz = luajava.bindClass("android.widget.LinearLayout")
    linearLayoutView:setOrientation(linearLayoutClazz.HORIZONTAL)
    linearLayoutView:setLayoutParams(layoutParams)
    return linearLayoutView
end

function verticalLinearLayout(context,width,height)
    local MARGIN = 0
    local layoutParams
    local _width = width
    local _height = width
    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    if _width == nil and _height == nil then
        layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    else
        layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",_width,_height)
    end
    layoutParams:setMargins(MARGIN,MARGIN,MARGIN,MARGIN)
    linearLayoutView:setBackgroundColor(Color.WHITE)
    local linearLayoutClazz = luajava.bindClass("android.widget.LinearLayout")
    linearLayoutView:setOrientation(linearLayoutClazz.VERTICAL)
    linearLayoutView:setLayoutParams(layoutParams)
    return linearLayoutView
end



------------ t10精选抢购item
function t10SpecialsView(context,titlePic,subTitleText,specialTitle,specialText,specialTextPic)
--    local titlePic =
    local MARGIN = 0
    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",t10ItemWidth,t10VerticalItemHeight)
--    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT,1)
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


    onClick(context,linearLayoutView,specialText)

    return linearLayoutView
end



--- t10普通运营位
function t10NormalView(context,titleText,titleColor,subTitleText,mainImg)

    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
    -- local linearLayoutClazz = luajava.newInstance("android.widget.LinearLayout")
    local layoutParamsClazz = luajava.bindClass("android.widget.LinearLayout$LayoutParams")
--    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT,1)
    local layoutParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",t10ItemWidth ,t10VerticalItemHeight)
    local gravityClazz = luajava.bindClass("android.view.Gravity")
    local linearLayoutClazz = luajava.bindClass("android.widget.LinearLayout")
    linearLayoutView:setOrientation(linearLayoutClazz.VERTICAL)
    linearLayoutView:setGravity(gravityClazz.CENTER_HORIZONTAL)
    linearLayoutView:setLayoutParams(layoutParams)
    linearLayoutView:setBackgroundColor(Color.WHITE)

    --  titlePic
    local  titleTv = luajava.newInstance("android.widget.TextView",context)
    titleTv:setText(titleText)
    titleTv:setTextSize(titleTextSize)
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
    local mainIvWidth = imageSize
    local mainIvHeight = imageSize
    local mainIvParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",mainIvWidth,mainIvHeight)

    --add view
    linearLayoutView:addView(titleTv)
    linearLayoutView:addView(subTitleTv)
    linearLayoutView:addView(mainIv,mainIvParams)

    return linearLayoutView
end

--- 横向带有三个item的布局，1大2小
function threeItemView(context,tab1,tab2,tab3)
    local mainLayout = horizontalLinearLayout(context)
    local verticalView = normalVerticalView(context,tab1[1],tab1[2],tab1[3],tab1[4])
    local verticalLine = divLine(context,0,divLineSize, verticalItemHeight)



    local rightLayout = verticalLinearLayout(context)
    local horizontalViewTop = normalHorizontalView(context,tab2[1],tab2[2],tab2[3],tab2[4])
    local horizontalLine = divLine(context,0,width/2-1 ,1)
    local horizontalViewBottom = normalHorizontalView(context,tab3[1],tab3[2],tab3[3],tab3[4])


    mainLayout:addView(verticalView)
    mainLayout:addView(verticalLine)
    rightLayout:addView(horizontalViewTop)
    rightLayout:addView(horizontalLine)
    rightLayout:addView(horizontalViewBottom)
    mainLayout:addView(rightLayout)

    return mainLayout
end

--- 竖向item，标题，副标题，图片竖直排列
function normalVerticalView(context,titleText,titleColor,subTitleText,mainImg)

    local linearLayoutView = luajava.newInstance("android.widget.LinearLayout",context)
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
    titleTv:setPadding(leftMargin,0,0,0)
    titleTv:setText(titleText)
    titleTv:setTextSize(titleTextSize)
    titleTv:setTextColor(titleColor)
    local textPaint = titleTv:getPaint()
    textPaint:setFakeBoldText(true)


    --  subTitle
    local  subTitleTv = luajava.newInstance("android.widget.TextView",context)
    subTitleTv:setPadding(leftMargin,0,0,0)
    subTitleTv:setText(subTitleText)
    subTitleTv:setTextColor(Color.BLACK)

    --  mainImg
--    local linearLayoutImgView = luajava.newInstance("android.widget.LinearLayout",context)
--    local layoutParamsImg = luajava.newInstance("android.widget.LinearLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT)
--    layoutParamsImg.grativy = gravityClazz.CENTER_VERTICAL
--    linearLayoutImgView:setOrientation(linearLayoutClazz.VERTICAL)
--    linearLayoutImgView:setGravity(gravityClazz.BOTTOM)
--    linearLayoutImgView:setLayoutParams(layoutParamsImg)

    local  mainIv = luajava.newInstance("android.widget.ImageView",context)
    mainIv:setImageResource(mainImg)
    local mainIvWidth = imageSize
    local mainIvHeight = imageSize
    local mainIvParams = luajava.newInstance("android.widget.LinearLayout$LayoutParams",mainIvWidth,mainIvHeight)
    --    local BitmapFactory  = luajava.bindClass("android.graphics.BitmapFactory")
    --    local bitmap = BitmapFactory.decodeFile(BitmapFactory,mainImg)
    --    mainIv:setImageBitmap(bitmap)
    mainIvParams.grativy = gravityClazz.CENTER
--    mainIv.setGrativy(gravityClazz.CENTER)
--    linearLayoutImgView:addView(mainIv,mainIvParams)
    --add view
    linearLayoutView:addView(titleTv)
    linearLayoutView:addView(subTitleTv)
    linearLayoutView:addView(mainIv,mainIvParams)
--    linearLayoutView:addView(linearLayoutImgView,layoutParamsImg)

    onClick(context,linearLayoutView,titleText)

    return linearLayoutView
end

---横向item  标题、副标题竖向，图片横向排列
function normalHorizontalView(context,titleText,titleColor,subTitleText,mainImg,lableText)
    local margin = leftMargin
    local layoutHeight = horizontalItemHeight
    local layoutwidth = width / 2
    local relativeLayoutView = luajava.newInstance("android.widget.RelativeLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.RelativeLayout$LayoutParams")
    --    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT)
    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutwidth,layoutHeight)
    local relativeLayoutClazz = luajava.bindClass("android.widget.RelativeLayout")
    relativeLayoutView:setLayoutParams(layoutParams)
    relativeLayoutView:setBackgroundColor(Color.WHITE)



    --    --  titlePic
    local  titleTv = luajava.newInstance("android.widget.TextView",context)
    titleTv:setText(titleText)
    titleTv:setTextSize(titleTextSize)
    titleTv:setTextColor(titleColor)
    local textPaint = titleTv:getPaint()
    textPaint:setFakeBoldText(true)
    local titleTvId = 100
    titleTv:setId(titleTvId)

    local titleParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    titleParams:addRule(relativeLayoutClazz.ALIGN_PARENT_TOP)
    titleParams:setMargins(margin,0,0,0)
    --
    --
    --  subTitle
    local  subTitleTv = luajava.newInstance("android.widget.TextView",context)
    subTitleTv:setText(subTitleText)
    --    subTitleTv:setTextSize(subTitleTextSize)
    subTitleTv:setTextColor(Color.DKGRAY)
    local subTitleTvId = titleTvId + 1
    subTitleTv:setId(subTitleTvId)
    local subTitleParams =luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    subTitleParams:addRule(relativeLayoutClazz.BELOW,titleTvId)
    subTitleParams:addRule(relativeLayoutClazz.ALIGN_LEFT,titleTvId)

    --  lable
    local lableTv
    local lableTvParams

    if lableText ~= nil then
        lableTv = luajava.newInstance("android.widget.TextView",context)
        lableTv:setText(lableText)
        lableTv:setTextColor(Color.DKGRAY)
        local lableTvId = titleTvId + 2
        lableTv:setId(lableTvId)
        lableTvParams =luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
        lableTvParams:addRule(relativeLayoutClazz.BELOW,subTitleTvId)
        lableTvParams:addRule(relativeLayoutClazz.ALIGN_LEFT,titleTvId)
    end


    --
    --    --  mainImg
    local  mainIv = luajava.newInstance("android.widget.ImageView",context)
    mainIv:setImageResource(mainImg)
    local mainIvSize = imageSize
    local mainIvParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",mainIvSize,mainIvSize)
    --    local mainIvParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    mainIvParams:addRule(relativeLayoutClazz.ALIGN_PARENT_RIGHT)
    mainIvParams:addRule(relativeLayoutClazz.CENTER_VERTICAL)
    --
    --
    --
    --    --add view
    relativeLayoutView:addView(titleTv,titleParams)
    relativeLayoutView:addView(subTitleTv,subTitleParams)
--
    if lableTv ~= nil then
        relativeLayoutView:addView(lableTv,lableTvParams)

    end

    relativeLayoutView:addView(mainIv,mainIvParams)


    local listener = luajava.createProxy("android.view.View$OnClickListener", {

        onClick = function(v)
            local Toast = luajava.bindClass('android.widget.Toast')
            Toast:makeText(context, titleText, Toast.LENGTH_SHORT):show()
        end
    })
    onClick(context,relativeLayoutView,titleText)
    return relativeLayoutView
end

--- 分类标题
function categoryTitle(context,path,mainImg,titleText,titleColor,subTitleText,subTitleColor)
    local margin = leftMargin
    local relativeLayoutView = luajava.newInstance("android.widget.RelativeLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.RelativeLayout$LayoutParams")
    --    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT)
    local titleHeight = categoryItemHeight
    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,titleHeight)
    local relativeLayoutClazz = luajava.bindClass("android.widget.RelativeLayout")
    relativeLayoutView:setLayoutParams(layoutParams)
    relativeLayoutView:setBackgroundColor(Color.WHITE)


    --    --  mainImg
    local  mainIv = luajava.newInstance("android.widget.ImageView",context)
    mainIv:setImageResource(mainImg)
    local mainIvSize = categoryImageSize
    local mainIvParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",mainIvSize,mainIvSize)
    --    local mainIvParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    mainIvParams:addRule(relativeLayoutClazz.CENTER_VERTICAL)
    local mainIvId = 200
    mainIv:setId(mainIvId)


    --    --  titleTv
    local  titleTv = luajava.newInstance("android.widget.TextView",context)
    titleTv:setText(titleText)
    titleTv:setTextSize(titleTextSize)
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
    subTitleTv:setTextColor(subTitleColor)
    subTitleTv:setPadding(0,0,0,rightMargin)
    local subTitleParams =luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    subTitleParams:addRule(relativeLayoutClazz.ALIGN_PARENT_RIGHT)
    subTitleParams:addRule(relativeLayoutClazz.CENTER_VERTICAL)
    local drawable =  context:getResources():getDrawable(icDrawables[7])
    local drawablePadding = rightMargin
    subTitleTv:setCompoundDrawablesWithIntrinsicBounds(nil,nil,drawable,nil)
    subTitleTv:setCompoundDrawablePadding(drawablePadding)



    --    --add view
    relativeLayoutView:addView(mainIv,mainIvParams)
    relativeLayoutView:addView(titleTv,titleParams)
    relativeLayoutView:addView(subTitleTv,subTitleParams)


    onClick(context,relativeLayoutView,path)

    return relativeLayoutView




end


-------------广告位布局-------------------
function adLayout(context,layout,tabel) end



--- oretation : 1  横线， 0 竖线；不传值 默认横向
--- width  分割线宽度
--- height 分割线高度
function divLine(context,orientation,width,height)
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
    local lineColor = ColorClazz:parseColor("#e1e1e1");
    linearLayoutView:setBackgroundColor(lineColor)
--    linearLayoutView:setBackgroundColor(Color.GRAY)
    return linearLayoutView
end

local function printlogView(str)
    nmdebug.logd("lua log : "..str)
end


---------------------------组合布局----------------------------------------
--- 不带分类标题的运营位，5格
--
function operationNoCategoryViewItem(context)

end



--- 运营位，6格,7格，8格
---
---
---
function operationWithCategoryViewItem(context,showCategory,viewSize)
    local isNumber = false
    if tonumber(viewSize) ~= nil then
        isNumber = true
    end

    -- init layout
    local verticalLinearLayout = verticalLinearLayout(context)


    -- categoryTitle 默认显示
    if showCategory == true then
        local categoryTitleView = horizontalLinearLayout(context)
        categoryTitleView:addView(categoryTitle(context,"天天美味",icDrawables[6],rectTitles[1],colorTitle[4],rectSubTitles[1],colorTitle[4]))
        verticalLinearLayout:addView(categoryTitleView);

    end


    if isNumber and viewSize == 6 then
        -- top
        local horizontalViewTop = horizontalLinearLayout(context)
        horizontalViewTop:addView(normalHorizontalView(context,rectTitles[1],colorTitle[4],rectSubTitles[1],icDrawables[6],"特价"))
        horizontalViewTop:addView(divLine(context,0,divLineSize,horizontalItemHeight))
        horizontalViewTop:addView(normalHorizontalView(context,rectTitles[2],colorTitle[5],rectSubTitles[2],icDrawables[6]))
        verticalLinearLayout:addView(horizontalViewTop);
    elseif isNumber and viewSize == 7  then
        -- threeViewItem
        local tab1={rectTitles[1],colorTitle[1],rectSubTitles[1],icDrawables[6]}
        local tab2={rectTitles[1],colorTitle[1],rectSubTitles[1],icDrawables[6],rectSubTitles[1]}
        local tab3={rectTitles[1],colorTitle[1],rectSubTitles[1],icDrawables[6]}
        local threeView = threeItemView(context,tab1,tab2,tab3)
        verticalLinearLayout:addView(threeView)
    elseif isNumber and viewSize == 8 then
        -- middle1
        local horizontalViewMiddle1 = horizontalLinearLayout(context)
        horizontalViewMiddle1:addView(normalHorizontalView(context,rectTitles[1],colorTitle[4],rectSubTitles[1],icDrawables[6],"特价"))
        horizontalViewMiddle1:addView(divLine(context,0,divLineSize,horizontalItemHeight))
        horizontalViewMiddle1:addView(normalHorizontalView(context,rectTitles[2],colorTitle[5],rectSubTitles[2],icDrawables[6]))
        verticalLinearLayout:addView(horizontalViewMiddle1);
        -- middle2
        local horizontalViewMiddle2 = horizontalLinearLayout(context)
        horizontalViewMiddle2:addView(normalHorizontalView(context,rectTitles[3],colorTitle[6],rectSubTitles[3],icDrawables[6]))
        horizontalViewMiddle2:addView(divLine(context,0,divLineSize,horizontalItemHeight))
        horizontalViewMiddle2:addView(normalHorizontalView(context,rectTitles[4],colorTitle[7],rectSubTitles[4],icDrawables[6]))
        verticalLinearLayout:addView(horizontalViewMiddle2);
    end

    -- bottom
    local horizontalViewBottom = horizontalLinearLayout(context)
    horizontalViewBottom:addView(normalVerticalView(context,rectTitles[5],colorTitle[1],rectSubTitles[5],icDrawables[6]))
    horizontalViewBottom:addView(divLine(context,0,divLineSize,verticalItemHeight))
    horizontalViewBottom:addView(normalVerticalView(context,rectTitles[6],colorTitle[2],rectSubTitles[6],icDrawables[6]))
    horizontalViewBottom:addView(divLine(context,0,divLineSize, verticalItemHeight))
    horizontalViewBottom:addView(normalVerticalView(context,rectTitles[7],colorTitle[7],rectSubTitles[7],icDrawables[6]))
    horizontalViewBottom:addView(divLine(context,0,divLineSize,verticalItemHeight))
    horizontalViewBottom:addView(normalVerticalView(context,rectTitles[8],colorTitle[4],rectSubTitles[8],icDrawables[6]))

    verticalLinearLayout:addView(divLine(context,0,width,1));
    verticalLinearLayout:addView(horizontalViewBottom);
    return verticalLinearLayout
end




--local json = require("dkjson")
--local json_str = require("jsondata")
--
--
--
--print(json_string)
--print(type(json_string))
function main()
    local obj, pos, err = json.decode (json_str, 1, nil)
    print(type(obj))
    if err then
        print("Error：", err)
    else
        parseBaseInfo(obj)
        local meta_table = getmetatable(obj.data)
        if meta_table.__jsontype then
            print("__jsontype: is", meta_table.__jsontype)
        end
    end
    --  parerJson(obj)
    --end
    --
    --local function parerJson(objData)
    local data = obj.data

    --    parseo2oCategory(data.hotService);
    --  parseTop10Specail(data.topten)
    --    parseTop10Normal(data.meiRiBaoKuan)
    --    parseNuomiAds(data.nuomiAds)
--    for key, var in pairs(_G) do
--        print(key)
--    end
end
---------------------------------------------------------
--解析obj返回的基本数据
--return baseInfo
-----------------------------------------------------------
function parseBaseInfo(tab)
    local baseMetaData = tab;
    local info = {}
    info.errno = baseMetaData.errno
    info.errmsg = baseMetaData.errmsg
    info.msg = baseMetaData.msg
    info.serverlogid = baseMetaData.serverlogid
    info.serverstatus = baseMetaData.serverstatus
    info.cached = baseMetaData.cached
    info.timestamp = baseMetaData.timestamp
    for key, value in pairs(info) do
--        print(key.."\t"..value)
        printlogView(key.."\t"..value)
    end
    return info
end
---------------------------------------------------------
--topten  精选抢购
--t10 精选抢购运营位 josn
--tab - topten
--return top10
-----------------------------------------------------------
function parseTop10Specail(tab)
    local defualtStr = nil
    local defualtNum = -1
    local top10 = {}
    local top10MetaTable = tab--data.hotService
    if getmetatable(top10MetaTable).__jsontype == "object" then
        print("top10MetaTable : is  ",  getmetatable(top10MetaTable).__jsontype)
        -------- parse base info
        top10.target_url  = top10MetaTable.target_url
        for key, value in pairs(top10) do
            print(key.."\t"..value)
        end

        --------- parse list list
        if getmetatable(top10MetaTable.list).__jsontype == "array" then
            local listList = {}
            print("top10MetaTable.list : is  ",  getmetatable(top10MetaTable.list).__jsontype)
            print("list length  "..#(top10MetaTable.list))
            for i=1, #top10MetaTable.list do
                local list = {deal_id ,brand ,market_price,current_price, na_logo}
                list.deal_id        = top10MetaTable.list[i].deal_id
                list.brand          = top10MetaTable.list[i].brand
                list.market_price   = top10MetaTable.list[i].market_price
                list.current_price  = top10MetaTable.list[i].current_price
                list.na_logo        = top10MetaTable.list[i].na_logo
                table.insert(listList,i,list)
            end
            -- add list to top10 table
            top10.list = listList
        end

        --------- parse activetime list
        if getmetatable(top10MetaTable.activetime).__jsontype == "array" then
            local activetimeList = {}
            print("top10MetaTable.activetime : is  ",  getmetatable(top10MetaTable.activetime).__jsontype)
            print("activetime length  "..#(top10MetaTable.activetime))
            for i=1, #top10MetaTable.activetime do
                local activetime = {starttime,endtime }
                activetime.starttime  = top10MetaTable.activetime[i].starttime
                activetime.endtime    = top10MetaTable.activetime[i].endtime

                table.insert(activetimeList,i,activetime)
            end
            -- add activetime to top10 table
            top10.activetime = activetimeList
        end

        for key,value in pairs(top10) do
            if key == "list" then
                --       print("-------------\t list \t----------------------------")
                for i=1,#top10.list do
                    print(top10.list[i].deal_id)
                    print(top10.list[i].brand)
                    print(top10.list[i].market_price)
                    print(top10.list[i].current_price)
                    print(top10.list[i].na_logo)
                end
            elseif key == "activetime" then
                --         print("-------------\t activetime \t----------------------------")
                for i=1,#top10.activetime do
                    print(top10.activetime[i].starttime)
                    print(top10.activetime[i].endtime)
                end
            else
                --        print("-------------\t baseInfo \t----------------------------")
                print(key.."\t"..value)
            end
        end
    end


end



---------------------------------------------------------
--解析
--到店付      daoDianfu
--每日爆款    meiRiBaoKuan
--t10普通运营位josn
--
--tab - daoDianfu,meiRiBaoKuan
--return top10Normal
---------------------------------------------------------
function parseTop10Normal(tab)
    local defualtStr = "null"
    local defualtNum = 0

    local top10NormalMetaData = tab

    local top10Normal = {}
    local top10NormalList = {}
    local meta_table = getmetatable(top10NormalMetaData)
    if meta_table.__jsontype == "array" then
        print("meta_table: is",  top10NormalMetaData.__jsontype)
        for i=1, #top10NormalMetaData do
            local top10NormalInfo = {advType,cont,gotoType,pictureUrl,subTitle,subTitleColor,titlePictureUrl}
            top10NormalInfo.advType = top10NormalMetaData[i].advType
            top10NormalInfo.cont = top10NormalMetaData[i].cont
            top10NormalInfo.gotoType = top10NormalMetaData[i].gotoType
            top10NormalInfo.pictureUrl = top10NormalMetaData[i].pictureUrl
            top10NormalInfo.subTitle = top10NormalMetaData[i].subTitle
            top10NormalInfo.subTitleColor = top10NormalMetaData[i].subTitleColor
            top10NormalInfo.titlePictureUrl = top10NormalMetaData[i].titlePictureUrl
            table.insert(top10NormalList,i, top10NormalInfo)
        end
        for i=1, #top10NormalList do
            print(top10NormalList[i].advType)
            print(top10NormalList[i].cont)
            print(top10NormalList[i].gotoType)
            print(top10NormalList[i].pictureUrl)
            print(top10NormalList[i].subTitle)
            print(top10NormalList[i].subTitleColor)
            print(top10NormalList[i].titlePictureUrl)
        end
    end

    return top10Normal
end



---------------------------------------------------------
--解析
--活动集合      activityGroup
--活动区域 josn
--tab     activityGroup
--return activityGroup
---------------------------------------------------------
function parseActivityGroup(tab)

    local activityGroupMetaData = tab
    local activityGroupList = {}
    local activityGroup = {}


    if getmetatable(activityGroupMetaData).__jsontype == "array" then
        print("activityGroupMetaData: is",  getmetatable(activityGroupMetaData).__jsontype)
        for i=1, #activityGroupMetaData do
            local activityGroupInfo = {bannerId ,pictureUrl , gotoType,start_time ,end_time ,cont}
            activityGroupInfo.bannerId = activityGroupMetaData[i].bannerId
            activityGroupInfo.pictureUrl = activityGroupMetaData[i].pictureUrl
            activityGroupInfo.gotoType = activityGroupMetaData[i].gotoType
            activityGroupInfo.start_time = activityGroupMetaData[i].start_time
            activityGroupInfo.end_time = activityGroupMetaData[i].end_time
            activityGroupInfo.cont = activityGroupMetaData[i].cont

            table.insert(activityGroupList,i, activityGroupInfo)
        end
        for i=1, #activityGroupList do
            print(activityGroupList[i].bannerId)
            print(activityGroupList[i].pictureUrl)
            print(activityGroupList[i].gotoType)
            print(activityGroupList[i].start_time)
            print(activityGroupList[i].end_time)
            print(activityGroupList[i].cont)
        end
    end
    return activityGroup
end

---------------------------------------------------------
--解析
--糯米广告     nuomiAds
--豆腐块运营位  josn
--return nuomiAds
function parseNuomiAds(tab)

    local nuomiAdsMetaData = tab
    local nuomiAdsList = {}
    local nuomiAds = {}

    if getmetatable(nuomiAdsMetaData).__jsontype == "array" then
        print("nuomiAdsMetaData: is",  getmetatable(nuomiAdsMetaData).__jsontype)
        for i=1, #nuomiAdsMetaData do
            local nuomiAdsInfo = {bannerId ,pictureUrl , gotoType,start_time ,end_time ,cont}
            nuomiAdsInfo.bannerId = nuomiAdsMetaData[i].bannerId
            nuomiAdsInfo.pictureUrl = nuomiAdsMetaData[i].pictureUrl
            nuomiAdsInfo.gotoType = nuomiAdsMetaData[i].gotoType
            nuomiAdsInfo.start_time = nuomiAdsMetaData[i].start_time
            nuomiAdsInfo.end_time = nuomiAdsMetaData[i].end_time
            nuomiAdsInfo.cont = nuomiAdsMetaData[i].cont

            table.insert(nuomiAdsList,i, nuomiAdsInfo)
        end
        for i=1, #nuomiAdsList do
            print(nuomiAdsList[i].bannerId)
            print(nuomiAdsList[i].pictureUrl)
            print(nuomiAdsList[i].gotoType)
            print(nuomiAdsList[i].start_time)
            print(nuomiAdsList[i].end_time)
            print(nuomiAdsList[i].cont)
        end
    end
    return nuomiAds
end



----------------------------------------------------------
--解析
--天天美味   meishiGroup
--休闲娱乐   entertainment
--精选服务   hotService
--o2o分类运营块 josn
--
--tab - meishiGroup,entertainment,hotService
--return category
----------------------------------------------------------
function parseo2oCategory(tab)
    local defualtStr = nil
    local defualtNum = -1
    local category = {}
    local categoryMetaTable = tab--data.hotService
    if getmetatable(categoryMetaTable).__jsontype == "object" then
        print("categoryMetaTable : is  ",  getmetatable(categoryMetaTable).__jsontype)
        -------- parse base info
        category.ceilTitle  = categoryMetaTable.ceilTitle
        category.titleColor = categoryMetaTable.titleColor
        category.descTitle  = categoryMetaTable.descTitle
        category.descColor  = categoryMetaTable.descColor
        category.moreLink   = categoryMetaTable.moreLink
        for key, value in pairs(category) do
            print(key.."\t"..value)
        end

        --------- parse banner list
        if getmetatable(categoryMetaTable.banner).__jsontype == "array" then
            local bannerList = {}
            print("categoryMetaTable.banner : is  ",  getmetatable(categoryMetaTable.banner).__jsontype)
            print("banner length  "..#(categoryMetaTable.banner))
            for i=1, #categoryMetaTable.banner do
                local banner = {bannerId=defualtStr,image=defualtStr,link=defualtStr}
                banner.bannerId  = categoryMetaTable.banner[i].bannerId
                banner.image  = categoryMetaTable.banner[i].image
                banner.link  = categoryMetaTable.banner[i].link
                table.insert(bannerList,i,banner)
            end
            -- add banner to category table
            category.banner = bannerList
        end

        --------- parse listInfo list
        if getmetatable(categoryMetaTable.listInfo).__jsontype == "array" then
            local listInfoList = {}
            print("categoryMetaTable.listInfo : is  ",  getmetatable(categoryMetaTable.listInfo).__jsontype)
            print("listInfo length  "..#(categoryMetaTable.listInfo))
            for i=1, #categoryMetaTable.listInfo do
                local listInfo = {bannerId ,title ,titleColor ,
                    subtitle ,subtitleColor ,tag ,
                    backgroundColor ,image ,link }
                listInfo.bannerId  = categoryMetaTable.listInfo[i].bannerId
                listInfo.title  = categoryMetaTable.listInfo[i].title
                listInfo.titleColor  = categoryMetaTable.listInfo[i].titleColor
                listInfo.subtitle  = categoryMetaTable.listInfo[i].subtitle
                listInfo.subtitleColor  = categoryMetaTable.listInfo[i].subtitleColor
                listInfo.tag  = categoryMetaTable.listInfo[i].tag
                listInfo.backgroundColor  = categoryMetaTable.listInfo[i].backgroundColor
                listInfo.image  = categoryMetaTable.listInfo[i].image
                listInfo.link  = categoryMetaTable.listInfo[i].link
                table.insert(listInfoList,i,listInfo)
            end
            -- add banner to category table
            category.listInfo = listInfoList
        end

        for key,value in pairs(category) do
            --       print("-------------\t banner \t----------------------------")
            if key == "banner" then
                for i=1,#category.banner do
                    print(category.banner[i].bannerId)
                    print(category.banner[i].image)
                    print(category.banner[i].link)
                end
            elseif key == "listInfo" then
                --         print("-------------\t listInfo \t----------------------------")
                for i=1,#category.listInfo do
                    print(category.listInfo[i].bannerId)
                    print(category.listInfo[i].title)
                    print(category.listInfo[i].titleColor)
                    print(category.listInfo[i].subtitle)
                    print(category.listInfo[i].subtitleColor)
                    print(category.listInfo[i].tag)
                    print(category.listInfo[i].backgroundColor)
                    print(category.listInfo[i].image)
                    print(category.listInfo[i].link)
                end
            else
                --        print("-------------\t baseInfo \t----------------------------")
                print(key.."\t"..value)
            end
        end
    end
    return category
end
--main();




