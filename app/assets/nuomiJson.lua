local json = require("dkjson")
local json_str = require("jsondata")



--print(json_string)
--print(type(json_string))
local function main()
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
      print(key.."\t"..value)
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

main();
