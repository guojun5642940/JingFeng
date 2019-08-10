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
    boolean isSuccess = true;
    BaseBean bs = new BaseBean();
    FormModeHandler modeHandler = new FormModeHandler();
    RecordSet rs = new RecordSet();
    RecordSet delRs = new RecordSet();
    int modeDataId = 0;
    String ids = "";

    String sql = "select * from "+Constants.MODEL_TABLENAME_GDZC+" where zczt in ('0','1')";
    rs.execute(sql);
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
    String gdzcbm = "";
    String pdzt = "";

    while(rs.next()){
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
        gdzcbm = Util.null2String(rs.getString("gdzcbm"));
        pdzt = Util.null2String(rs.getString("pdzt"),"0");

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
        formDataMap.put("pdzt" ,pdzt);
        formDataMap.put("checkDate", TimeUtil.getCurrentTimeString());
        modeDataId = modeHandler.saveModeData(Constants.MODEID_GDZC_CHECKSTATE,"1",formDataMap,"");

        if(modeDataId > 0) {
            ids += ("," + modeDataId);//已成功数据
        }else{
            if(ids.length()>0){
                ids = ids.substring(1);
            }
            //删除已经成功数据
            isSuccess = false;
            sql = "delete from uf_checkReport where id in ("+ids+")";
            delRs.execute(sql);
            break;
        }
    }
    if(isSuccess){
        //数据同步成功后将资产卡片所有状态更新为未盘点
        rs.execute("update "+Constants.MODEL_TABLENAME_GDZC+" set pdzt = '0' ");
    }
    out.print("{'isSuccess':'"+(isSuccess?"1":"0")+"','gdzcbm':'"+gdzcbm+"'}");
%>
