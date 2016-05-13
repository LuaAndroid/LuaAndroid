


function printlog(str)
    return nmdebug.logd("lua log : "..str)
end
--此函数由Java代码调用。接受一个参数，并返回一个字符串
function getFunctionInLuaFile(key)
    return ' Function in Lua file . Return : ' .. key .. '!'
end

--此函数由Java代码调用。接受三个参数。并调用这些Android组件的方法。
function callAndroidApi(context, layout, tip)

    --     --创建一个Android TextView
    tv = luajava.newInstance("android.widget.TextView", context)
    --调用TextView的方法
    tv:setText(tip)
    --调用Layout的方法
    layout:addView(tv)
    printlog("layout   "..type(layout))
    printlog("tip   "..type(tip))
end



function launchSetting(context)

    intent = luajava.newInstance("android.content.Intent")
    c = luajava.newInstance("android.content.ComponentName", "com.android.settings", "com.android.settings.Settings")
    intent:setFlags(intent.FLAG_ACTIVITY_NEW_TASK);
    intent:setComponent(c)
    context:startActivity(intent)
end

-- 启动 intent  bind 一个Java实例，调用static 方法
function launchIntent(context)
    -- new 一个java 实例
    local intent = luajava.newInstance("android.content.Intent")
    intent:addFlags(0x10000000)
    intent:setAction("android.intent.action.VIEW")
    -- bind 一个Java实例，调用static 方法
    local uri = luajava.bindClass("android.net.Uri")
    intent:setData(uri.parse(uri, "http://www.baidu.com"))
    context:startActivity(intent);
end

-- -- 启动 intent new 一个java 实例
function launchActivity(context)
    intent = luajava.newInstance("android.content.Intent")
    c = luajava.newInstance("android.content.ComponentName", "dev.bnna.androlua", "dev.bnna.androlua.CustomViewActivity")
    intent:setFlags(intent.FLAG_ACTIVITY_NEW_TASK);
    intent:setComponent(c)
    context:startActivity(intent)
end

-- lua 实现方法，增加一个Button，点击Button， Toast显示Button标题。
function addButton(context, layout, drawable, bitmap, obj)
    btn = luajava.newInstance("android.widget.ImageView", context)
--    --    btn = luajava.newInstance("android.widget.Button",context)
--
--    --
--    local androidString = luajava.bindClass("dev.bnna.androlua.R$string")
--    --    btn:setText(androidString.hello)
--
--    -- 设置nackgroudColor 成功
--    -- local color = luajava.newInstance("android.graphics.Color")
--    -- btn:setBackgroundColor(color.red(color,70))
--    -- btn:setBackgroundColor(color.RED)
--    --
--    --    local drawable = luajava.bindClass("dev.bnna.androlua.R$drawable")
--    --    btn:setImageDrawable(drawable.icon)
--    --    btn:setImageDrawable(drawable)
--        btn:setImageBitmap(bitmap)
--    printlog("type "..type(bitmap))


--    layout:addView(btn)
    tryCatch(requie("log"))
end

function getObj(obj)

    return obj:getEngineMaxVersion()
end

function tryCatch(fun)
    local ret, errMessage = pcall(fun);
    printlog("ret:" .. (ret and "true" or "false") .. " \nerrMessage:" .. (errMessage or "null"));
end

function xTryCatchGetErrorInfo()
    printlog(debug.traceback());
end

function xTryCatch(fun)
    local ret, errMessage = xpcall(fun, xTryCatchGetErrorInfo);
    printlog("ret:" .. (ret and "true" or "false") .. " \nerrMessage:" .. (errMessage or "null"));
end


function FileSaveLoad()
    local file = io.open("logger.txt", "r");

    file = io.open("logger.txt", "w");
    assert(file);

    file:write("hello world");
    file:close();
end
