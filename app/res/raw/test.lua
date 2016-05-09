
--此函数由Java代码调用。接受一个参数，并返回一个字符串
function functionInLuaFile(key)
     return ' Function in Lua file . Return : '..key..'!'
end
--此函数由Java代码调用。接受三个参数。并调用这些Android组件的方法。
function callAndroidApi(context,layout,tip)
--     --创建一个Android TextView
    tv = luajava.newInstance("android.widget.TextView",context)
    --调用TextView的方法
    tv:setText(tip)
    --调用Layout的方法
    layout:addView(tv)

 
end



function launchSetting(context)

     intent = luajava.newInstance("android.content.Intent")
     c = luajava.newInstance("android.content.ComponentName","com.android.settings", "com.android.settings.Settings")
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
    intent:setData(uri.parse(uri,"http://www.baidu.com"))
    context:startActivity(intent);
end

-- -- 启动 intent new 一个java 实例
function launchActivity(context)
    intent = luajava.newInstance("android.content.Intent")
    c = luajava.newInstance("android.content.ComponentName","dev.bnna.androlua", "dev.bnna.androlua.CustomViewActivity")
    intent:setFlags(intent.FLAG_ACTIVITY_NEW_TASK);
    intent:setComponent(c)
    context:startActivity(intent)
end

-- lua 实现方法，增加一个Button，点击Button， Toast显示Button标题。
function addButton(context,layout)
    btn = luajava.newInstance("android.widget.Button",context)

    -- 
    local androidString = luajava.bindClass("dev.bnna.androlua.R$string")
    btn:setText(androidString.hello)

    -- 设置nackgroudColor 成功
    -- local color = luajava.newInstance("android.graphics.Color")
    -- btn:setBackgroundColor(color.red(color,70))
    -- btn:setBackgroundColor(color.RED)
    -- 
    local drawable = luajava.bindClass("dev.bnna.androlua.R$drawable")
    btn:setBackgroundResource(drawable.icon)

    button_cb = {
        onClick = function(v)
            print(tostring(v))
            local Toast = luajava.bindClass('android.widget.Toast')
            Toast:makeText(context, v:getText(), Toast.LENGTH_SHORT):show()
        end
    }
    local listener = luajava.createProxy("android.view.View$OnClickListener", button_cb)

    --[[ -- 第二种方法Listener实现方法
    local listener = luajava.createProxy("android.view.View$OnClickListener", {
        
            onClick = function(v)
                print(tostring(v))
                local Toast = luajava.bindClass('android.widget.Toast')
                Toast:makeText(context, v:getText(), Toast.LENGTH_SHORT):show()
            end
        
    })
    ]]--
    btn:setOnClickListener(listener)
    
    layout:addView(btn)

end


















