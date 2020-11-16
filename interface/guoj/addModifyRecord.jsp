<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.interfaces.yaphets.role.PowerUtil" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.interfaces.yaphets.util.FormModeHandler" %>
<%@ page import="java.util.Map" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.HashMap" %>
<%
    BaseBean bs = new BaseBean();
    String nowUser = Util.null2String(request.getParameter("nowUser"));
    String gdzcbm = Util.null2String(request.getParameter("gdzcbm"));
    FormModeHandler modeHandler = new FormModeHandler();
    Map<String, String> formDataMap = new HashMap<>();
    formDataMap.put("operator",nowUser);
    formDataMap.put("operateTime", TimeUtil.getCurrentTimeString());
    formDataMap.put("gdzcbm",gdzcbm);
    formDataMap.put("operateType","监控修改");
    String modeid = bs.getPropValue("jf","ZCXGJL_MODEID");
    int modeDataId = modeHandler.saveModeData(modeid,"1",formDataMap,"");
%>
