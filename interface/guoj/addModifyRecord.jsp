<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.interfaces.yaphets.role.PowerUtil" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.interfaces.yaphets.util.FormModeHandler" %>
<%@ page import="java.util.Map" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="weaver.interfaces.yaphets.mutiaction.GdzcDto" %>
<%@ page import="java.util.Iterator" %>
<%
    BaseBean bs = new BaseBean();
    String nowUser = Util.null2String(request.getParameter("nowUser"));
    String gdzcbm = Util.null2String(request.getParameter("gdzcbm"));

    RecordSet rs = new RecordSet();
    String sql = "select id,operateContent from uf_zcxgjl where gdzcbm = '"+gdzcbm+"' and operator = '"+nowUser+"' order by id desc";
    rs.execute(sql);
    rs.next();
    String id = rs.getString("id");
    String operateContent = rs.getString("operateContent");
    JSONObject oldGdzcDto = JSONObject.fromObject(operateContent);//修改前对象

    sql = "select * from uf_zckp where gdzcbm = '"+gdzcbm+"'";
    rs.execute(sql);
    rs.next();
    String gsmc = Util.null2String(rs.getString("gsmc"));
    String zclb = Util.null2String(rs.getString("zclb"));
    String zclx = Util.null2String(rs.getString("zclx"));
    String ggxh = Util.null2String(rs.getString("ggxh"));
    String jldw = Util.null2String(rs.getString("jldw"));
    String gzrq = Util.null2String(rs.getString("gzrq"));
    String cfdd = Util.null2String(rs.getString("cfdd"));
    String syzx = Util.null2String(rs.getString("syzx"));
    String cgr = Util.null2String(rs.getString("cgr"));
    String syr = Util.null2String(rs.getString("syr"));
    String sybm = Util.null2String(rs.getString("sybm"));
    String lyrq = Util.null2String(rs.getString("lyrq"));
    String bmzrr = Util.null2String(rs.getString("bmzrr"));
    String zczt = Util.null2String(rs.getString("zczt"));
    String gmdj = Util.null2String(rs.getString("gmdj"));
    String zctp = Util.null2String(rs.getString("zctp"));
    String ssbk = Util.null2String(rs.getString("ssbk"));
    GdzcDto gdzcDto = new GdzcDto();
    gdzcDto.setGsmc(gsmc);
    gdzcDto.setZclb(zclb);
    gdzcDto.setZclx(zclx);
    gdzcDto.setGdzcbm(gdzcbm);
    gdzcDto.setGgxh(ggxh);
    gdzcDto.setJldw(jldw);
    gdzcDto.setGzrq(gzrq);
    gdzcDto.setCfdd(cfdd);
    gdzcDto.setSyzx(syzx);
    gdzcDto.setCgr(cgr);
    gdzcDto.setSyr(syr);
    gdzcDto.setSybm(sybm);
    gdzcDto.setLyrq(lyrq);
    gdzcDto.setBmzrr(bmzrr);
    gdzcDto.setZczt(zczt);
    gdzcDto.setGmdj(gmdj);
    gdzcDto.setZctp(zctp);
    gdzcDto.setSsbk(ssbk);
    JSONObject newGdzcDto = JSONObject.fromObject(gdzcDto);

    boolean isTpsc = true;
    String newOperteContent = "";
    Iterator iter = oldGdzcDto.entrySet().iterator();
    while (iter.hasNext()) {
        Map.Entry entry = (Map.Entry) iter.next();
        String key = entry.getKey().toString();
        String oldValue = Util.null2String(entry.getValue().toString());
        String newValue = Util.null2String(newGdzcDto.getString(key));
        if(!oldValue.equals(newValue)){
            newOperteContent += "字段["+key+"] 由["+oldValue+"]修改为["+newValue+"],";
            if(!"zctp".equals(key)){
                isTpsc = false;//存在图片上传以外的字段修改
            }
        }
    }
    if(newOperteContent.length()>0){
        newOperteContent = newOperteContent.substring(0,newOperteContent.length()-1);
        rs.execute("update uf_zcxgjl set operateContent = '"+newOperteContent+"' where id = '"+id+"'");
        if(isTpsc){
            rs.execute("update uf_zcxgjl set operateType = '图片上传' where id = '"+id+"'");
        }
    }else{
        rs.execute("delete from uf_zcxgjl where id = '"+id+"'");
    }

%>


