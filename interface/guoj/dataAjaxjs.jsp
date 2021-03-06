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
    String jkflag = Util.null2String(request.getParameter("jkflag"),"");//监控标记
    String nowUser = Util.null2String(request.getParameter("nowUser"),"");

    String sql = "select * from "+Constants.MODEL_TABLENAME_GDZC+" where gdzcbm = '"+gdzcbm+"'";
    bs.writeLog("移动建模扫码查询资产卡片信息sql:"+sql);
    rs.execute(sql);
    String queryFlag = "0";
    String id = "";
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
    String pdzt = "";
    String pdr = "";
    String ssbk = "";
    String zctp = "";
    String picFileid = "";
    String roleFlag = "0";
    if(rs.next()){
        id = Util.null2String(rs.getString("id"));
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
        pdr = Util.null2String(rs.getString("pdr"));
        zczt = Util.null2String(rs.getString("zczt"));
        pdzt = Util.null2String(rs.getString("pdzt"));
        ssbk = Util.null2String(rs.getString("ssbk"));
        zctp = Util.null2String(rs.getString("zctp"));
        queryFlag = "1";
        if(!"".equalsIgnoreCase(zctp)){
            picFileid = getImageFileid(zctp);
        }

        if("0".equals(zclb)){
            zclb = "固定资产";
        }else if("1".equals(zclb)){
            zclb = "低值易耗品";
        }

        if("0".equals(zczt)){
            zczt = "在库";
        }else if("1".equals(zczt)){
            zczt = "在用";
        }else if("2".equals(zczt)){
            zczt = "报废";
        }

        if("1".equals(pdzt)){
            pdzt = "已盘点";
        }else{
            pdzt = "未盘点";
        }
    }

    //判断监控页面有没有当前板块的权限
    sql = "select * from uf_rybk where ssbk = '"+ssbk+"'";
    rs.execute(sql);
    while(rs.next()){
        String hrmid = Util.null2String(rs.getString("hrmid"));
        if((","+hrmid+",").indexOf(","+nowUser+",") >= 0){
            roleFlag = "1";
            break;
        }
    }


    String result = "{'gsmc':'"+getDwmc(gsmc)+"'," +
            "'zclb':'"+zclb+"'," +
            "'id':'"+id+"'," +
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
            "'pdr':'"+resourceComInfo.getLastname(pdr)+"'," +
            "'zczt':'"+zczt+"'," +
            "'pdzt':'"+pdzt+"'," +
            "'ssbk':'"+ssbk+"'," +
            "'picFileid':'"+picFileid+"'," +
            "'zctp':'"+zctp+"'," +
            "'roleFlag':'"+roleFlag+"'," +
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

    /**
     *  @author: guojun
     *  @Date: 2020/11/10 21:57
     *  @Description: 获取资产图片id
     */
    public String getImageFileid(String docid){
        RecordSet rs = new RecordSet();
        String result = "";
        String sql = "select imagefileid from DocImageFile where docid = '"+docid+"'";
        rs.execute(sql);
        if(rs.next()){
            result = Util.null2String(rs.getString("imagefileid"));
        }
        return result;
    }
%>
