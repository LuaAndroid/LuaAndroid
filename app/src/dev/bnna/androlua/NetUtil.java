package dev.bnna.androlua;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import java.io.BufferedInputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * Created by wenshengping on 16/4/7.
 */
public class NetUtil {

    /**
     * 获取本地文本
     * @param filePath filepath
     * @return 文件内容
     */
    public static String getString(String filePath) {
        final String path = Constant.LOCAL_PATH+filePath;
        InputStream is = null;
        HttpURLConnection conn = null;
        String str =null;
        try {
            URL url = new URL(path);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setDoInput(true);
            conn.setConnectTimeout(3000);
            conn.connect();
            int code = conn.getResponseCode();
            if (code == 200) {
                is = new BufferedInputStream(conn.getInputStream());
                str = FileUtil.readStream(is);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {

                if (is != null) {
                    is.close();
                }
                if (conn != null) {
                    conn.disconnect();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return str;
    }


    /**
     *  根据一个网络连接(URL)获取bitmap图像
     * @param path file
     * @return bitmap
     */
    public static Bitmap getBitmap(String path) {
        // 显示网络上的图片

        Bitmap bitmap = null;
        InputStream is = null;
        HttpURLConnection conn = null;
        URL myFileUrl;
        try {
            myFileUrl = new URL(path);
            conn = (HttpURLConnection) myFileUrl.openConnection();
            conn.setRequestMethod("GET");
            conn.setDoInput(true);
            conn.setConnectTimeout(3000);

            conn.connect();

            int code = conn.getResponseCode();
            if (code == 200) {
                is = new BufferedInputStream(conn.getInputStream());
            }
            if (is != null) {
                bitmap = BitmapFactory.decodeStream(is);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if (is != null) {
                    is.close();
                }
                if (conn != null) {
                    conn.disconnect();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return bitmap;
    }
}
