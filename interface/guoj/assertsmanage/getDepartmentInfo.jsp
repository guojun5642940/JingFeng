<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.interfaces.yaphets.role.PowerUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
    String hrmid = Util.null2String(request.getParameter("hrmid"));
    String departmentId = resourceComInfo.getDepartmentID(hrmid);
    String departmentName = departmentComInfo.getDepartmentName(departmentId);

    out.print("{'departmentId':'"+departmentId+"','departmentName':'"+departmentName+"'}");
%>
