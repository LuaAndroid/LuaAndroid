package dev.bnna.androlua;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by wenshengping on 16/5/3.
 */
public class BDNDLSource implements Serializable{


    private static final long serialVersionUID = 6538973755153669738L;
    private String path;
    private String version;
    private ArrayList<String> includeFiles;
    private ArrayList<String> excludeFiles;

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public ArrayList<String> getIncludeFiles() {
        return includeFiles;
    }

    public void setIncludeFiles(ArrayList<String> includeFiles) {
        this.includeFiles = includeFiles;
    }

    public ArrayList<String> getExcludeFiles() {
        return excludeFiles;
    }

    public void setExcludeFiles(ArrayList<String> excludeFiles) {
        this.excludeFiles = excludeFiles;
    }
}
