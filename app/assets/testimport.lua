--
-- Created by IntelliJ IDEA.
-- User: wenshengping
-- Date: 16/4/27
-- Time: 17:26
-- To change this template use File | Settings | File Templates.
--

require "import"
import "android.widget.Toast"

function showToast(context)
    print("hello world");
end


--local fun=function ( ... )
--    local a=1;
--    print(a+1);
--    return a+1;
--end
--
--tryCatch=function(fun)
--    local ret,errMessage=pcall(fun);
--    print("ret:" .. (ret and "true" or "false" )  .. " \nerrMessage:" .. (errMessage or "null"));
--end
--
--xTryCatchGetErrorInfo=function()
--    print(debug.traceback());
--end
--xTryCatch=function(fun)
--    local ret,errMessage=xpcall(fun,xTryCatchGetErrorInfo);
--    print("ret:" .. (ret and "true" or "false" )  .. " \nerrMessage:" .. (errMessage or "null"));
--end
--
--tryCatch(fun);
