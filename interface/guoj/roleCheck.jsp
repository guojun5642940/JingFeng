<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.interfaces.yaphets.role.PowerUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>

<%
    PowerUtil powerUtil = new PowerUtil();
    int nowUser = Integer.parseInt(request.getParameter("nowUser"));
    String roleidStr = Util.null2String(request.getParameter("roleid"));
    BaseBean bs = new BaseBean();
    String roleid = bs.getPropValue("jf",roleidStr);
    bs.writeLog("权限验证-nowUser{"+nowUser+"},roleid{"+roleid+"}--");
    boolean role = powerUtil.CheckModuleRole(roleid,nowUser);
    out.print("{'result':'"+role+"'}");
%>
