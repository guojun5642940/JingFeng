package weaver.interfaces.yaphets.mutiaction;

import weaver.interfaces.yaphets.util.Constants;
import weaver.interfaces.yaphets.util.FormModeHandler;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 *  @author: guojun
 *  @Date: 2020/11/4 23:21
 *  @Description: 固定资产对象
 */
public class GdzcDto implements Serializable {


    private String gsmc;
    private String zclb;
    private String zclx;
    private String gdzcbm;
    private String ggxh;
    private String jldw;
    private String gzrq;
    private String cfdd;
    private String syzx;
    private String cgr;
    private String syr;
    private String sybm;
    private String lyrq;
    private String bmzrr;
    private String zczt;
    private String gmdj;
    private String zctp;
    private String ssbk;

    public int saveModeData(){
        FormModeHandler modeHandler = new FormModeHandler();
        Map<String, String> formDataMap = new HashMap<>();
        formDataMap.put("gsmc" ,this.getGsmc());
        formDataMap.put("zclb" ,this.getZclb());
        formDataMap.put("zclx" ,this.getZclx());
        formDataMap.put("gdzcbm" ,this.getGdzcbm());
        formDataMap.put("ggxh" ,this.getGgxh());
        formDataMap.put("jldw" ,this.getJldw());
        formDataMap.put("gzrq" ,this.getGzrq());
        formDataMap.put("cfdd" ,this.getCfdd());
        formDataMap.put("syzx" ,this.getSyzx());
        formDataMap.put("cgr" ,this.getCgr());
        formDataMap.put("syr" ,this.getSyr());
        formDataMap.put("sybm" ,this.getSybm());
        formDataMap.put("lyrq" ,this.getLyrq());
        formDataMap.put("bmzrr" ,this.getBmzrr());
        formDataMap.put("zczt" ,this.getZczt());
        formDataMap.put("gmdj" ,this.getGmdj());
        formDataMap.put("zctp" ,this.getZctp());
        formDataMap.put("ssbk" ,this.getSsbk());
        int modeDataId = modeHandler.saveModeData(Constants.MODEID_GDZC,"1",formDataMap,"");
        return modeDataId;
    }

    public String getSsbk() {
        return ssbk;
    }

    public void setSsbk(String ssbk) {
        this.ssbk = ssbk;
    }

    public String getZctp() {
        return zctp;
    }

    public void setZctp(String zctp) {
        this.zctp = zctp;
    }

    public String getGsmc() {
        return gsmc;
    }

    public void setGsmc(String gsmc) {
        this.gsmc = gsmc;
    }

    public String getZclb() {
        return zclb;
    }

    public void setZclb(String zclb) {
        this.zclb = zclb;
    }

    public String getZclx() {
        return zclx;
    }

    public void setZclx(String zclx) {
        this.zclx = zclx;
    }

    public String getGdzcbm() {
        return gdzcbm;
    }

    public void setGdzcbm(String gdzcbm) {
        this.gdzcbm = gdzcbm;
    }

    public String getGgxh() {
        return ggxh;
    }

    public void setGgxh(String ggxh) {
        this.ggxh = ggxh;
    }

    public String getJldw() {
        return jldw;
    }

    public void setJldw(String jldw) {
        this.jldw = jldw;
    }

    public String getGzrq() {
        return gzrq;
    }

    public void setGzrq(String gzrq) {
        this.gzrq = gzrq;
    }

    public String getCfdd() {
        return cfdd;
    }

    public void setCfdd(String cfdd) {
        this.cfdd = cfdd;
    }

    public String getSyzx() {
        return syzx;
    }

    public void setSyzx(String syzx) {
        this.syzx = syzx;
    }

    public String getCgr() {
        return cgr;
    }

    public void setCgr(String cgr) {
        this.cgr = cgr;
    }

    public String getSyr() {
        return syr;
    }

    public void setSyr(String syr) {
        this.syr = syr;
    }

    public String getSybm() {
        return sybm;
    }

    public void setSybm(String sybm) {
        this.sybm = sybm;
    }

    public String getLyrq() {
        return lyrq;
    }

    public void setLyrq(String lyrq) {
        this.lyrq = lyrq;
    }

    public String getBmzrr() {
        return bmzrr;
    }

    public void setBmzrr(String bmzrr) {
        this.bmzrr = bmzrr;
    }

    public String getZczt() {
        return zczt;
    }

    public void setZczt(String zczt) {
        this.zczt = zczt;
    }

    public String getGmdj() {
        return gmdj;
    }

    public void setGmdj(String gmdj) {
        this.gmdj = gmdj;
    }
}
