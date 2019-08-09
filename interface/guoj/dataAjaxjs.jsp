<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.interfaces.yaphets.util.*"%>
<%@ page import="weaver.hrm.resource.ResourceComInfo"%>
<%@ page import="weaver.hrm.company.DepartmentComInfo"%>



<%
    RecordSet rs = new RecordSet();
    BaseBean bs = new BaseBean();
    ResourceComInfo resourceComInfo = new ResourceComInfo();
    DepartmentComInfo deptCominfo = new DepartmentComInfo();

    String gdzcbm = Util.null2String(request.getParameter("gdzcbm"));//固定资产编码
    gdzcbm = gdzcbm.replace("“","").replace("”","");


    String sql = "select * from "+Constants.MODEL_TABLENAME_GDZC+" where gdzcbm = '"+gdzcbm+"'";
    bs.writeLog("移动建模扫码查询资产卡片信息sql:"+sql);
    rs.execute(sql);
    String queryFlag = "0";
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
        queryFlag = "1";


        if("0".equals(zclb)){
            zclb = "固定资产";
        }else if("1".equals(zclb)){
            zclb = "低值易耗品";
        }

        if("0".equals(zczt)){
            zczt = "在库";
        }else if("1".equals(zczt)){
            zczt = "在用";
        }else if("1".equals(zczt)){
            zczt = "报废";
        }
    }
    String result = "{'gsmc':'"+getDwmc(gsmc)+"'," +
            "'zclb':'"+zclb+"'," +
            "'zclx':'"+getZclxmc(zclx)+"'," +
            "'ggxh':'"+ggxh+"'," +
            "'gdzcbm':'"+gdzcbm+"'," +
            "'gzrq':'"+gzrq+"'," +
            "'syzx':'"+getSszx(syzx)+"'," +
            "'cgr':'"+resourceComInfo.getLastname(cgr)+"'," +
            "'syr':'"+resourceComInfo.getLastname(syr)+"'," +
            "'sybm':'"+deptCominfo.getDepartmentname(sybm)+"'," +
            "'cfdd':'"+cfdd+"'," +
            "'bmzrr':'"+resourceComInfo.getLastname(bmzrr)+"'," +
            "'zczt':'"+zczt+"'," +
            "'queryFlag':'"+queryFlag+"'}";
    out.print(result);
%>




<%!
    /**
     * 获取单位名称
     * @return
     */
    public String getDwmc(String dwbm){
        RecordSet rs = new RecordSet();
        String result = "";
        String sql = "select * from uf_dwmc where dwbm = '"+dwbm+"'";
        rs.execute(sql);
        if(rs.next()){
            result = Util.null2String(rs.getString("dwmc"));
        }
        return result;
    }

    /**
     * 获取资产类型
     * @return
     */
    public String getZclxmc(String zclxbm){
        RecordSet rs = new RecordSet();
        String result = "";
        String sql = "select * from uf_zclx where zclxbm = '"+zclxbm+"'";
        rs.execute(sql);
        if(rs.next()){
            result = Util.null2String(rs.getString("zclxmc"));
        }
        return result;
    }

    /**
     * 获取资产中心
     * @return
     */
    public String getSszx(String id){
        RecordSet rs = new RecordSet();
        String result = "";
        String sql = "select * from uf_zczx where id = '"+id+"'";
        rs.execute(sql);
        if(rs.next()){
            result = Util.null2String(rs.getString("sszx"));
        }
        return result;
    }




%>
