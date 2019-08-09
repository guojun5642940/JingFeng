<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.conn.RecordSet"%>



<%
    RecordSet rs = new RecordSet();
    BaseBean bs = new BaseBean();

    String state = Util.null2String(request.getParameter("state"));
    String sql = "select id from uf_checkstate";
    rs.execute(sql);
    if(rs.next()){
        String id = Util.null2String(rs.getString(1));
        sql = "update uf_checkstate set checkstate = '"+state+"' where id = '"+id+"'";
    }else{
        sql = "insert into uf_checkstate (checkstate) values ('"+state+"')";
    }
    rs.execute(sql);

    if("0".equals(state)){
        rs.execute("update uf_checkReport set dataState = '0' ");
    }
%>
