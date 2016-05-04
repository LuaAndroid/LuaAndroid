--
-- Created by IntelliJ IDEA.
-- User: wenshengping
-- Date: 16/4/5
-- Time: 16:25
-- To change this template use File | Settings | File Templates.
--

-- assert 当读写输入报错的时候,会打印出断言
-- io.open 表示 io 是系统自带的库,其中有个方法叫 open 由此可见io 是一个table
-- r表示读取的权限(read的缩写)  参数如果是a表示追加(append)  w表示写入(write)  b表示打开二进制(binary)
-- local f = assert(io.open("name.txt",'r'))  --相当于获取流的指针或者句柄或者对象
-- 表示读取所有的文件内容,也可以选择 *line 表示读取一行, 或者*number读取一个数字 或者 表示读取一个不超过个数的字符
-- 读取本地文本文件，并返回对应字符串
 function read_files( str )
    local f = assert(io.open("/sdcard/lua/name",'r'))
    local content = f:read("*all")
    f:close()
    --local content = "hello world"
    nmdebug.logd("lua log : "..content)
    return str..content
end


