--
--require("dkjson")
--require("jsondata")
--require("log")

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

local moreInfo = "more"
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
local defualtTitleColor = Color.BLACK
local defualtSubTitleColor = Color.DGRAY
local defualtTitle = "标题"
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

function showToast(str)

     local Toast = luajava.bindClass("android.widget.Toast")
    Toast:makeText(context,str.."", Toast.LENGTH_SHORT):show()
end


local function getScreen(context,_scale,_width,_height)
    scale = _scale;
    width = _width;
    height = _height;
--    printlogView("_scale,_width,_height  :  "  )
--    local Toast = luajava.bindClass("android.widget.Toast")
--    Toast:makeText(context, scale+"/"+width+"/"+height , Toast.LENGTH_SHORT):show()
end


----- parseColor
function parseColor(color)

    return ColorClazz:parseColor(color)
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
    obj, pos, err = json.decode (jsondata, 1, nil)
    local baseInfo = {}
    baseInfo.errno  = obj.errno
    baseInfo.errmsg = obj.errmsg
    baseInfo.msg    = obj.msg
    baseInfo.cached = obj.cached
    baseInfo.serverlogid  = obj.serverlogid
    baseInfo.serverstatus = obj.serverstatus
    baseInfo.timestamp    = obj.timestamp

    local dataTable = {
        activityGroup = obj.data.activityGroup,
        banner_conf   = obj.data.banner_conf,
        category      = obj.data.category,
        daoDianfu     = obj.data.daoDianfu,
        entertainment = obj.data.entertainment,
        hotService    = obj.data.hotService,
        meiRiBaoKuan  = obj.data.meiRiBaoKuan,
        meishiGroup   = obj.data.meishiGroup,
        nuomiAds      = obj.data.nuomiAds,
        nuomiChannel  = obj.data.nuomiChannel,
        nuomiNews     = obj.data.nuomiNews,
        topten        = obj.data.topten,
    }

--    writeFile("sdcard/lua/log.txt","hello world")

    local Toast = luajava.bindClass("android.widget.Toast")

--     local file = io.read("logger","")
--     file:write

    local type = obj.data.entertainment.listInfo
    local infoIndex = 1
    Toast:makeText(context,"rectView---"..type[infoIndex].title.."", Toast.LENGTH_SHORT):show()
--    parseBaseInfo(obj)
    layout:addView(operationWithCategoryViewItem(context,true,6));
--    main(context);
--    main();
--    layout:addView(operationWithCategoryViewItem(context,true,7));
--    layout:addView(operationWithCategoryViewItem(context,true,8));
end

function writeFile(file_name,string)
    local f = assert(io.open(file_name,'r'))
    local content = f:read("*all")
--
    f:close()
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
---   TODO   tag 和 image布局
function normalHorizontalView(context,titleText,titleColor,subTitleText,mainImg,lableText)
    local margin = leftMargin
    local layoutHeight = horizontalItemHeight
    local layoutwidth = width / 2


    --init data
    local categoryType
    if  categoryType == nil then
        categoryType = "entertainment"
    end
    local typeInfo
    -- 判断分类类别,休闲娱乐，精选服务，天天美食
    if categoryType == "entertainment" then
        typeInfo = obj.data.entertainment
    elseif categoryType == "hotService" then
        typeInfo = obj.data.hotService
    elseif categoryType == "meishiGroup" then
        typeInfo = obj.data.hotService
    else
        typeInfo = obj.data.entertainment
    end


    local infoIndex = 1
    local listInfo = typeInfo.listInfo
        local Toast = luajava.bindClass("android.widget.Toast")
        Toast:makeText(context,"normalHorizontalView -- "..string.len(listInfo[infoIndex].titleColor).."", Toast.LENGTH_SHORT):show()

    local relativeLayoutView = luajava.newInstance("android.widget.RelativeLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.RelativeLayout$LayoutParams")
    --    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,layoutParamsClazz.MATCH_PARENT)
    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutwidth,layoutHeight)
    local relativeLayoutClazz = luajava.bindClass("android.widget.RelativeLayout")
    relativeLayoutView:setLayoutParams(layoutParams)

    if string.len(listInfo[infoIndex].backgroundColor) ~= 0 then
        relativeLayoutView:setBackgroundColor(ColorClazz:parseColor(listInfo[infoIndex].backgroundColor))
    else
        relativeLayoutView:setBackgroundColor(Color.WHITE)
    end




    --    --  titlePic
    local  titleTv = luajava.newInstance("android.widget.TextView",context)
    if string.len(listInfo[infoIndex].title) ~= 0 then
        titleTv:setText(listInfo[infoIndex].title)
    else
        titleTv:setText(defualtTitle)
    end

--    listInfo[infoIndex].titleColor = nil
    if string.len(listInfo[infoIndex].titleColor) ~= 0 then
        titleTv:setTextColor(ColorClazz:parseColor(listInfo[infoIndex].titleColor))
    else
        titleTv:setTextColor(defualtTitleColor)
    end
--

    local textPaint = titleTv:getPaint()
    textPaint:setFakeBoldText(true)
    local titleTvId = 100
    titleTv:setId(titleTvId)

    local titleParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
--    titleParams:addRule(relativeLayoutClazz.ALIGN_PARENT_TOP)
    titleParams:setMargins(margin,0,0,0)
    --
    --
    --  subTitle
    local  subTitleTv = luajava.newInstance("android.widget.TextView",context)
--    subTitleTv:setText(listInfo[infoIndex].subtitle)
--    --    subTitleTv:setTextSize(subTitleTextSize)
--    subTitleTv:setTextColor(Color.DKGRAY)
    if string.len(listInfo[infoIndex].subtitle) ~= 0 then
        subTitleTv:setText(listInfo[infoIndex].subtitle)
    else
        subTitleTv:setText(defualtTitle)
    end

    if string.len(listInfo[infoIndex].subtitleColor) ~= 0 then
        subTitleTv:setTextColor(ColorClazz:parseColor(listInfo[infoIndex].subtitleColor))
    else
        subTitleTv:setTextColor(defualtTitleColor)
    end
    local subTitleTvId = titleTvId + 1
    subTitleTv:setId(subTitleTvId)
    local subTitleParams =luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    subTitleParams:addRule(relativeLayoutClazz.BELOW,titleTvId)
    subTitleParams:addRule(relativeLayoutClazz.ALIGN_LEFT,titleTvId)

    --------  lable
    local lableTv
    local lableTvParams

    local lableText = "特价"
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

    --    --add view
    relativeLayoutView:addView(titleTv,titleParams)
    relativeLayoutView:addView(subTitleTv,subTitleParams)
--
    if lableTv ~= nil then
        relativeLayoutView:addView(lableTv,lableTvParams)

    end

    relativeLayoutView:addView(mainIv,mainIvParams)


    onClick(context,relativeLayoutView,listInfo[infoIndex].link)
    return relativeLayoutView
end

--- 分类标题
function categoryTitle(context,categorType)
    -- init data
    local typeInfo
    if  categorType == nil then
        categorType = "entertainment"
    end

    -- 判断分类类别,休闲娱乐，精选服务，天天美食
    if categorType == "entertainment" then
        typeInfo = obj.data.entertainment
    elseif categorType == "hotService" then
        typeInfo = obj.data.hotService
    elseif categorType == "meishiGroup" then
        typeInfo = obj.data.hotService
    else
        typeInfo = obj.data.entertainment
    end



    local category = parseo2oCategory(typeInfo)--obj.data.entertainment

--    local Toast = luajava.bindClass("android.widget.Toast")
--    Toast:makeText(context,"categoryTitle -- "..category.ceilTitle.."", Toast.LENGTH_SHORT):show()
    local margin = leftMargin
--
--    -- init layout
    local relativeLayoutView = luajava.newInstance("android.widget.RelativeLayout",context)
    local layoutParamsClazz = luajava.bindClass("android.widget.RelativeLayout$LayoutParams")
    local titleHeight = categoryItemHeight
    local layoutParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.MATCH_PARENT,titleHeight)
    local relativeLayoutClazz = luajava.bindClass("android.widget.RelativeLayout")
    relativeLayoutView:setLayoutParams(layoutParams)
    relativeLayoutView:setBackgroundColor(Color.WHITE)

        --  mainImg
    local  mainIv = luajava.newInstance("android.widget.ImageView",context)
    mainIv:setImageResource(icDrawables[7])
    local mainIvSize = categoryImageSize
    local mainIvParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",mainIvSize,mainIvSize)
    --    local mainIvParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    mainIvParams:addRule(relativeLayoutClazz.CENTER_VERTICAL)
    local mainIvId = 200
    mainIv:setId(mainIvId)
--
--
    --    --  titleTv
    local  titleTv = luajava.newInstance("android.widget.TextView",context)
    titleTv:setText(category.ceilTitle)
    if category.titleColor ~= nil then
        titleTv:setTextColor(ColorClazz:parseColor(category.titleColor))
    else
        titleTv:setTextColor(defualtTitleColor)
    end
    local textPaint = titleTv:getPaint()
    textPaint:setFakeBoldText(true)


    local titleParams = luajava.newInstance("android.widget.RelativeLayout$LayoutParams",layoutParamsClazz.WRAP_CONTENT,layoutParamsClazz.WRAP_CONTENT)
    titleParams:addRule(relativeLayoutClazz.CENTER_VERTICAL)
    titleParams:addRule(relativeLayoutClazz.RIGHT_OF,mainIvId)
    titleParams:setMargins(margin,0,0,0)


        --  subTitle
    local  subTitleTv = luajava.newInstance("android.widget.TextView",context)
    if category.descTitle ~= nil then
        subTitleTv:setText(category.descTitle)
    else
        subTitleTv:setText(moreInfo)
    end
    if category.descColor ~= nil then
        subTitleTv:setTextColor(ColorClazz:parseColor(category.descColor))
    else
        subTitleTv:setTextColor(defualtSubTitleColor)
    end
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


    onClick(context,relativeLayoutView,category.moreLink)

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

    local Toast = luajava.bindClass("android.widget.Toast")
    Toast:makeText(context,"operationWithCategoryViewItem -- "..obj.data.entertainment.ceilTitle.."", Toast.LENGTH_SHORT):show()
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
function main(context)
    local obj, pos, err = json.decode (jsondata, 1, nil)

    print(type(obj))
    if err then
        print("Error：", err)
    else

        local meta_table = getmetatable(obj.data)
        if meta_table.__jsontype then
            print("__jsontype: is", meta_table.__jsontype)
        end
    end
--      parerJson(obj)
    --end
    --
    --local function parerJson(objData)
    print(obj.errno)
    local baseInfo = parseBaseInfo(obj);

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
    local Toast = luajava.bindClass("android.widget.Toast")
        Toast:makeText(context,info.error.."", Toast.LENGTH_SHORT):show()
--    for key, value in pairs(info) do
----        print(key.."\t"..value)
----        printlogView(key.."\t"..value)
--        showToast(key.."\t"..value)
--    end
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

    return top10
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




-------dkjson----------



-- Module options:
local always_try_using_lpeg = true
local register_global_module_table = false
local global_module_name = 'json'

--[==[

David Kolf's JSON module for Lua 5.1/5.2

Version 2.5


For the documentation see the corresponding readme.txt or visit
<http://dkolf.de/src/dkjson-lua.fsl/>.

You can contact the author by sending an e-mail to 'david' at the
domain 'dkolf.de'.


Copyright (C) 2010-2013 David Heiko Kolf

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

--]==]

-- global dependencies:
local pairs, type, tostring, tonumber, getmetatable, setmetatable, rawset =
pairs, type, tostring, tonumber, getmetatable, setmetatable, rawset
local error, require, pcall, select = error, require, pcall, select
local floor, huge = math.floor, math.huge
local strrep, gsub, strsub, strbyte, strchar, strfind, strlen, strformat =
string.rep, string.gsub, string.sub, string.byte, string.char,
string.find, string.len, string.format
local strmatch = string.match
local concat = table.concat

json = { version = "dkjson 2.5" }

if register_global_module_table then
    _G[global_module_name] = json
end

local _ENV = nil -- blocking globals in Lua 5.2

pcall (function()
    -- Enable access to blocked metatables.
    -- Don't worry, this module doesn't change anything in them.
    local debmeta = require "debug".getmetatable
    if debmeta then getmetatable = debmeta end
end)

json.null = setmetatable ({}, {
    __tojson = function () return "null" end
})

local function isarray (tbl)
    local max, n, arraylen = 0, 0, 0
    for k,v in pairs (tbl) do
        if k == 'n' and type(v) == 'number' then
            arraylen = v
            if v > max then
                max = v
            end
        else
            if type(k) ~= 'number' or k < 1 or floor(k) ~= k then
                return false
            end
            if k > max then
                max = k
            end
            n = n + 1
        end
    end
    if max > 10 and max > arraylen and max > n * 2 then
        return false -- don't create an array with too many holes
    end
    return true, max
end

local escapecodes = {
    ["\""] = "\\\"", ["\\"] = "\\\\", ["\b"] = "\\b", ["\f"] = "\\f",
    ["\n"] = "\\n",  ["\r"] = "\\r",  ["\t"] = "\\t"
}

local function escapeutf8 (uchar)
    local value = escapecodes[uchar]
    if value then
        return value
    end
    local a, b, c, d = strbyte (uchar, 1, 4)
    a, b, c, d = a or 0, b or 0, c or 0, d or 0
    if a <= 0x7f then
        value = a
    elseif 0xc0 <= a and a <= 0xdf and b >= 0x80 then
        value = (a - 0xc0) * 0x40 + b - 0x80
    elseif 0xe0 <= a and a <= 0xef and b >= 0x80 and c >= 0x80 then
        value = ((a - 0xe0) * 0x40 + b - 0x80) * 0x40 + c - 0x80
    elseif 0xf0 <= a and a <= 0xf7 and b >= 0x80 and c >= 0x80 and d >= 0x80 then
        value = (((a - 0xf0) * 0x40 + b - 0x80) * 0x40 + c - 0x80) * 0x40 + d - 0x80
    else
        return ""
    end
    if value <= 0xffff then
        return strformat ("\\u%.4x", value)
    elseif value <= 0x10ffff then
        -- encode as UTF-16 surrogate pair
        value = value - 0x10000
        local highsur, lowsur = 0xD800 + floor (value/0x400), 0xDC00 + (value % 0x400)
        return strformat ("\\u%.4x\\u%.4x", highsur, lowsur)
    else
        return ""
    end
end

local function fsub (str, pattern, repl)
    -- gsub always builds a new string in a buffer, even when no match
    -- exists. First using find should be more efficient when most strings
    -- don't contain the pattern.
    if strfind (str, pattern) then
        return gsub (str, pattern, repl)
    else
        return str
    end
end

local function quotestring (value)
    -- based on the regexp "escapable" in https://github.com/douglascrockford/JSON-js
    value = fsub (value, "[%z\1-\31\"\\\127]", escapeutf8)
    if strfind (value, "[\194\216\220\225\226\239]") then
        value = fsub (value, "\194[\128-\159\173]", escapeutf8)
        value = fsub (value, "\216[\128-\132]", escapeutf8)
        value = fsub (value, "\220\143", escapeutf8)
        value = fsub (value, "\225\158[\180\181]", escapeutf8)
        value = fsub (value, "\226\128[\140-\143\168-\175]", escapeutf8)
        value = fsub (value, "\226\129[\160-\175]", escapeutf8)
        value = fsub (value, "\239\187\191", escapeutf8)
        value = fsub (value, "\239\191[\176-\191]", escapeutf8)
    end
    return "\"" .. value .. "\""
end
json.quotestring = quotestring

local function replace(str, o, n)
    local i, j = strfind (str, o, 1, true)
    if i then
        return strsub(str, 1, i-1) .. n .. strsub(str, j+1, -1)
    else
        return str
    end
end

-- locale independent num2str and str2num functions
local decpoint, numfilter

local function updatedecpoint ()
    decpoint = strmatch(tostring(0.5), "([^05+])")
    -- build a filter that can be used to remove group separators
    numfilter = "[^0-9%-%+eE" .. gsub(decpoint, "[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0") .. "]+"
end

updatedecpoint()

local function num2str (num)
    return replace(fsub(tostring(num), numfilter, ""), decpoint, ".")
end

local function str2num (str)
    local num = tonumber(replace(str, ".", decpoint))
    if not num then
        updatedecpoint()
        num = tonumber(replace(str, ".", decpoint))
    end
    return num
end

local function addnewline2 (level, buffer, buflen)
    buffer[buflen+1] = "\n"
    buffer[buflen+2] = strrep ("  ", level)
    buflen = buflen + 2
    return buflen
end

function json.addnewline (state)
    if state.indent then
        state.bufferlen = addnewline2 (state.level or 0,
            state.buffer, state.bufferlen or #(state.buffer))
    end
end

local encode2 -- forward declaration

local function addpair (key, value, prev, indent, level, buffer, buflen, tables, globalorder, state)
    local kt = type (key)
    if kt ~= 'string' and kt ~= 'number' then
        return nil, "type '" .. kt .. "' is not supported as a key by JSON."
    end
    if prev then
        buflen = buflen + 1
        buffer[buflen] = ","
    end
    if indent then
        buflen = addnewline2 (level, buffer, buflen)
    end
    buffer[buflen+1] = quotestring (key)
    buffer[buflen+2] = ":"
    return encode2 (value, indent, level, buffer, buflen + 2, tables, globalorder, state)
end

local function appendcustom(res, buffer, state)
    local buflen = state.bufferlen
    if type (res) == 'string' then
        buflen = buflen + 1
        buffer[buflen] = res
    end
    return buflen
end

local function exception(reason, value, state, buffer, buflen, defaultmessage)
    defaultmessage = defaultmessage or reason
    local handler = state.exception
    if not handler then
        return nil, defaultmessage
    else
        state.bufferlen = buflen
        local ret, msg = handler (reason, value, state, defaultmessage)
        if not ret then return nil, msg or defaultmessage end
        return appendcustom(ret, buffer, state)
    end
end

function json.encodeexception(reason, value, state, defaultmessage)
    return quotestring("<" .. defaultmessage .. ">")
end

encode2 = function (value, indent, level, buffer, buflen, tables, globalorder, state)
    local valtype = type (value)
    local valmeta = getmetatable (value)
    valmeta = type (valmeta) == 'table' and valmeta -- only tables
    local valtojson = valmeta and valmeta.__tojson
    if valtojson then
        if tables[value] then
            return exception('reference cycle', value, state, buffer, buflen)
        end
        tables[value] = true
        state.bufferlen = buflen
        local ret, msg = valtojson (value, state)
        if not ret then return exception('custom encoder failed', value, state, buffer, buflen, msg) end
        tables[value] = nil
        buflen = appendcustom(ret, buffer, state)
    elseif value == nil then
        buflen = buflen + 1
        buffer[buflen] = "null"
    elseif valtype == 'number' then
        local s
        if value ~= value or value >= huge or -value >= huge then
            -- This is the behaviour of the original JSON implementation.
            s = "null"
        else
            s = num2str (value)
        end
        buflen = buflen + 1
        buffer[buflen] = s
    elseif valtype == 'boolean' then
        buflen = buflen + 1
        buffer[buflen] = value and "true" or "false"
    elseif valtype == 'string' then
        buflen = buflen + 1
        buffer[buflen] = quotestring (value)
    elseif valtype == 'table' then
        if tables[value] then
            return exception('reference cycle', value, state, buffer, buflen)
        end
        tables[value] = true
        level = level + 1
        local isa, n = isarray (value)
        if n == 0 and valmeta and valmeta.__jsontype == 'object' then
            isa = false
        end
        local msg
        if isa then -- JSON array
        buflen = buflen + 1
        buffer[buflen] = "["
        for i = 1, n do
            buflen, msg = encode2 (value[i], indent, level, buffer, buflen, tables, globalorder, state)
            if not buflen then return nil, msg end
            if i < n then
                buflen = buflen + 1
                buffer[buflen] = ","
            end
        end
        buflen = buflen + 1
        buffer[buflen] = "]"
        else -- JSON object
        local prev = false
        buflen = buflen + 1
        buffer[buflen] = "{"
        local order = valmeta and valmeta.__jsonorder or globalorder
        if order then
            local used = {}
            n = #order
            for i = 1, n do
                local k = order[i]
                local v = value[k]
                if v then
                    used[k] = true
                    buflen, msg = addpair (k, v, prev, indent, level, buffer, buflen, tables, globalorder, state)
                    prev = true -- add a seperator before the next element
                end
            end
            for k,v in pairs (value) do
                if not used[k] then
                    buflen, msg = addpair (k, v, prev, indent, level, buffer, buflen, tables, globalorder, state)
                    if not buflen then return nil, msg end
                    prev = true -- add a seperator before the next element
                end
            end
        else -- unordered
        for k,v in pairs (value) do
            buflen, msg = addpair (k, v, prev, indent, level, buffer, buflen, tables, globalorder, state)
            if not buflen then return nil, msg end
            prev = true -- add a seperator before the next element
        end
        end
        if indent then
            buflen = addnewline2 (level - 1, buffer, buflen)
        end
        buflen = buflen + 1
        buffer[buflen] = "}"
        end
        tables[value] = nil
    else
        return exception ('unsupported type', value, state, buffer, buflen,
            "type '" .. valtype .. "' is not supported by JSON.")
    end
    return buflen
end

function json.encode (value, state)
    state = state or {}
    local oldbuffer = state.buffer
    local buffer = oldbuffer or {}
    state.buffer = buffer
    updatedecpoint()
    local ret, msg = encode2 (value, state.indent, state.level or 0,
        buffer, state.bufferlen or 0, state.tables or {}, state.keyorder, state)
    if not ret then
        error (msg, 2)
    elseif oldbuffer == buffer then
        state.bufferlen = ret
        return true
    else
        state.bufferlen = nil
        state.buffer = nil
        return concat (buffer)
    end
end

local function loc (str, where)
    local line, pos, linepos = 1, 1, 0
    while true do
        pos = strfind (str, "\n", pos, true)
        if pos and pos < where then
            line = line + 1
            linepos = pos
            pos = pos + 1
        else
            break
        end
    end
    return "line " .. line .. ", column " .. (where - linepos)
end

local function unterminated (str, what, where)
    return nil, strlen (str) + 1, "unterminated " .. what .. " at " .. loc (str, where)
end

local function scanwhite (str, pos)
    while true do
        pos = strfind (str, "%S", pos)
        if not pos then return nil end
        local sub2 = strsub (str, pos, pos + 1)
        if sub2 == "\239\187" and strsub (str, pos + 2, pos + 2) == "\191" then
            -- UTF-8 Byte Order Mark
            pos = pos + 3
        elseif sub2 == "//" then
            pos = strfind (str, "[\n\r]", pos + 2)
            if not pos then return nil end
        elseif sub2 == "/*" then
            pos = strfind (str, "*/", pos + 2)
            if not pos then return nil end
            pos = pos + 2
        else
            return pos
        end
    end
end

local escapechars = {
    ["\""] = "\"", ["\\"] = "\\", ["/"] = "/", ["b"] = "\b", ["f"] = "\f",
    ["n"] = "\n", ["r"] = "\r", ["t"] = "\t"
}

local function unichar (value)
    if value < 0 then
        return nil
    elseif value <= 0x007f then
        return strchar (value)
    elseif value <= 0x07ff then
        return strchar (0xc0 + floor(value/0x40),
            0x80 + (floor(value) % 0x40))
    elseif value <= 0xffff then
        return strchar (0xe0 + floor(value/0x1000),
            0x80 + (floor(value/0x40) % 0x40),
            0x80 + (floor(value) % 0x40))
    elseif value <= 0x10ffff then
        return strchar (0xf0 + floor(value/0x40000),
            0x80 + (floor(value/0x1000) % 0x40),
            0x80 + (floor(value/0x40) % 0x40),
            0x80 + (floor(value) % 0x40))
    else
        return nil
    end
end

local function scanstring (str, pos)
    local lastpos = pos + 1
    local buffer, n = {}, 0
    while true do
        local nextpos = strfind (str, "[\"\\]", lastpos)
        if not nextpos then
            return unterminated (str, "string", pos)
        end
        if nextpos > lastpos then
            n = n + 1
            buffer[n] = strsub (str, lastpos, nextpos - 1)
        end
        if strsub (str, nextpos, nextpos) == "\"" then
            lastpos = nextpos + 1
            break
        else
            local escchar = strsub (str, nextpos + 1, nextpos + 1)
            local value
            if escchar == "u" then
                value = tonumber (strsub (str, nextpos + 2, nextpos + 5), 16)
                if value then
                    local value2
                    if 0xD800 <= value and value <= 0xDBff then
                        -- we have the high surrogate of UTF-16. Check if there is a
                        -- low surrogate escaped nearby to combine them.
                        if strsub (str, nextpos + 6, nextpos + 7) == "\\u" then
                            value2 = tonumber (strsub (str, nextpos + 8, nextpos + 11), 16)
                            if value2 and 0xDC00 <= value2 and value2 <= 0xDFFF then
                                value = (value - 0xD800)  * 0x400 + (value2 - 0xDC00) + 0x10000
                            else
                                value2 = nil -- in case it was out of range for a low surrogate
                            end
                        end
                    end
                    value = value and unichar (value)
                    if value then
                        if value2 then
                            lastpos = nextpos + 12
                        else
                            lastpos = nextpos + 6
                        end
                    end
                end
            end
            if not value then
                value = escapechars[escchar] or escchar
                lastpos = nextpos + 2
            end
            n = n + 1
            buffer[n] = value
        end
    end
    if n == 1 then
        return buffer[1], lastpos
    elseif n > 1 then
        return concat (buffer), lastpos
    else
        return "", lastpos
    end
end

local scanvalue -- forward declaration

local function scantable (what, closechar, str, startpos, nullval, objectmeta, arraymeta)
    local len = strlen (str)
    local tbl, n = {}, 0
    local pos = startpos + 1
    if what == 'object' then
        setmetatable (tbl, objectmeta)
    else
        setmetatable (tbl, arraymeta)
    end
    while true do
        pos = scanwhite (str, pos)
        if not pos then return unterminated (str, what, startpos) end
        local char = strsub (str, pos, pos)
        if char == closechar then
            return tbl, pos + 1
        end
        local val1, err
        val1, pos, err = scanvalue (str, pos, nullval, objectmeta, arraymeta)
        if err then return nil, pos, err end
        pos = scanwhite (str, pos)
        if not pos then return unterminated (str, what, startpos) end
        char = strsub (str, pos, pos)
        if char == ":" then
            if val1 == nil then
                return nil, pos, "cannot use nil as table index (at " .. loc (str, pos) .. ")"
            end
            pos = scanwhite (str, pos + 1)
            if not pos then return unterminated (str, what, startpos) end
            local val2
            val2, pos, err = scanvalue (str, pos, nullval, objectmeta, arraymeta)
            if err then return nil, pos, err end
            tbl[val1] = val2
            pos = scanwhite (str, pos)
            if not pos then return unterminated (str, what, startpos) end
            char = strsub (str, pos, pos)
        else
            n = n + 1
            tbl[n] = val1
        end
        if char == "," then
            pos = pos + 1
        end
    end
end

scanvalue = function (str, pos, nullval, objectmeta, arraymeta)
    pos = pos or 1
    pos = scanwhite (str, pos)
    if not pos then
        return nil, strlen (str) + 1, "no valid JSON value (reached the end)"
    end
    local char = strsub (str, pos, pos)
    if char == "{" then
        return scantable ('object', "}", str, pos, nullval, objectmeta, arraymeta)
    elseif char == "[" then
        return scantable ('array', "]", str, pos, nullval, objectmeta, arraymeta)
    elseif char == "\"" then
        return scanstring (str, pos)
    else
        local pstart, pend = strfind (str, "^%-?[%d%.]+[eE]?[%+%-]?%d*", pos)
        if pstart then
            local number = str2num (strsub (str, pstart, pend))
            if number then
                return number, pend + 1
            end
        end
        pstart, pend = strfind (str, "^%a%w*", pos)
        if pstart then
            local name = strsub (str, pstart, pend)
            if name == "true" then
                return true, pend + 1
            elseif name == "false" then
                return false, pend + 1
            elseif name == "null" then
                return nullval, pend + 1
            end
        end
        return nil, pos, "no valid JSON value at " .. loc (str, pos)
    end
end

local function optionalmetatables(...)
    if select("#", ...) > 0 then
        return ...
    else
        return {__jsontype = 'object'}, {__jsontype = 'array'}
    end
end

function json.decode (str, pos, nullval, ...)
    local objectmeta, arraymeta = optionalmetatables(...)
    return scanvalue (str, pos, nullval, objectmeta, arraymeta)
end

function json.use_lpeg ()
    local g = require ("lpeg")

    if g.version() == "0.11" then
        error "due to a bug in LPeg 0.11, it cannot be used for JSON matching"
    end

    local pegmatch = g.match
    local P, S, R = g.P, g.S, g.R

    local function ErrorCall (str, pos, msg, state)
        if not state.msg then
            state.msg = msg .. " at " .. loc (str, pos)
            state.pos = pos
        end
        return false
    end

    local function Err (msg)
        return g.Cmt (g.Cc (msg) * g.Carg (2), ErrorCall)
    end

    local SingleLineComment = P"//" * (1 - S"\n\r")^0
    local MultiLineComment = P"/*" * (1 - P"*/")^0 * P"*/"
    local Space = (S" \n\r\t" + P"\239\187\191" + SingleLineComment + MultiLineComment)^0

    local PlainChar = 1 - S"\"\\\n\r"
    local EscapeSequence = (P"\\" * g.C (S"\"\\/bfnrt" + Err "unsupported escape sequence")) / escapechars
    local HexDigit = R("09", "af", "AF")
    local function UTF16Surrogate (match, pos, high, low)
        high, low = tonumber (high, 16), tonumber (low, 16)
        if 0xD800 <= high and high <= 0xDBff and 0xDC00 <= low and low <= 0xDFFF then
            return true, unichar ((high - 0xD800)  * 0x400 + (low - 0xDC00) + 0x10000)
        else
            return false
        end
    end
    local function UTF16BMP (hex)
        return unichar (tonumber (hex, 16))
    end
    local U16Sequence = (P"\\u" * g.C (HexDigit * HexDigit * HexDigit * HexDigit))
    local UnicodeEscape = g.Cmt (U16Sequence * U16Sequence, UTF16Surrogate) + U16Sequence/UTF16BMP
    local Char = UnicodeEscape + EscapeSequence + PlainChar
    local String = P"\"" * g.Cs (Char ^ 0) * (P"\"" + Err "unterminated string")
    local Integer = P"-"^(-1) * (P"0" + (R"19" * R"09"^0))
    local Fractal = P"." * R"09"^0
    local Exponent = (S"eE") * (S"+-")^(-1) * R"09"^1
    local Number = (Integer * Fractal^(-1) * Exponent^(-1))/str2num
    local Constant = P"true" * g.Cc (true) + P"false" * g.Cc (false) + P"null" * g.Carg (1)
    local SimpleValue = Number + String + Constant
    local ArrayContent, ObjectContent

    -- The functions parsearray and parseobject parse only a single value/pair
    -- at a time and store them directly to avoid hitting the LPeg limits.
    local function parsearray (str, pos, nullval, state)
        local obj, cont
        local npos
        local t, nt = {}, 0
        repeat
            obj, cont, npos = pegmatch (ArrayContent, str, pos, nullval, state)
            if not npos then break end
            pos = npos
            nt = nt + 1
            t[nt] = obj
        until cont == 'last'
        return pos, setmetatable (t, state.arraymeta)
    end

    local function parseobject (str, pos, nullval, state)
        local obj, key, cont
        local npos
        local t = {}
        repeat
            key, obj, cont, npos = pegmatch (ObjectContent, str, pos, nullval, state)
            if not npos then break end
            pos = npos
            t[key] = obj
        until cont == 'last'
        return pos, setmetatable (t, state.objectmeta)
    end

    local Array = P"[" * g.Cmt (g.Carg(1) * g.Carg(2), parsearray) * Space * (P"]" + Err "']' expected")
    local Object = P"{" * g.Cmt (g.Carg(1) * g.Carg(2), parseobject) * Space * (P"}" + Err "'}' expected")
    local Value = Space * (Array + Object + SimpleValue)
    local ExpectedValue = Value + Space * Err "value expected"
    ArrayContent = Value * Space * (P"," * g.Cc'cont' + g.Cc'last') * g.Cp()
    local Pair = g.Cg (Space * String * Space * (P":" + Err "colon expected") * ExpectedValue)
    ObjectContent = Pair * Space * (P"," * g.Cc'cont' + g.Cc'last') * g.Cp()
    local DecodeValue = ExpectedValue * g.Cp ()

    function json.decode (str, pos, nullval, ...)
        local state = {}
        state.objectmeta, state.arraymeta = optionalmetatables(...)
        local obj, retpos = pegmatch (DecodeValue, str, pos, nullval, state)
        if state.msg then
            return nil, state.pos, state.msg
        else
            return obj, retpos
        end
    end

    -- use this function only once:
    json.use_lpeg = function () return json end

    json.using_lpeg = true

    return json -- so you can get the module using json = require "dkjson".use_lpeg()
end

if always_try_using_lpeg then
    pcall (json.use_lpeg)
end




-------jsondata--------

jsondata = [[
{
    "cached": 0,
    "data": {
        "activityGroup": {
            "listInfo": [
                {
                    "backgroundColor": "",
                    "bannerId": "22278016",
                    "image": "http://h.hiphotos.baidu.com/nuomi/pic/item/b2de9c82d158ccbf9ba22bc71ed8bc3eb1354135.jpg",
                    "link": "bainuo://web?url=https%3A%2F%2Fshakeduang.nuomi.com%2Fprizedraw%2Factivity%3Fac_id%3D202&hasshare=0&shareurl=https%3A%2F%2Fshakeduang.nuomi.com%2Fprizedraw%2Factivity%3Fac_id%3D202",
                    "subtitle": "抢亿份现金",
                    "subtitleColor": "#666666",
                    "tag": "预热",
                    "title": "吃货福利",
                    "titleColor": "#0088ff"
                },
                {
                    "backgroundColor": "",
                    "bannerId": "20591845",
                    "image": "http://d.hiphotos.baidu.com/nuomi/pic/item/738b4710b912c8fc902fac42fb039245d7882164.jpg",
                    "link": "bainuo://web?needlocation=1&hasshare=1&url=https%3a%2f%2fscene.nuomi.com%2fsoulscene%2fnewusershare%3ftid%3dnahome&hasshare=0&shareurl=",
                    "subtitle": "享叠加优惠",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "新客专享",
                    "titleColor": ""
                },
                {
                    "bannerId": "22258554",
                    "image": "http://g.hiphotos.baidu.com/nuomi/pic/item/9f2f070828381f30afe87554ae014c086f06f05e.jpg",
                    "link": "bainuo://web?url=https%3A%2F%2Fshakeduang.nuomi.com%2Fprizedraw%2Factivity%3Fac_id%3D203%26module%3Dhuodong%26tpl%3Dcangbaotu&hasshare=0&shareurl=https%3A%2F%2Fshakeduang.nuomi.com%2Fprizedraw%2Factivity%3Fac_id%3D203%26module%3Dhuodong%26tpl%3Dcangbaotu",
                    "subtitle": "寻亿外惊喜",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "神秘夺宝",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "21910729",
                    "image": "http://f.hiphotos.baidu.com/nuomi/pic/item/960a304e251f95ca4c88b34bce177f3e660952c9.jpg",
                    "link": "bainuo://web?needlocation=1&hasshare=0&shareurl=ddfctms1&url=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fddfctms25city_na_2_3%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768%26cityid%3D100010000%26sidlist%3D418_416_217_385_326_395_397_253_283_218_373_327_334_376_414_390_347_399_382_377&hasshare=0&shareurl=",
                    "subtitle": "爆品1元起",
                    "subtitleColor": "#666666",
                    "tag": "",
                    "title": "美食大赏",
                    "titleColor": "#ff0000"
                },
                {
                    "backgroundColor": "",
                    "bannerId": "21326293",
                    "image": "http://a.hiphotos.baidu.com/nuomi/pic/item/d009b3de9c82d15894562549870a19d8bd3e4275.jpg",
                    "link": "bainuo://web?needlocation=1&hasshare=0&shareurl=http://huodong.nuomi.com/actshow/mobile/common/short/zzjyhqm&url=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fzzjyhqmna%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768%26cityid%3D100010000%26sidlist%3D418_416_217_385_326_395_397_253_283_218_373_327_334_376_414_390_347_399_382_377&hasshare=0&shareurl=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fzzjyhqm",
                    "subtitle": "最高免单",
                    "subtitleColor": "",
                    "tag": "优惠",
                    "title": "自助聚惠",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "22147003",
                    "image": "http://e.hiphotos.baidu.com/nuomi/pic/item/faf2b2119313b07e76ffc6fe0bd7912396dd8c82.jpg",
                    "link": "bainuo://web?needlocation=1&hasshare=0&shareurl=https://huodong.nuomi.com/actshow/mobile/common/short/mmdjlg_3&url=https%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fmmdjlg_3_1%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=0&shareurl=https%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fmmdjlg_3",
                    "subtitle": "免费抽取",
                    "subtitleColor": "#666666",
                    "tag": "",
                    "title": "老公门票",
                    "titleColor": "#ff7e00"
                },
                {
                    "backgroundColor": "",
                    "bannerId": "21970137",
                    "image": "http://d.hiphotos.baidu.com/nuomi/pic/item/77c6a7efce1b9d163e1d6b9af4deb48f8d546477.jpg",
                    "link": "bainuo://web?needlocation=1&hasshare=0&shareurl=http://huodong.nuomi.com/actshow/mobile/common/short/czkchj&url=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fczkchj_1%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768%26cityid%3D100010000%26sidlist%3D418_416_217_385_326_395_397_253_283_218_373_327_334_376_414_390_347_399_382_377&hasshare=0&shareurl=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fczkchj",
                    "subtitle": "吃货巨优惠",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "储值卡",
                    "titleColor": ""
                }
            ]
        },
        "banner_conf": [
            {
                "banner_id": "20796902",
                "cont": "",
                "goto_type": "8",
                "picture_url": "http://cdn00.baidu-img.cn/timg?nuomina&size=w1080&imgtype=4&sec=1418745600&di=8ebd0cac3e705580df8160182ea69f2b&src=http%3A%2F%2Fd.hiphotos.baidu.com%2Fnuomi%2Fpic%2Fitem%2F0823dd54564e9258b2a489189b82d158cdbf4eb7.jpg"
            },
            {
                "banner_id": "21122383",
                "cont": "bainuo://web?url=http%3A%2F%2Fhuodong.static.nuomi.com%2Fzt%2Fchihuomap%2Fchihuomap_na.html%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=0&shareurl=http%3A%2F%2Fhuodong.static.nuomi.com%2Fzt%2Fchihuomap%2Fchihuomap.html",
                "goto_type": "2",
                "picture_url": "http://cdn00.baidu-img.cn/timg?nuomina&size=w1080&imgtype=4&sec=1418745600&di=2adce568db4f5cdfe5ddb4b07b04ad45&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fnuomi%2Fpic%2Fitem%2F060828381f30e924c5503ec74b086e061c95f754.jpg"
            },
            {
                "banner_id": "21482107",
                "cont": "bainuo://component?url=http%3a%2f%2fm.dianying.baidu.com%2fcms%2factivity%2fwap%2fhigh_na.html%2f214168361439%3fsfrom%3dnewnuomi%26from%3dwebapp%26kehuduan%3d1%26sub_channel%3dnuomi_focus_wap_ryjp&hasshare=0",
                "goto_type": "8",
                "picture_url": "http://cdn00.baidu-img.cn/timg?nuomina&size=w1080&imgtype=4&sec=1418745600&di=57193cc21b0e61cf3e63f960ead4a8eb&src=http%3A%2F%2Fc.hiphotos.baidu.com%2Fnuomi%2Fpic%2Fitem%2F14ce36d3d539b600e80ab84eee50352ac75cb707.jpg"
            }
        ],
        "category": [
            {
                "category_id": "453",
                "category_name": "美食",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/4bed2e738bd4b31c2535c8fb80d6277f9e2ff861.jpg",
                "h5url": "http://m.nuomi.com/326/0-0/0-0-0-0-0?changeCity={{nuomicity}}",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://component?compid=catg&comppage=portal&category=326",
                "tiny_name": ""
            },
            {
                "category_id": "459",
                "category_name": "电影",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/adaf2edda3cc7cd987f069993e01213fb90e9194.jpg",
                "h5url": "https://mdianying.baidu.com/?sfrom=wise_tabbar_app&kehuduan=1",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://apsplugin?pluginurl=bnsdk%3A%2F%2Fcomponent%3Fcompid%3Dmovie%26comppage%3Dportal%26title%3D%25e7%2594%25b5%25e5%25bd%25b1%26sfrom%3Dwise_zj_tabbar&packagename=com.nuomi.dcps.plugin&h5url=https%3A%2F%2Fmdianying.baidu.com%2F%3Fsfrom%3Dwise_tabbar_app%26kehuduan%3D1",
                "tiny_name": ""
            },
            {
                "category_id": "464",
                "category_name": "酒店",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/8694a4c27d1ed21b6cfd71a5aa6eddc451da3fbd.jpg",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bainuo://component?compid=maphotel&comppage=hotellist&src_from=kuang_index",
                "tiny_name": ""
            },
            {
                "category_id": "460",
                "category_name": "KTV",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/e1fe9925bc315c601c6d32d48ab1cb1349547714.jpg",
                "h5url": "http://m.nuomi.com/341/0-0/0-0-0-0-0?changeCity={{nuomicity}}",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://categorylist?category=341&categorykey=snd_cattag_id&categoryname=KTV",
                "tiny_name": ""
            },
            {
                "category_id": "454",
                "category_name": "外卖",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/cdbf6c81800a19d8871adb4534fa828ba61e4650.jpg",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bainuo://component?compid=waimai&comppage=shoplist&vmgdb=0020100181d",
                "tiny_name": ""
            },
            {
                "category_id": "713",
                "category_name": "休闲娱乐",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/4e4a20a4462309f758abf529750e0cf3d6cad6c1.jpg",
                "h5url": "http://m.nuomi.com/320/0-0/0-0-0-0-0?changeCity={{nuomicity}}",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://categorylist?category=320&categorykey=fst_cattag_id&categoryname=%E4%BC%91%E9%97%B2%E5%A8%B1%E4%B9%90",
                "tiny_name": ""
            },
            {
                "category_id": "644",
                "category_name": "飞机票",
                "category_picurl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/%E6%9C%BA%E7%A5%A8.png",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://o2o?url=http%3A%2F%2Flife.m.baidu.com%2Flife%2Fapi%2Fopen%3Fcityid%3D131%26src%3Dhttp%253A%252F%252Fm.baidu.com%252Flightapp%252F6131797%253Fpage%253Dhttp%25253a%25252f%25252fflight.baidu.com%25252fflight%25252fh5redirect%25253fv%25253d1.0%252526type%25253d1%252526client%25253dios%252526app_from%25253dkuang%252526src_from%25253dkuang_life_icon%26stat%3D%257B%2522name%2522%253A%2522Page_LifeHome-Button-Service%2522%252C%2522fe_type_id%2522%253A%2522jipiao%2522%252C%2522fe_item_id%2522%253A2%257D",
                "tiny_name": ""
            },
            {
                "category_id": "468",
                "category_name": "手机充值",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/a5c27d1ed21b0ef4384f071bdac451da80cb3ecb.jpg",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://component?compid=union&comppage=mobilerecharge-home&gatefrom=bdbox_mobilerecharge_gatemis",
                "tiny_name": ""
            },
            {
                "category_id": "461",
                "category_name": "旅游门票",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/0df3d7ca7bcb0a46231ad5796c63f6246b60afb2.jpg",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://component?compid=lvyou&comppage=channel&order_from=shoubai&ext_from=shoubai_baiduboxapp",
                "tiny_name": ""
            },
            {
                "category_id": "463",
                "category_name": "演出票",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/9358d109b3de9c82e772a6cf6b81800a19d8435e.jpg",
                "h5url": "https://yc.baidu.com/?module=home&lnb=1&channel=wise&sub_channel=lifeplus%7Cmovie&nb=1",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://apsplugin?pluginurl=bnsdk%3A%2F%2Fcomponent%3Fcompid%3Dpiao%26comppage%3Dindex%26channel%3Dshoubai%26subChannel%3Dlifeplus&packagename=com.nuomi.dcps.plugin&h5url=https%3A%2F%2Fyc.baidu.com%2F%3Fmodule%3Dhome%26lnb%3D1%26channel%3Dwise%26sub_channel%3Dlifeplus%257Cmovie%26nb%3D1",
                "tiny_name": ""
            },
            {
                "category_id": "687",
                "category_name": "丽人",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/6159252dd42a2834eaea6d305cb5c9ea15cebfb9.jpg",
                "h5url": "http://m.nuomi.com/955/0-0/0-0-0-0-0?changeCity={{nuomicity}}",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://categorylist?category=955&categorykey=snd_cattag_id&categoryname=%E4%B8%BD%E4%BA%BA",
                "tiny_name": ""
            },
            {
                "category_id": "714",
                "category_name": "生活服务",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/a2cc7cd98d1001e93f014f34bf0e7bec54e797cf.jpg",
                "h5url": "http://m.nuomi.com/316/0-0/0-0-0-0-0?changeCity={{nuomicity}}",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://categorylist?category=316&categorykey=fst_cattag_id&categoryname=%E7%94%9F%E6%B4%BB%E6%9C%8D%E5%8A%A1",
                "tiny_name": ""
            },
            {
                "category_id": "645",
                "category_name": "火车票",
                "category_picurl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/%E7%81%AB%E8%BD%A6%E7%A5%A8.png",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://o2o?url=http%3A%2F%2Flife.m.baidu.com%2Flife%2Fapi%2Fopen%3Fcityid%3D131%26src%3Dhttp%253A%252F%252Fm.baidu.com%252Flightapp%252F6417053%253F%2526page%253Dhttp%25253a%25252f%25252fkuai.baidu.com%25252fwebapp%25252ftrain%25252findex.html%25253fus%25253dmobilebd_lifetime_train%26stat%3D%257B%2522name%2522%253A%2522Page_LifeHome-Button-Service%2522%252C%2522fe_type_id%2522%253A%2522huochepiao%2522%252C%2522fe_item_id%2522%253A1%257D",
                "tiny_name": ""
            },
            {
                "category_id": "552",
                "category_name": "汽车票",
                "category_picurl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/%E6%B1%BD%E8%BD%A6%E7%A5%A8.png",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://o2o?url=http%3A%2F%2Flife.m.baidu.com%2Flife%2Fapi%2Fopen%3Fcityid%3D131%26src%3Dhttp%253A%252F%252Fm.baidu.com%252Flightapp%252F6417053%253Ffrom_id%253Dchannel%2526channel_id%253Dsearchbox_pindaodaohang%2526page%253Dhttp%25253a%25252f%25252fkuai.baidu.com%25252fwebapp%25252fbus%25252findex.html%25253fus%25253dmobilebd_life%26stat%3D%257B%2522name%2522%253A%2522Page_LifeHome-Button-Service%2522%252C%2522fe_type_id%2522%253A%2522qichepiao%2522%252C%2522fe_item_id%2522%253A3%257D",
                "tiny_name": ""
            },
            {
                "category_id": "457",
                "category_name": "自助餐",
                "category_picurl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/jingang/01-%E8%87%AA%E5%8A%A9%E9%A4%90.png",
                "h5url": "http://m.nuomi.com/392/0-0/0-0-0-0-0?changeCity={{nuomicity}}",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://categorylist?category=392&categorykey=snd_cattag_id&categoryname=%E8%87%AA%E5%8A%A9%E9%A4%90",
                "tiny_name": ""
            },
            {
                "category_id": "470",
                "category_name": "查违章",
                "category_picurl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/%E8%BF%9D%E7%AB%A0%E7%BC%B4%E8%B4%B9.png",
                "has_icon": 0,
                "icon_url": "",
                "schema": "",
                "tiny_name": ""
            },
            {
                "category_id": "469",
                "category_name": "查快递",
                "category_picurl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/%E6%9F%A5%E5%BF%AB%E9%80%92.png",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://o2o?url=http%3A%2F%2Flife.m.baidu.com%2Flife%2Fapi%2Fopen%3Fcityid%3D131%26src%3Dhttp%253A%252F%252Fm.baidu.com%252Flightapp%252F3211731%253Ffrom_id%253Dchannel%2526channel_id%253Dfast_mail%2526page%253Dhttp%25253A%25252F%25252Fm.lvmae.com%26stat%3D%257B%2522name%2522%253A%2522Page_LifeHome-Button-Service%2522%252C%2522fe_type_id%2522%253A%2522chakuaidi%2522%252C%2522fe_item_id%2522%253A6%257D",
                "tiny_name": ""
            },
            {
                "category_id": "650",
                "category_name": "百度理财",
                "category_picurl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/%E7%99%BE%E5%BA%A6%E7%90%86%E8%B4%A2.png",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://o2o?url=http%3A%2F%2Flife.m.baidu.com%2Flife%2Fapi%2Fopen%3Fcityid%3D131%26src%3Dhttp%253A%252F%252Fwww.dwz.cn%252F2k1mgR%26stat%3D%257B%2522name%2522%253A%2522jrlc%2522%257D",
                "tiny_name": ""
            },
            {
                "category_id": "715",
                "category_name": "代金券",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/e7cd7b899e510fb33ab4e8d2de33c895d0430cc1.jpg",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://o2o?url=http%3A%2F%2Fm.nuomi.com%2F1000107%2F0-0%2F0-0-0-0-0%3Fcid%3Dwise_life_quan%26box_citycode%3D131%26bdboxinfo%3D%257B%2522ofniw%2522%253A%252212944404_4845264_1461864394241%2522%252C%2522logid%2522%253A%25221618839194%2522%257D%26bd_framework%3D1%26bd_vip%3D1%26bd_from_id%3Dchannel%26bd_ref_id%3Dlight_null%26bd_channel_id%3Dsearchbox_pindaodaohang%26bd_sub_page%3Dlight_null%26bd_source_light%3D2924586",
                "tiny_name": ""
            },
            {
                "category_id": "0",
                "category_name": "全部分类",
                "category_picurl": "http://hiphotos.baidu.com/bainuo/pic/item/9f510fb30f2442a7ab90a79ed643ad4bd113026a.jpg",
                "has_icon": 0,
                "icon_url": "",
                "schema": "bnsdk://o2o?url=http%3A%2F%2Flife.m.baidu.com%2Flife%2Fservicelist%3Fcity_id%3D131",
                "tiny_name": ""
            }
        ],
        "daoDianfu": [
            {
                "advType": "15115056",
                "cont": "bainuo://searchresult?keyword=到店付&hasshare=0&shareurl=",
                "gotoType": "8",
                "pictureUrl": "http://tuanimg5.baidu.com/data/zyj_104_104_f87fcbeca4ac12bc0d291f70d0deeb83",
                "subTitle": "到店支付五折起",
                "subTitleColor": "#333333",
                "titlePictureUrl": "http://tuanimg5.baidu.com/data/zyj_244_54_6b8bf739b6af2a6fc4a4a8da86796192"
            },
             {
                "advType": "15115056",
                "cont": "bainuo://searchresult?keyword=到店付&hasshare=0&shareurl=",
                "gotoType": "8",
                "pictureUrl": "http://tuanimg5.baidu.com/data/zyj_104_104_f87fcbeca4ac12bc0d291f70d0deeb83",
                "subTitle": "到店支付五折起",
                "subTitleColor": "#333333",
                "titlePictureUrl": "http://tuanimg5.baidu.com/data/zyj_244_54_6b8bf739b6af2a6fc4a4a8da86796192"
            }
        ],
        "entertainment": {
            "banner": [
                {
                    "bannerId": "22150189",
                    "image": "http://h.hiphotos.baidu.com/nuomi/pic/item/7af40ad162d9f2d3f8ac6112aeec8a136227cc8a.jpg",
                    "link": "bainuo://web?needlocation=1&hasshare=0&shareurl=https://huodong.nuomi.com/actshow/mobile/common/short/xrxdthsmf_1&url=https%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fxrxdthsmf%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=0&shareurl=https%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Flrxdththreemj_1"
                },
                {
                    "bannerId": "22129645",
                    "image": "http://f.hiphotos.baidu.com/nuomi/pic/item/3812b31bb051f8198b8ec1b0ddb44aed2f73e7a5.jpg",
                    "link": "bainuo://web?needlocation=1&hasshare=0&shareurl=https://huodong.nuomi.com/actshow/mobile/common/short/QZSY_1&url=https%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2FQZSY%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=0&shareurl=https%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2FQZSY_1"
                }
            ],
            "ceilTitle": "休闲娱乐",
            "descColor": "#88888d",
            "descTitle": "更多娱乐",
            "listInfo": [
                {
                    "backgroundColor": "",
                    "bannerId": "20662975",
                    "image": "http://g.hiphotos.baidu.com/nuomi/pic/item/a686c9177f3e67093f41b00c3cc79f3df9dc5584.jpg",
                    "link": "bainuo://component?compid=movie&comppage=portal&_from=index&title=电影·演出&sub_channel=nuomi_block_wap_xiuxian&hasshare=0&shareurl=",
                    "subtitle": "美国队长3",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "震撼上映",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "20378031",
                    "image": "http://a.hiphotos.baidu.com/nuomi/pic/item/5882b2b7d0a20cf4e1b1512c71094b36acaf9924.jpg",
                    "link": "bainuo://component?compid=piao&comppage=index&title=演出赛事&hasshare=0&shareurl=",
                    "subtitle": "乐享生活",
                    "subtitleColor": "#ffc368",
                    "tag": "",
                    "title": "演出赛事",
                    "titleColor": "#ff9900"
                },
                {
                    "backgroundColor": "",
                    "bannerId": "21964087",
                    "image": "http://d.hiphotos.baidu.com/nuomi/pic/item/dcc451da81cb39db354f02abd7160924aa1830bb.jpg",
                    "link": "bainuo://web?needlocation=1&url=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fwensha-artist%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=0&shareurl=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fwensha-artist",
                    "subtitle": "劲爆夜现场",
                    "subtitleColor": "#ffc368",
                    "tag": "狂欢",
                    "title": "私密趴",
                    "titleColor": "#ff9900"
                },
                {
                    "backgroundColor": "",
                    "bannerId": "20361246",
                    "image": "http://f.hiphotos.baidu.com/nuomi/pic/item/7e3e6709c93d70cf1ec00cfeffdcd100baa12b0e.jpg",
                    "link": "bainuo://component?compid=parent_offspring&comppage=home&hasshare=0&shareurl=",
                    "subtitle": "让爱更近",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "亲子娱乐",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "20361246",
                    "image": "http://f.hiphotos.baidu.com/nuomi/pic/item/7e3e6709c93d70cf1ec00cfeffdcd100baa12b0e.jpg",
                    "link": "bainuo://component?compid=parent_offspring&comppage=home&hasshare=0&shareurl=",
                    "subtitle": "让爱更近",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "亲子娱乐",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "20361246",
                    "image": "http://f.hiphotos.baidu.com/nuomi/pic/item/7e3e6709c93d70cf1ec00cfeffdcd100baa12b0e.jpg",
                    "link": "bainuo://component?compid=parent_offspring&comppage=home&hasshare=0&shareurl=",
                    "subtitle": "让爱更近",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "亲子娱乐",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "20361246",
                    "image": "http://f.hiphotos.baidu.com/nuomi/pic/item/7e3e6709c93d70cf1ec00cfeffdcd100baa12b0e.jpg",
                    "link": "bainuo://component?compid=parent_offspring&comppage=home&hasshare=0&shareurl=",
                    "subtitle": "让爱更近",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "亲子娱乐",
                    "titleColor": ""
                }
            ],
            "moreLink": "bainuo://component?compid=catg&comppage=portal&category=320&hasshare=0&shareurl=",
            "titleColor": "#ff9900"
        },
        "hotService": {
            "banner": [
                {
                    "bannerId": "22126489",
                    "image": "http://h.hiphotos.baidu.com/nuomi/pic/item/d0c8a786c9177f3e90d477f477cf3bc79e3d5663.jpg",
                    "link": "bainuo://web?needlocation=1&hasshare=0&shareurl=https://huodong.nuomi.com/actshow/mobile/common/short/xsy_1&url=https%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fxsy_1_1_1_1%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=0&shareurl=https%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fxsy_1"
                },
                {
                    "bannerId": "21964059",
                    "image": "http://b.hiphotos.baidu.com/nuomi/pic/item/83025aafa40f4bfb5a5ce1a9044f78f0f63618ba.jpg",
                    "link": "bainuo://tuandetail?tuanid=13344722"
                },
                {
                    "bannerId": "20998041",
                    "image": "http://b.hiphotos.baidu.com/nuomi/pic/item/e850352ac65c10385a95aa34b5119313b17e8958.jpg",
                    "link": "bainuo://web?needlocation=1&url=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fxzysyztd%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=0&shareurl=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fxzysyztd_wap"
                }
            ],
            "ceilTitle": "精选服务",
            "descColor": "#88888d",
            "descTitle": "更多服务",
            "listInfo": [
                {
                    "backgroundColor": "",
                    "bannerId": "21453253",
                    "image": "http://e.hiphotos.baidu.com/nuomi/pic/item/86d6277f9e2f0708d4780af4ee24b899a801f2c1.jpg",
                    "link": "bainuo://component?compid=union&comppage=mobilerecharge-home&gatefrom=tp_mobilerecharge_gatetofu&hasshare=1&shareurl=",
                    "subtitle": "最高减8元",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "充值立减",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "22297061",
                    "image": "http://e.hiphotos.baidu.com/nuomi/pic/item/738b4710b912c8fcc7b67d33fb039245d7882182.jpg",
                    "link": "bainuo://web?needlocation=1&hasshare=0&shareurl=http://huodong.nuomi.com/actshow/mobile/common/short/qiche_mr5zheqi_1&url=https%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fqiche_mr5zheqi%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=0&shareurl=https%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fqiche_mr5zheqi_1",
                    "subtitle": "焕新5折起",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "汽车美容",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "22036955",
                    "image": "http://a.hiphotos.baidu.com/nuomi/pic/item/4e4a20a4462309f7206e1def750e0cf3d6cad6ce.jpg",
                    "link": "bainuo://web?url=http%3A%2F%2Fnuomi.mall.baidu.com%2Factivity%2FspecialSale%3Ftpl%3DnuomiZhuanti1%26key%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=0&shareurl=http%3A%2F%2Fnuomi.mall.baidu.com%2Factivity%2FspecialSale%3Ftpl%3DnuomiZhuanti1",
                    "subtitle": "18.9元",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "5斤香梨",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "21011320",
                    "image": "http://c.hiphotos.baidu.com/nuomi/pic/item/77094b36acaf2eddf94e6a1d8a1001e938019382.jpg",
                    "link": "bainuo://web?url=http%3A%2F%2Fmarketing.lechebang.com%2Findex.php%3Fr%3Dbainuo%2Findex%26alliance_id%3D1%26site_id%3D2%26channel_id%3D182%26key%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=1&shareurl=",
                    "subtitle": "领百元红包",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "4S保养",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "21011320",
                    "image": "http://c.hiphotos.baidu.com/nuomi/pic/item/77094b36acaf2eddf94e6a1d8a1001e938019382.jpg",
                    "link": "bainuo://web?url=http%3A%2F%2Fmarketing.lechebang.com%2Findex.php%3Fr%3Dbainuo%2Findex%26alliance_id%3D1%26site_id%3D2%26channel_id%3D182%26key%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=1&shareurl=",
                    "subtitle": "领百元红包",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "4S保养",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "21011320",
                    "image": "http://c.hiphotos.baidu.com/nuomi/pic/item/77094b36acaf2eddf94e6a1d8a1001e938019382.jpg",
                    "link": "bainuo://web?url=http%3A%2F%2Fmarketing.lechebang.com%2Findex.php%3Fr%3Dbainuo%2Findex%26alliance_id%3D1%26site_id%3D2%26channel_id%3D182%26key%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=1&shareurl=",
                    "subtitle": "领百元红包",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "4S保养",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "21011320",
                    "image": "http://c.hiphotos.baidu.com/nuomi/pic/item/77094b36acaf2eddf94e6a1d8a1001e938019382.jpg",
                    "link": "bainuo://web?url=http%3A%2F%2Fmarketing.lechebang.com%2Findex.php%3Fr%3Dbainuo%2Findex%26alliance_id%3D1%26site_id%3D2%26channel_id%3D182%26key%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=1&shareurl=",
                    "subtitle": "领百元红包",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "4S保养",
                    "titleColor": ""
                }
            ],
            "moreLink": "bainuo://component?compid=catg&comppage=portal&category=316&hasshare=1&shareurl=",
            "titleColor": "#00a814"
        },
        "meiRiBaoKuan": [
            {
                "advType": "16874811",
                "cont": "bainuo://web?needlocation=1&hasshare=1&url=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fyangxua_hsak_1%3Fallcity%3D1%26key%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768&hasshare=1&shareurl=",
                "gotoType": "8",
                "pictureUrl": "http://b.hiphotos.baidu.com/nuomi/pic/item/4610b912c8fcc3cea2579e8f9545d688d53f20f2.jpg",
                "subTitle": "狂享折上折",
                "subTitleColor": "#333333",
                "titlePictureUrl": "http://tuanimg4.baidu.com/data/zyj_244_54_b44d7cf32f8e8eed3af47f9ff30bf4d6"
            }
        ],
        "meishiGroup": {
            "banner": [
                {
                    "bannerId": "22180495",
                    "image": "http://h.hiphotos.baidu.com/nuomi/pic/item/f2deb48f8c5494ee5f95e4e42af5e0fe98257e9c.jpg",
                    "link": "bainuo://web?needlocation=1&hasshare=0&shareurl=http://huodong.nuomi.com/actshow/mobile/common/short/xwc_wap&url=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fxwc_na%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768%26cityid%3D100010000%26sidlist%3D418_416_217_385_326_395_397_253_283_218_373_327_334_376_414_390_347_399_382_377&hasshare=0&shareurl=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fxwc_wap"
                },
                {
                    "bannerId": "21029985",
                    "image": "http://e.hiphotos.baidu.com/nuomi/pic/item/d788d43f8794a4c211ae8cdd09f41bd5ac6e39b2.jpg",
                    "link": ""
                },
                {
                    "bannerId": "21143941",
                    "image": "http://a.hiphotos.baidu.com/nuomi/pic/item/2cf5e0fe9925bc31bcc5876e59df8db1ca1370a8.jpg",
                    "link": "bainuo://topic?specialid=343511"
                }
            ],
            "ceilTitle": "天天美味",
            "descColor": "#88888d",
            "descTitle": "更多美味",
            "listInfo": [
                {
                    "backgroundColor": "",
                    "bannerId": "21900173",
                    "image": "http://h.hiphotos.baidu.com/nuomi/pic/item/a50f4bfbfbedab6454ffee33f036afc378311eb7.jpg",
                    "link": "bainuo://web?needlocation=1&hasshare=1&url=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Faydsscl_xfy%3Fkey%3D558ef232a4594ba62135f33f9a59d6bf%26cuid%3DB968836AB5A191A247A620F8C37DADD3%7C662909420130768%26cityid%3D100010000%26sidlist%3D418_416_217_385_326_395_397_253_283_218_373_327_334_376_414_390_347_399_382_377&hasshare=0&shareurl=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Faydsscl_xfy_1",
                    "subtitle": "9元有肉香",
                    "subtitleColor": "#ff9999",
                    "tag": "爆款",
                    "title": "小肥羊",
                    "titleColor": "#ff3333"
                },
                {
                    "backgroundColor": "",
                    "bannerId": "21170698",
                    "image": "http://e.hiphotos.baidu.com/nuomi/pic/item/0824ab18972bd407790e680e7c899e510eb30973.jpg",
                    "link": "",
                    "subtitle": "送乐视会员",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "自助有礼",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "21826870",
                    "image": "http://f.hiphotos.baidu.com/nuomi/pic/item/08f790529822720e51ad0c067ccb0a46f31fabef.jpg",
                    "link": "",
                    "subtitle": "工作餐5折",
                    "subtitleColor": "#ff9999",
                    "tag": "",
                    "title": "轻食快餐",
                    "titleColor": "#ff3333"
                },
                {
                    "backgroundColor": "",
                    "bannerId": "20482927",
                    "image": "http://d.hiphotos.baidu.com/nuomi/pic/item/d31b0ef41bd5ad6e66be451e86cb39dbb7fd3cfa.jpg",
                    "link": "bainuo://component?compid=waimai&comppage=shoplist",
                    "subtitle": "外卖新用户",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "立减15",
                    "titleColor": ""
                },
                {
                    "backgroundColor": "",
                    "bannerId": "20482927",
                    "image": "http://d.hiphotos.baidu.com/nuomi/pic/item/d31b0ef41bd5ad6e66be451e86cb39dbb7fd3cfa.jpg",
                    "link": "bainuo://component?compid=waimai&comppage=shoplist",
                    "subtitle": "外卖新用户",
                    "subtitleColor": "",
                    "tag": "",
                    "title": "立减15",
                    "titleColor": ""
                }
            ],
            "moreLink": "bainuo://component?compid=catg&comppage=portal&category=326&hasshare=0&shareurl=",
            "titleColor": "#ff3333"
        },
        "nuomiAds": [
            {
                "bannerId": "730",
                "cont": "bnsdk://o2o?url=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fxzysyztd_sb%3F",
                "end_time": "2016-05-19",
                "gotoType": "5",
                "pictureUrl": "http://s0.nuomi.bdimg.com/nuomijiehun/2016-5-4-%E7%BB%93%E5%A9%9A-%E5%86%99%E7%9C%9F-%E4%B8%AD%E9%83%A8720-115.jpg",
                "start_time": "2016-04-13"
            },
            {
                "bannerId": "728",
                "cont": "bnsdk://o2o?url=https%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fleshijuyouhui-shoubai%3Fcityid%3D100010000",
                "end_time": "2016-05-19",
                "gotoType": "5",
                "pictureUrl": "http://s0.nuomi.bdimg.com/%E4%B9%90%E8%A7%86%E4%BC%9A%E5%91%98720x172.jpg",
                "start_time": "2016-05-10"
            }
        ],
        "nuomiChannel": [
            {
                "advDesc": "聚餐领返现",
                "advDescColor": "#88888d",
                "advName": "自助聚惠",
                "advNameColor": "#55555d",
                "bannerId": "729",
                "cont": "bnsdk://o2o?url=https%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fzzjyh%3Fcityid%3D100010000",
                "end_time": "2016-05-19",
                "gotoType": "8",
                "pictureUrl": "http://s0.nuomi.bdimg.com/6.4-%E8%87%AA%E5%8A%A9%E9%A4%90104.png",
                "start_time": "2016-05-09"
            },
            {
                "advDesc": "草莓音乐节",
                "advDescColor": "#88888d",
                "advName": "机票酒店",
                "advNameColor": "#55555d",
                "bannerId": "722",
                "cont": "bnsdk://o2o?url=http%3A%2F%2Fmap.baidu.com%2Fmobile%2Fwebapp%2Fplace%2Fyunying%2Fpname%3Dcaomei%26fr%3Dnuomidfk",
                "end_time": "2017-03-10",
                "gotoType": "8",
                "pictureUrl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/huodong/%E6%9C%BA%E7%A5%A8%E9%85%92%E5%BA%97.JPG",
                "start_time": "2016-03-10"
            },
            {
                "advDesc": "越聚越划算",
                "advDescColor": "#88888d",
                "advName": "自助聚餐",
                "advNameColor": "#55555d",
                "bannerId": "723",
                "cont": "bnsdk://categorylist?category=392&categorykey=snd_cattag_id&categoryname=%E8%87%AA%E5%8A%A9%E9%A4%90",
                "end_time": "2017-03-10",
                "gotoType": "8",
                "pictureUrl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/huodong/%E8%81%9A%E4%BC%98%E6%83%A0.JPG",
                "start_time": "2016-03-10"
            },
            {
                "advDesc": "狂享折上折",
                "advDescColor": "#88888d",
                "advName": "每日惠",
                "advNameColor": "#55555d",
                "bannerId": "725",
                "cont": "bnsdk://web?url=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fyangxua_hsak_1%3Fallcity%3D1%26cityid%3D100010000",
                "end_time": "2016-05-17",
                "gotoType": "8",
                "pictureUrl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/huodong/%E6%AF%8F%E6%97%A5%E6%83%A0.JPG",
                "start_time": "2016-04-25"
            },
            {
                "advDesc": "美味刷不停",
                "advDescColor": "#88888d",
                "advName": "红红火火",
                "advNameColor": "#55555d",
                "bannerId": "700",
                "cont": "bnsdk://categorylist?category=364&categorykey=snd_cattag_id&categoryname=%E7%81%AB%E9%94%85",
                "end_time": "2017-03-10",
                "gotoType": "8",
                "h5url": "http://m.nuomi.com/364/0-0/0-0-0-0-0?changeCity={{nuomicity}}",
                "pictureUrl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/huodong/%E5%9B%9B%E6%A0%BC%E9%94%85104.png",
                "start_time": "2016-03-10"
            },
            {
                "advDesc": "告别公交",
                "advDescColor": "#88888d",
                "advName": "顺风车",
                "advNameColor": "#55555d",
                "bannerId": "466",
                "cont": "bnsdk://o2o?url=http%3A%2F%2Fcarpo.baidu.com%2Fmain%2Fwebapp%3Fpage%3Dindex%26third_party%3D0020100219p%26bd_from_id%3Dchannel%26bd_ref_id%3Dlight_null%26bd_channel_id%3Dsearchbox_life_service_taxi%26bd_sub_page%3Dlight_null%26bd_source_light%3D5829787",
                "end_time": "2017-03-10",
                "gotoType": "8",
                "pictureUrl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/%E4%BA%B2%E5%AD%90%E6%B8%B8104.png",
                "start_time": "2016-03-10"
            },
            {
                "advDesc": "美味不用等",
                "advDescColor": "#88888d",
                "advName": "品牌快餐",
                "advNameColor": "#55555d",
                "bannerId": "702",
                "cont": "bnsdk://categorylist?category=380&categorykey=snd_cattag_id&categoryname=%E5%B0%8F%E5%90%83%E5%BF%AB%E9%A4%90",
                "end_time": "2017-03-10",
                "gotoType": "8",
                "h5url": "http://m.nuomi.com/380/0-0/0-0-0-0-0?changeCity={{nuomicity}}",
                "pictureUrl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/%E5%BF%AB%E9%A4%90104.png",
                "start_time": "2016-03-10"
            },
            {
                "advDesc": "超值抱回家",
                "advDescColor": "#88888d",
                "advName": "上门大厨",
                "advNameColor": "#55555d",
                "bannerId": "600",
                "cont": "bnsdk://o2o?url=http%3A%2F%2Fwww.idachu.cn%2F%3Fbd_source_light%3D5003596%26bd_from_id%3Dlight_null%26bd_ref_id%3Dlight_null%26bd_channel_id%3Dlight_null%26bd_sub_page%3Dlight_null%26bd_source_light%3D5003596",
                "end_time": "2017-03-10",
                "gotoType": "8",
                "pictureUrl": "http://tuanimg2.baidu.com/data/zyj_104_104_3b6ddb2d5646d782d65585cd2e259a03",
                "start_time": "2016-03-10"
            },
            {
                "advDesc": "低至五折",
                "advDescColor": "#88888d",
                "advName": "上门推拿",
                "advNameColor": "#55555d",
                "bannerId": "601",
                "cont": "bnsdk://o2o?url=http%3A%2F%2F3600.baidu.com%2Fbdoor%2Fproductlist%3Fformat%3D203%26tp%3D%25E4%25B8%258A%25E9%2597%25A8%25E6%258E%25A8%25E6%258B%25BF%25E6%258C%2589%25E6%2591%25A9%26srcid%3D3192%26query%3D%25E6%258C%2589%25E6%2591%25A9%26cityname%3D%25E5%258C%2597%25E4%25BA%25AC%26uniq_sign%3D1627022341462349700%26tn%3Dboxlifeanmo%26bd_source_light%3D5833761%26bd_from_id%3Dchannel%26bd_ref_id%3Dlight_null%26bd_channel_id%3Dsearchbox_life_service_anmo%26bd_sub_page%3Dlight_null%26bd_source_light%3D6131797",
                "end_time": "2017-03-10",
                "gotoType": "8",
                "pictureUrl": "http://tuanimg6.baidu.com/data/zyj_104_104_38658375bb54ca8341fb7452befe07f9",
                "start_time": "2016-03-10"
            }
        ],
        "nuomiNews": [],
        "topten": {
            "activetime": [
                {
                    "endtime": 1462946400,
                    "starttime": 1462932000
                },
                {
                    "endtime": 1462971600,
                    "starttime": 1462957200
                },
                {
                    "endtime": 1463032800,
                    "starttime": 1463018400
                },
                {
                    "endtime": 1463058000,
                    "starttime": 1463043600
                }
            ],
            "list": [
                {
                    "brand": "汉丽轩烤肉超市",
                    "current_price": 2500,
                    "deal_id": "12978541",
                    "market_price": 5900,
                    "na_logo": "http://cdn00.baidu-img.cn/timg?nuomina&size=8&quality=70&sec=1418745600&di=3f2e8836a14fc96140a1aa536a774849&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fnuomi%2Fpic%2Fitem%2Fb2de9c82d158ccbf0302b4751fd8bc3eb03541c6.jpg"
                },
                {
                    "brand": "DQ",
                    "current_price": 100,
                    "deal_id": "10281455",
                    "market_price": 1500,
                    "na_logo": "http://cdn00.baidu-img.cn/timg?nuomina&size=8&quality=70&sec=1418745600&di=ac77b46b09b5f44e6c26344fe6daffcd&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fnuomi%2Fpic%2Fitem%2F9213b07eca806538e2c5e27c90dda144ad3482b6.jpg"
                },
                {
                    "brand": "福成肥牛",
                    "current_price": 2540,
                    "deal_id": "6921734",
                    "market_price": 5300,
                    "na_logo": "http://cdn00.baidu-img.cn/timg?nuomina&size=8&quality=70&sec=1418745600&di=f18d53d445b085ccebec36d24e55d532&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fnuomi%2Fpic%2Fitem%2Fb3fb43166d224f4a70a1a5e50ff790529822d108.jpg"
                }
            ],
            "target_url": "bnsdk://web?url=http%3A%2F%2Ft10.nuomi.com%2Fwebapp%2Fsdk%2Ftopten%3Ffrom%3Dfr_mapsdk_t10%26tid%3Dt10_sdk%26needstorecard%3D0%26areaId%3D100010000%26location%3D40.04882081173552%2C116.28054993461932"
        },
        "userBlock": [
            {
                "advDesc": "1元抽小米Note顶配版",
                "advDescColor": "#333333",
                "advName": "抽奖许愿",
                "advNameColor": "#ff0000",
                "bannerId": "537",
                "cont": "bnsdk://o2o?url=http%3A%2F%2Flife.m.baidu.com%2Flife%2FluckyDraw%3F%26bdboxinfo%3D%257b%2522ofniw%2522%253a%2522%2522%252c%2522browser_citycode%2522%253a%2522%2522%252c%2522current_citycode%2522%253a%2522%257b%257bcitycode%257d%257d%2522%257d",
                "end_time": "2017-03-10",
                "gotoType": "8",
                "longAdvDesc": "1元抽小米Note顶配版",
                "longAdvDescColor": "#333333",
                "longAdvName": "抽奖许愿",
                "longAdvNameColor": "#ff0000",
                "pictureUrl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/huodong/%E6%89%8B%E6%9C%BA104.png",
                "pictureUrlThumbnail": "http://s0.nuomi.bdimg.com/shoubai_nuomi/huodong/%E6%89%8B%E6%9C%BA104.png",
                "start_time": "2016-03-10"
            },
            {
                "advDesc": "豪韵音响30元优惠专享",
                "advDescColor": "#333333",
                "advName": "1分专享",
                "advNameColor": "#ff4683",
                "bannerId": "538",
                "cont": "bnsdk://o2o?url=http%3A%2F%2Flife.m.baidu.com%2Flife%2Fexclusivebuy%3F%26bdboxinfo%3D%257b%2522ofniw%2522%253a%2522%2522%252c%2522browser_citycode%2522%253a%2522%2522%252c%2522current_citycode%2522%253a%2522%257b%257bcitycode%257d%257d%2522%257d",
                "end_time": "2017-03-10",
                "gotoType": "8",
                "longAdvDesc": "豪韵音响30元优惠专享",
                "longAdvDescColor": "#333333",
                "longAdvName": "1分专享",
                "longAdvNameColor": "#ff4683",
                "pictureUrl": "http://s0.nuomi.bdimg.com/shoubai_nuomi/huodong/%E4%B8%80%E5%88%86%E4%B8%93%E4%BA%AB.PNG",
                "pictureUrlThumbnail": "http://s0.nuomi.bdimg.com/shoubai_nuomi/huodong/%E4%B8%80%E5%88%86%E4%B8%93%E4%BA%AB.PNG",
                "start_time": "2016-03-10"
            }
        ]
    },
    "errmsg": "success",
    "errno": 0,
    "msg": "success",
    "serverlogid": 2418637233,
    "serverstatus": 0,
    "timestamp": 1462959619
}
]]



