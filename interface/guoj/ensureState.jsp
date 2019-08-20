<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.interfaces.yaphets.util.*"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="weaver.interfaces.yaphets.util.FormModeHandler"%>


<%
    BaseBean bs = new BaseBean();
    FormModeHandler modeHandler = new FormModeHandler();
    RecordSet rs = new RecordSet();
    int modeDataId = 0;
    String gdzcbm = Util.null2String(request.getParameter("gdzcbm"));//固定资产编码
    String nowUser = Util.null2String(request.getParameter("nowUser"));
    gdzcbm = gdzcbm.replace("“","").replace("”","");
    String sql = "update "+Constants.MODEL_TABLENAME_GDZC+" set pdzt = '1',pdr = '"+nowUser+"'  where gdzcbm = '"+gdzcbm+"'";
    boolean isSuccess = rs.execute(sql);
    bs.writeLog("移动建模扫码盘点资产卡片信息sql:"+sql);
    out.print("{'isSuccess':'"+(isSuccess?"1":"0")+"'}");
//    String sql = "select * from "+Constants.MODEL_TABLENAME_GDZC+" where gdzcbm = '"+gdzcbm+"'";
//    bs.writeLog("移动建模扫码盘点资产卡片信息sql:"+sql);
    /*rs.execute(sql);
    String gsmc = "";
    String zclb = "";
    String zclx = "";
    String ggxh = "";
    String gzrq = "";
    String syzx = "";
    String cgr = "";
    String syr = "";
    String sybm = "";
    String cfdd = "";
    String bmzrr = "";
    String zczt = "";
    if(rs.next()){
        gsmc = Util.null2String(rs.getString("gsmc"));
        zclb = Util.null2String(rs.getString("zclb"));
        zclx = Util.null2String(rs.getString("zclx"));
        ggxh = Util.null2String(rs.getString("ggxh"));
        gzrq = Util.null2String(rs.getString("gzrq"));
        syzx = Util.null2String(rs.getString("syzx"));
        cgr = Util.null2String(rs.getString("cgr"));
        syr = Util.null2String(rs.getString("syr"));
        sybm = Util.null2String(rs.getString("sybm"));
        cfdd = Util.null2String(rs.getString("cfdd"));
        bmzrr = Util.null2String(rs.getString("bmzrr"));
        zczt = Util.null2String(rs.getString("zczt"));

        Map<String, String> formDataMap = new HashMap<>();
        formDataMap.put("gsmc" ,gsmc);
        formDataMap.put("zclb" ,zclb);
        formDataMap.put("zclx" ,zclx);
        formDataMap.put("ggxh" ,ggxh);
        formDataMap.put("gdzcbm" ,gdzcbm);
        formDataMap.put("gzrq" ,gzrq);
        formDataMap.put("syzx" ,syzx);
        formDataMap.put("cgr" ,cgr);
        formDataMap.put("syr" ,syr);
        formDataMap.put("sybm" ,sybm);
        formDataMap.put("cfdd" ,cfdd);
        formDataMap.put("bmzrr" ,bmzrr);
        formDataMap.put("zczt" ,zczt);
        formDataMap.put("checkDate", TimeUtil.getCurrentTimeString());
        formDataMap.put("dataState","1");
        modeDataId = modeHandler.saveModeData(Constants.MODEID_GDZC_CHECKSTATE,"1",formDataMap,"");
    }*/
%>
