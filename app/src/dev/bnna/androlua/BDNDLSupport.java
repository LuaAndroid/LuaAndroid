package dev.bnna.androlua;

import android.os.Parcel;
import android.os.Parcelable;

import java.io.Serializable;

/**
 * Created by wenshengping on 16/5/3.
 */
public class BDNDLSupport implements Serializable, Parcelable {


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

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.engineMinVersion);
        dest.writeInt(this.engineMaxVersion);
        dest.writeInt(this.osMinVersion);
        dest.writeInt(this.osMaxVersion);
    }

    public BDNDLSupport() {
    }

    protected BDNDLSupport(Parcel in) {
        this.engineMinVersion = in.readInt();
        this.engineMaxVersion = in.readInt();
        this.osMinVersion = in.readInt();
        this.osMaxVersion = in.readInt();
    }

    public static final Parcelable.Creator<BDNDLSupport> CREATOR = new Parcelable.Creator<BDNDLSupport>() {
        @Override
        public BDNDLSupport createFromParcel(Parcel source) {
            return new BDNDLSupport(source);
        }

        @Override
        public BDNDLSupport[] newArray(int size) {
            return new BDNDLSupport[size];
        }
    };
}
