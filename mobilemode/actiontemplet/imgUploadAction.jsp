<%@page import="com.weaver.formmodel.util.DateHelper"%>
<%@page import="weaver.formmode.virtualform.VirtualFormHandler"%>
<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="com.weaver.formmodel.data.types.FormModelType"%>
<%@page import="weaver.servicefiles.DataSourceXML"%>
<%@page import="com.weaver.formmodel.mobile.mec.model.FormData"%>
<%@page import="com.weaver.formmodel.util.StringHelper"%>

<%@page import="weaver.file.FileUpload"%>
<%@page import="com.weaver.formmodel.mobile.utils.MobileUpload"%>

<%@page import="com.weaver.formmodel.mobile.utils.MobileCommonUtil"%>
<%@page import="com.weaver.formmodel.mobile.MobileFileUpload"%>

<%@page import="com.weaver.formmodel.mobile.manager.MobileUserInit"%>
<%@page import="weaver.hrm.User"%>
<%@page import="com.weaver.formmodel.util.NumberHelper"%>
<%@page import="weaver.formmode.dao.ModelInfoDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="weaver.general.Util"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="weaver.formmode.setup.CodeBuild"%>
<%@page import="weaver.formmode.setup.ModeRightInfo"%>
<%@page import="weaver.conn.RecordSet"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.interfaces.yaphets.util.*"%>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>


<%
//此模版为：移动建模表单控件服务端业务处理的页面，仅供参考。
FileUpload fileUpload = new MobileFileUpload(request,"UTF-8",false);
MobileUpload mobileUpload = new MobileUpload(request);
out.clear();
String action=StringHelper.null2String(fileUpload.getParameter("action"));//需要在表单控件提交URL中传递action的值
if("savedata".equalsIgnoreCase(action)||StringHelper.isEmpty(action)){
	JSONObject result = new JSONObject();
	BaseBean bs = new BaseBean();
	String errMsg = "您的请求未被服务端处理";
	try{
		String datasource = StringHelper.null2String(fileUpload.getParameter("datasource"));//数据源名称
		String tablename = StringHelper.null2String(fileUpload.getParameter("tablename"));//表名
		String keyname = StringHelper.null2String(fileUpload.getParameter("keyname"));//主键字段
		String actiontype = StringHelper.null2String(fileUpload.getParameter("actiontype"));
		boolean isCreate = actiontype.equals("0");//是否新建 
		String billid = StringHelper.null2String(fileUpload.getParameter("billid"));
		
		int status = 0;//  状态码：  0:失败     1:成功
		//***********自定义业务逻辑代码区域，仅供参考***********
		bs.writeLog("---------------开始处理上传图片-------------------");
		String zctp = StringHelper.null2String(fileUpload.getParameter("fieldname_zctp"));
		String gdzcbm = StringHelper.null2String(fileUpload.getParameter("fieldname_gdzcbm"));
		String userid = StringHelper.null2String(fileUpload.getParameter("fieldname_requestId"));//存的是当前用户的值
		if(zctp.length() <= 0){
			status = 0;//失败
			errMsg = "获取图片出现错误，请联系管理员处理！";
		}else if(gdzcbm == null || "".equals(gdzcbm)){
			status = 0;//失败
			errMsg = "获取资产编码出现错误，请联系管理员处理！";
		}else{
			//生成doc文档
			String date = TimeUtil.getCurrentDateString();
			String imageName = gdzcbm+".jpg";
			String imagePath = "E:\\WEAVER\\ecology\\filesystem\\fixedAsserts\\image\\"+date;
			Base64FileUtil base64FileUtil = new Base64FileUtil();
			DocUtil docUtil = new DocUtil();
			base64FileUtil.isChartPathExist(imagePath);
			//1、将base64码转成图片
			Base64FileUtil.decoderBase64File(zctp.replace("data:image/jpeg;base64,",""),imagePath+"\\"+imageName,imagePath);
			//2、用图片生成doc文档
			String userName = bs.getPropValue("jf","DOC_LOGINNAME");
			String password = bs.getPropValue("jf","DOC_PASSWORD");
			String loginSession = docUtil.getSession(userName, password, 0, "127.0.0.1");
			if(loginSession == null || "".equals(loginSession)){
				status = 0;//失败
				errMsg = "获取Webservice Session失败，请联系管理员处理！";
			}else{
				int docid = docUtil.createImageFile(imagePath+"\\"+imageName,imageName,loginSession);
				bs.writeLog("---------------docid-------------------"+docid);
				if(docid > 0){
					RecordSet rs = new RecordSet();
					String sql = "update uf_zckp set zctp = '"+docid+"' where gdzcbm = '"+gdzcbm+"'";
					rs.execute(sql);
					status = 1;//业务执行成功，必须把此状态改为1
					errMsg = "上传成功";
					//记录操作日志
					FormModeHandler modeHandler = new FormModeHandler();
					Map<String, String> formDataMap = new HashMap<>();
					formDataMap.put("operator",userid);
					formDataMap.put("operateTime",TimeUtil.getCurrentTimeString());
					formDataMap.put("gdzcbm",gdzcbm);
					formDataMap.put("operateType","图片上传");
					String modeid = bs.getPropValue("jf","ZCXGJL_MODEID");
					modeHandler.saveModeData(modeid,"1",formDataMap,"");
				}else{
					status = 0;//失败
					errMsg = "DOC创建失败，请联系管理员处理！";//错误信息
				}
			}
		}
		//***********自定义业务逻辑代码区域，仅供参考***********
		result.put("status", status);//必须返回状态码
		if(status==0){//执行失败时，必须同时返回对应的错误信息
			errMsg = URLEncoder.encode(errMsg, "UTF-8");
			errMsg = errMsg.replaceAll("\\+","%20");
			result.put("errMsg", errMsg);
		}
		result.put("errMsg", errMsg);
	}catch(Exception ex){
		ex.printStackTrace();
		result.put("status", "0");//失败
		errMsg = Util.null2String(ex.getMessage());//错误信息
		errMsg = URLEncoder.encode(errMsg, "UTF-8");
		errMsg = errMsg.replaceAll("\\+","%20");
		result.put("errMsg", errMsg);
	}
	//result.put("fbuttonId", fileUpload.getParameter("C922B3DC3D000001A8A736601CE017DF"));// 提交按钮id
	out.print("<script type='text/javascript'>window.parent.alert(JSON.stringify("+result+"));parent.Mobile_NS.formResponse("+result.toString()+");</script>");
	out.print("<script type='text/javascript'>window.location.href='/mobilemode/appHomepageView.jsp?appHomepageId=10';</script>");
}
out.flush();
out.close();
%>