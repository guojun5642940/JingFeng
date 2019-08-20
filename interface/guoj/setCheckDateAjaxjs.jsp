<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.conn.RecordSet"%>



<%
    RecordSet rs = new RecordSet();
    BaseBean bs = new BaseBean();

    String ksrq = Util.null2String(request.getParameter("ksrq"));
    String jsrq = Util.null2String(request.getParameter("jsrq"));
    String nf = Util.null2String(request.getParameter("nf"));
    String cs = Util.null2String(request.getParameter("cs"));

    String sql = "select id from uf_checkstate";
    rs.execute(sql);
    if(rs.next()){
        String id = Util.null2String(rs.getString(1));
        sql = "update uf_checkstate set startDate = '"+ksrq+"',endDate = '"+jsrq+"',nf='"+nf+"',cs='"+cs+"' where id = '"+id+"'";
    }else{
        sql = "insert into uf_checkstate (checkstate,startDate,endDate) values ('0','"+ksrq+"','"+jsrq+"','"+nf+"',cs='"+cs+"')";
    }
    boolean isSuccess = rs.execute(sql);
    out.print("{'isSuccess':'"+(isSuccess?"1":"0")+"'}");
%>
