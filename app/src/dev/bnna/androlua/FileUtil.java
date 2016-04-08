package dev.bnna.androlua;

import android.content.Context;
import android.os.Environment;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

/**
 * Created by wenshengping on 16/4/1.
 */
public class FileUtil {

    public final static String SDCARD_PATH = "/sdcard/lua/";

    public static String getSDCARDFilePath(String fileName){
        StringBuffer buffer = new StringBuffer();
        buffer.append(SDCARD_PATH);
        buffer.append(fileName);
        return buffer.toString();
    }

    /**
     * 读取lua脚本
     *
     * @param is
     * @return
     */
    public static String readStream(InputStream is) {
        try {
            ByteArrayOutputStream bo = new ByteArrayOutputStream();

            int i = is.read();
            while (i != -1) {
                bo.write(i);
                i = is.read();
            }
            return bo.toString();
        } catch (IOException e) {
            e.printStackTrace();
            return "";
        }
    }

    /**
     * 获取assets下的文件内容
     * @param context
     * @param fileName
     * @return
     */
    public static String readStreamFromAssets(Context context, String fileName) {

        try {
            InputStream is = context.getAssets().open(fileName);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            int i = -1;
            while((i=is.read())!=-1){
                baos.write(i);
            }
            return baos.toString();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }



    public static String readFile(String fileName) {
        try {

            File file = new File(getSDCARDFilePath(fileName));
            InputStream is = null;
            if (file.isFile() && file.exists()) {
                is = new FileInputStream(file);
                ByteArrayOutputStream bo = new ByteArrayOutputStream();
                int i = is.read();
                while (i != -1) {
                    bo.write(i);
                    i = is.read();
                }
                return bo.toString();
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }



        /**
     * 将/res/raw下面的资源复制到 /data/data/applicaton.package.name/files
     */
    public static void copyResourcesToLocal(Context context) {
//        String name, sFileName;
//        InputStream content;
//        R.raw a = new R.raw();
//        java.lang.reflect.Field[] t = R.raw.class.getFields();
//        Resources resources = context.getResources();
//        for (int i = 0; i < t.length; i++) {
//            FileOutputStream fs = null;
//            try {
//                name = resources.getText(t[i].getInt(a)).toString();
//                sFileName = name.substring(name.lastIndexOf('/') + 1,
//                        name.length());
//                content = context.getResources().openRawResource(t[i].getInt(a));
//
//                // Copies script to internal memory only if changes were made
//                sFileName = context.getFilesDir() + "/"
//                        + sFileName;
//
//                Log.d("Copy Raw File", "Copying from stream " + sFileName);
//                content.reset();
//                int bytesum = 0;
//                int byteread = 0;
//                fs = new FileOutputStream(sFileName);
//                byte[] buffer = new byte[1024];
//                while ((byteread = content.read(buffer)) != -1) {
//                    bytesum += byteread; // 字节数 文件大小
//                    System.out.println(bytesum);
//                    fs.write(buffer, 0, byteread);
//                }
//                fs.close();
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
    }

    /**
     * 获取手机自身内存路径
     *
     */
    public static String getPhoneCardPath(){
        return Environment.getDataDirectory().getPath();

    }
    /**
     * 获取sd卡路径
     * 双sd卡时，根据”设置“里面的数据存储位置选择，获得的是内置sd卡或外置sd卡
     * @return
     */
    public static String getNormalSDCardPath(){
        return Environment.getExternalStorageDirectory().getPath();
    }


}
