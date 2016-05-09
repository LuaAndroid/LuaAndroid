package dev.bnna.androlua;

import java.io.Serializable;

/**
 * Created by wenshengping on 16/4/20.
 */
public class BDNDLModuleConfig implements Serializable{
    private static final long serialVersionUID = 8436290011947561683L;


    private String channel;
    private String moduleVersion;
    private long modifiedDate;
    private BDNDLModuleInfo moduleInfo;
    private BDNDLSupport support;


    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getModuleVersion() {
        return moduleVersion;
    }

    public void setModuleVersion(String moduleVersion) {
        this.moduleVersion = moduleVersion;
    }

    public long getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(long modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public BDNDLModuleInfo getModuleInfo() {
        return moduleInfo;
    }

    public void setModuleInfo(BDNDLModuleInfo moduleInfo) {
        this.moduleInfo = moduleInfo;
    }

    public BDNDLSupport getSupport() {
        return support;
    }

    public void setSupport(BDNDLSupport support) {
        this.support = support;
    }
}
