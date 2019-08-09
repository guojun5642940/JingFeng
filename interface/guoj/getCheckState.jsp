<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.conn.RecordSet"%>



<%
    RecordSet rs = new RecordSet();
    BaseBean bs = new BaseBean();

    String checkstate = "0";
    String sql = "select checkstate from uf_checkstate";
    rs.execute(sql);
    if(rs.next()){
        checkstate = Util.null2String(rs.getString(1));
    }
    out.print("{'checkstate':'"+checkstate+"'}");
%>
