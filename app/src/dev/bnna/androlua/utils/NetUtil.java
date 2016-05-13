package dev.bnna.androlua.utils;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

/**
 * Created by wenshengping on 16/4/7.
 */
public class NetUtil {

    private static String TAG ="NET";
    private static String FODER ="/lua";

    /**
     * 获取本地文本
     * @param filePath filepath
     * @return 文件内容
     */
    public static String getString(String filePath) {
        final String path = Constant.LOCAL_PATH + filePath;
        InputStream is = null;
        HttpURLConnection conn = null;
        String str =null;
        try {
            URL url = new URL(path);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setDoInput(true);
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
        HttpURLConnection conn = null;
        InputStream is = null;
        URL myFileUrl = null;

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

    public static void getFile(String url){
        URLConnection connection;
        ZipInputStream zipIn = null;
        FileOutputStream fileOut = null;
        ZipEntry zipEntry = null;
        int readedBytes = 0;
        int total = 0;
        String folderPath = "sdcard/lua";
        try {
            URL mURL = new URL(Constant.LOCAL_PATH+url);
            connection = mURL.openConnection();
            connection.setDoInput(true);
            connection.setDoOutput(true);
            connection.connect();
            zipIn = new ZipInputStream(connection.getInputStream());
            while ((zipEntry = zipIn.getNextEntry()) != null) {
                String entryName = zipEntry.getName();
                if (zipEntry.isDirectory()) {
                    entryName = entryName.substring(0, entryName.length() - 1);
                    File folder = new File(folderPath + File.separator+ entryName);
                    folder.mkdirs();
                } else {
                    String fileName=folderPath + File.separator + entryName;
                    File file = new File(fileName);
                    file.createNewFile();
                    fileOut = new FileOutputStream(file);

                    byte[] buffer = new byte[1024 * 4];
                    while ((readedBytes = zipIn.read(buffer)) > 0) {
                        fileOut.write(buffer, 0, readedBytes);
//                        total+=readedBytes;
                    }
                    fileOut.close();
                }
                zipIn.closeEntry();
            }
            zipIn.close();
        }
        catch (IOException e) {
            e.printStackTrace();
        }

    }


    /**
     * 下载zip文件
     * @param url 文件名称
     * @return
     */
    public static long downloadFile(String url){

        int bytesCopied = 0;
        String out = FileUtil.getNormalSDCardPath()+FODER;
        try {

            URL mUrl = new URL(Constant.LOCAL_PATH + url);
            URLConnection connection = null;
            connection = mUrl.openConnection();
            int length = connection.getContentLength();
            String fileName = new File(mUrl.getFile()).getName();
            File mFile = new File(out, fileName);
            File foder = new File(out);
            if (!foder.exists()){
                foder.mkdir();
            }
            if (mFile.exists()) {
                mFile.delete();
            }
            OutputStream os = new FileOutputStream(mFile);
//            int len = 0;
//            byte[] bs = new byte[1024*4];
//            while ((len = is.read(bs)) != -1) {
//                os.write(bs, 0, len);
//            }

            bytesCopied =copy(connection.getInputStream(),os);
            ZipUtil.UnZipFolder(mFile.getAbsolutePath(),out);
            if(bytesCopied!=length&&length!=-1){
                Log.e(TAG, "Download incomplete bytesCopied="+bytesCopied+", length"+length);
            }
            os.close();
        } catch (Exception e) {e.printStackTrace();

        }
        return bytesCopied;
    }
    private static int copy(InputStream input, OutputStream output){
        byte[] buffer = new byte[1024*8];
        BufferedInputStream in = new BufferedInputStream(input, 1024*8);
        BufferedOutputStream out  = new BufferedOutputStream(output, 1024*8);
        int count =0,n=0;
        try {
            while((n=in.read(buffer, 0, 1024*8))!=-1){
                out.write(buffer, 0, n);
                count+=n;
            }
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            try {
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return count;
    }

}
