package dev.bnna.androlua;

/**
 * Created by wenshengping on 16/4/7.
 */
public class Constant {
    //final String url = "http://127.0.0.1:8000/icon.png";
    // 服务器地址，由于android手机会将127.0.0.1认为是本机地址，因此填写电脑的局域网ip地址
    public final static String LOCAL_IP = "172.20.186.85";
    public static String LOCAL_PATH = "http://"+ LOCAL_IP+":8000/";
    public final static String VIEW = "view.lua";
    public final static String TEST = "test.lua";

}
