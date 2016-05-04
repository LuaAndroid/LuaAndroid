package dev.bnna.androlua;

import java.io.Serializable;

/**
 * Created by wenshengping on 16/5/3.
 */
public class BDNDLSupport implements Serializable{


    private static final long serialVersionUID = 7417364013062409880L;
    private int engineMinVersion;
    private int engineMaxVersion;
    private int osMinVersion;
    private int osMaxVersion;

    public int getEngineMinVersion() {
        return engineMinVersion;
    }

    public void setEngineMinVersion(int engineMinVersion) {
        this.engineMinVersion = engineMinVersion;
    }

    public int getEngineMaxVersion() {
        return engineMaxVersion;
    }

    public void setEngineMaxVersion(int engineMaxVersion) {
        this.engineMaxVersion = engineMaxVersion;
    }

    public int getOsMinVersion() {
        return osMinVersion;
    }

    public void setOsMinVersion(int osMinVersion) {
        this.osMinVersion = osMinVersion;
    }

    public int getOsMaxVersion() {
        return osMaxVersion;
    }

    public void setOsMaxVersion(int osMaxVersion) {
        this.osMaxVersion = osMaxVersion;
    }
}
