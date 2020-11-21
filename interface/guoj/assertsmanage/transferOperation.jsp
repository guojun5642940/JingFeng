<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="weaver.interfaces.yaphets.util.FormModeHandler" %>
<%@ page import="weaver.general.TimeUtil" %>
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />

<%
	BaseBean bs = new BaseBean();
	RecordSet rsUpdate = new RecordSet();
	RecordSet rs = new RecordSet();
	PrintWriter writer = response.getWriter();

	String nowUserid = Util.null2String(request.getParameter("nowUserid"));
	String ysyr = Util.null2String(request.getParameter("ysyr"));//原使用人
	String ysybm = resourceComInfo.getDepartmentID(ysyr);
	String hrmid = Util.null2String(request.getParameter("hrmid"));//现使用人
	String ssbm = Util.null2String(request.getParameter("ssbm"));//现使用人部门
	String sszxid = Util.null2String(request.getParameter("sszxid"));//现所属中心
	String billids = Util.null2String(request.getParameter("billids"));
	String sqlQuery = "";

	String xbmzrr = Util.null2String(request.getParameter("xbmzrr"));//新部门责任人
	String xcfdd = Util.null2String(request.getParameter("xcfdd"));//新存放地点

	//记录操作日志
	if(billids.indexOf(",")>0){
		String arr[] = billids.split(",");
		for(int i = 0;i<arr.length;i++){
			String billid = arr[i];
			if(!"".equals(billid)){
				String ysyzx = getSszx(billid);
				String ybmzrr = getBmzrr(billid);
				String ycfdd = getCfdd(billid);

				String operateContent = "";
				if(!ysyr.equals(hrmid)){
					operateContent += "使用人由["+ysyr+":"+resourceComInfo.getLastname(ysyr)+"] 修改为["+hrmid+":"+resourceComInfo.getLastname(hrmid)+"],";
					operateContent += "使用人部门由["+ysybm+":"+departmentComInfo.getDepartmentName(ysybm)+"] 修改为["+ssbm+":"+departmentComInfo.getDepartmentName(ssbm)+"],";
				}
				if(!ysyzx.equals(sszxid)){
					operateContent += "所属中心由["+ysyzx+":"+getSszxShowName(ysyzx)+"] 修改为["+sszxid+":"+getSszxShowName(sszxid)+"]";
				}
				if(!ybmzrr.equals(xbmzrr)){
					operateContent += "部门责任人由["+ybmzrr+":"+resourceComInfo.getLastname(ybmzrr)+"] 修改为["+xbmzrr+":"+resourceComInfo.getLastname(xbmzrr)+"],";
				}
				if(!ycfdd.equals(xcfdd)){
					operateContent += "存放地点由["+ycfdd+"] 修改为["+xcfdd+"],";
				}

				FormModeHandler modeHandler = new FormModeHandler();
				Map<String, String> formDataMap = new HashMap<>();
				formDataMap.put("operator",nowUserid);
				formDataMap.put("operateTime",TimeUtil.getCurrentTimeString());
				formDataMap.put("gdzcbm",getGdzcbm(billid));
				formDataMap.put("operateType","批量管理");
				formDataMap.put("operateContent",operateContent);
				String modeid = bs.getPropValue("jf","ZCXGJL_MODEID");
				modeHandler.saveModeData(modeid,"1",formDataMap,"");
			}
		}
	}else{
		//一条记录
		String ysyzx = getSszx(billids);
		String ybmzrr = getBmzrr(billids);
		String ycfdd = getCfdd(billids);

		String operateContent = "";
		if(!ysyr.equals(hrmid)){
			operateContent += "使用人由["+ysyr+":"+resourceComInfo.getLastname(ysyr)+"] 修改为["+hrmid+":"+resourceComInfo.getLastname(hrmid)+"],";
			operateContent += "使用人部门由["+ysybm+":"+departmentComInfo.getDepartmentName(ysybm)+"] 修改为["+ssbm+":"+departmentComInfo.getDepartmentName(ssbm)+"],";
		}
		if(!ysyzx.equals(sszxid)){
			operateContent += "所属中心由["+ysyzx+":"+getSszxShowName(ysyzx)+"] 修改为["+sszxid+":"+getSszxShowName(sszxid)+"]";
		}
		if(!ybmzrr.equals(xbmzrr)){
			operateContent += "部门责任人由["+ybmzrr+":"+resourceComInfo.getLastname(ybmzrr)+"] 修改为["+xbmzrr+":"+resourceComInfo.getLastname(xbmzrr)+"],";
		}
		if(!ycfdd.equals(xcfdd)){
			operateContent += "存放地点由["+ycfdd+"] 修改为["+xcfdd+"],";
		}
		FormModeHandler modeHandler = new FormModeHandler();
		Map<String, String> formDataMap = new HashMap<>();
		formDataMap.put("operator",nowUserid);
		formDataMap.put("operateTime",TimeUtil.getCurrentTimeString());
		formDataMap.put("gdzcbm",getGdzcbm(billids));
		formDataMap.put("operateType","批量管理");
		formDataMap.put("operateContent",operateContent);
		String modeid = bs.getPropValue("jf","ZCXGJL_MODEID");
		modeHandler.saveModeData(modeid,"1",formDataMap,"");
	}
	String sql = "update uf_zckp set syr = '"+hrmid+"' ,sybm = '"+ssbm+"',syzx = '"+sszxid+"', bmzrr = '"+xbmzrr+"', cfdd = '"+xcfdd+"'  where id in ("+billids+")";
	bs.writeLog("资产批量转移sql:---"+sql);
	rsUpdate.execute(sql);
	writer.write("<html><body onload=\"window.parent.parent.closeDialogAndRefesh("+ysyr+");window.parent.closeDialog();\"></body></html>");
%>


<%!
	public String getSszxShowName(String sszx){
		String sql = "select sszx from uf_zczx where id = '"+sszx+"'";
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		if(rs.next()){
			return rs.getString(1);
		}else{
			return "";
		}
	}

	public String getSszx(String billid){
		String sql = "select syzx from uf_zckp where id = '"+billid+"'";
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		if(rs.next()){
			return rs.getString(1);
		}else{
			return "";
		}
	}

	public String getGdzcbm(String billid){
		String sql = "select gdzcbm from uf_zckp where id = '"+billid+"'";
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		if(rs.next()){
			return rs.getString(1);
		}else{
			return "";
		}
	}

	public String getBmzrr(String billid){
		String sql = "select bmzrr from uf_zckp where id = '"+billid+"'";
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		if(rs.next()){
			return rs.getString(1);
		}else{
			return "";
		}
	}

	public String getCfdd(String billid){
		String sql = "select Cfdd from uf_zckp where id = '"+billid+"'";
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		if(rs.next()){
			return rs.getString(1);
		}else{
			return "";
		}
	}

%>
