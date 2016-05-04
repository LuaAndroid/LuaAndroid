package dev.bnna.androlua;

import java.io.Serializable;

/**
 * Created by wenshengping on 16/5/3.
 */
public class BDNDLModuleInfo implements Serializable{


    private static final long serialVersionUID = -1109055779028245743L;
    private int moduleId;
    private int moduleVersion;
    private String moduleName;
    private String mainFunction;
    private String checkSum;
    private String packageUrl;
    private BDNDLSource bdndlSource;
    private BDNDLSupport bdndlSupport;

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public int getModuleVersion() {
        return moduleVersion;
    }

    public void setModuleVersion(int moduleVersion) {
        this.moduleVersion = moduleVersion;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getMainFunction() {
        return mainFunction;
    }

    public void setMainFunction(String mainFunction) {
        this.mainFunction = mainFunction;
    }

    public String getCheckSum() {
        return checkSum;
    }

    public void setCheckSum(String checkSum) {
        this.checkSum = checkSum;
    }

    public String getPackageUrl() {
        return packageUrl;
    }

    public void setPackageUrl(String packageUrl) {
        this.packageUrl = packageUrl;
    }

    public BDNDLSource getBdndlSource() {
        return bdndlSource;
    }

    public void setBdndlSource(BDNDLSource bdndlSource) {
        this.bdndlSource = bdndlSource;
    }

    public BDNDLSupport getBdndlSupport() {
        return bdndlSupport;
    }

    public void setBdndlSupport(BDNDLSupport bdndlSupport) {
        this.bdndlSupport = bdndlSupport;
    }
}
