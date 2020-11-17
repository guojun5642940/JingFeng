<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>

<%
	BaseBean bs = new BaseBean();
	RecordSet rs = new RecordSet();
	PrintWriter writer = response.getWriter();
	String ysyr = Util.null2String(request.getParameter("ysyr"));
	String hrmid = Util.null2String(request.getParameter("hrmid"));
	String ssbm = Util.null2String(request.getParameter("ssbm"));
	String sszxid = Util.null2String(request.getParameter("sszxid"));
	String billids = Util.null2String(request.getParameter("billids"));

	String sql = "update uf_zckp set syr = '"+hrmid+"' ,sybm = '"+ssbm+"',syzx = '"+sszxid+"' where id in ("+billids+")";
	bs.writeLog("资产批量转移sql:---"+sql);
	rs.execute(sql);
	writer.write("<html><body onload=\"window.parent.parent.closeDialogAndRefesh("+ysyr+");window.parent.closeDialog();\"></body></html>");
%>
