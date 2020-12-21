<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.hrm.resource.ResourceComInfo" %>
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<HTML>
<head>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
	<link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="/wui/theme/ecology8/templates/default/css/default2_wev8.css" type="text/css">
	
	<script language="javascript" src="/js/weaver_wev8.js"></script>
	<script language=javascript src="/js/ecology8/request/e8.browser_wev8.js"></script>
	<script type="text/javascript" src="/wui/theme/ecology8/templates/default/js/default_wev8.js"></script>
	<!-- 文件上传相关js -->
	<script type="text/javascript" src="/js/swfupload/swfupload_wev8.js"></script>
	<script type="text/javascript" src="/js/swfupload/swfupload.queue_wev8.js"></script>
	<script type="text/javascript" src="/js/swfupload/fileprogress_wev8.js"></script>
	<script type="text/javascript" src="/js/swfupload/handlers_wev8.js"></script>
	<script type="text/javascript" src="../plugs/layer/layer.js"></script>
</head>
	
<body>
	<%
		String nowUserid = user.getUID()+"";
		String billids = Util.null2String(request.getParameter("billids"));
		String changeType = Util.null2String(request.getParameter("changeType"));

		String backFields =" u.id,d.dwmc as gsmc,(case u.zclb when '0' then '固定资产' when '1' then '低值易耗品' else '' end) as zclb, z.zclxmc as zclx,u.ggxh,u.gdzcbm,x.sszx as syzx,u.syr,u.sybm,u.cfdd,u.bmzrr";
		String dtable = " uf_zckp u ";
		dtable += " left join uf_dwmc d on u.gsmc = d.dwbm ";
		dtable += " left join uf_zclx z on u.zclx = z.zclxbm ";
		dtable += " left join uf_zczx x on u.syzx = x.id ";
		dtable += " left join hrmresource h on h.id = u.syr ";
		String sqlWhere = " where u.id in ("+billids+") " ;

		String ysyr = "";
		String ysyrName = "";
		String ysybm = "";
		String ysyzx = "";
		String ybmzrr = "";
		String ybmzrrName = "";
		String ycfdd = "";
		RecordSet rs = new RecordSet();
		rs.execute(" select "+backFields+" from "+dtable+" "+sqlWhere);
		if(rs.next()){
			ysyr = Util.null2String(rs.getString("syr"));
			ysybm = Util.null2String(rs.getString("sybm"));
			ysyzx = Util.null2String(rs.getString("syzx"));
			ybmzrr = Util.null2String(rs.getString("bmzrr"));
			ycfdd = Util.null2String(rs.getString("cfdd"));

			if(!"".equals(ysyr)){
				ysyrName = resourceComInfo.getLastname(ysyr);
			}
			if(!"".equals(ybmzrr)){
				ybmzrrName = resourceComInfo.getLastname(ybmzrr);
			}
			if(!"".equals(ysybm)){
				ysybm = departmentComInfo.getDepartmentName(ysybm);
			}
		}
	%>
	<table id="topTitle" cellpadding="0" cellspacing="0">
		<tr>
			<td class="rightSearchSpan" style="text-align: right; width: 400px !important">
				<input type="button" value="保存" class="e8_btn_top middle" onclick="doSubmitForm()"/>
				<span title="菜单"  class="cornerMenu middle"></span>
			</td>
		</tr>
	</table>
	<div id="tabDiv">
		<span style="width:10px"></span>
		<span id="hoverBtnSpan" class="hoverBtnSpan">
		</span>
	</div>
	<!-- 表单 -->
	<FORM id="weaver" name="weaver" action="transferOperation.jsp" method="post">
		<div id="nomalDiv">
			<table class="LayoutTable" style="width:100%;">
				<colgroup><col width="20%"><col width="80%"></colgroup>
				<tbody>
					<tr class="intervalTR">
						<td colspan="2">
							<table class="LayoutTable" style="width:100%;">
								<colgroup><col width="50%"><col width="50%"></colgroup>
								<tbody>
								<tr class="groupHeadHide">
									<td class="interval"><span class="groupbg"></span><span class="e8_grouptitle">原信息</span></td>
									<td class="interval" colspan="2" style="text-align:right;"><span class="toolbar"></span><span _status="0" class="hideBlockDiv" style="">
										<img src="/wui/theme/ecology8/templates/default/images/2_wev8.png"></span></td>
								</tr>
								</tbody>
							</table>
						</td>
					</tr>
					<tr class="Spacing" style="height:1px;"><td class="Line" colspan="2"></td></tr>
					<tr class="items intervalTR">
						<td colspan="2">
							<%if("1".equals(changeType)){
								%>
									<table class="LayoutTable" style="table-layout:fixed;width:100%;">
										<colgroup>
											<col width="20%">
											<col width="80%">
										</colgroup>
										<tbody>
										<tr>
											<td class="fieldName">被交接人</td>
											<td class="field"><%=ysyrName%></td>
										</tr>
										<tr style="height:1px !important;" class="Spacing"><td class="paddingLeft18" colspan="2"><div class="intervalDivClass"></div></td></tr>
										<tr>
											<td class="fieldName">所在部门</td>
											<td class="field"><%=ysybm%></td>
										</tr>
										<tr style="height:1px !important;" class="Spacing"><td class="paddingLeft18" colspan="2"><div class="intervalDivClass"></div></td></tr>
										<tr>
											<td class="fieldName">所属中心</td>
											<td class="field"><%=ysyzx%></td>
										</tr>
										<tr style="height:1px !important;" class="Spacing"><td class="paddingLeft18" colspan="2"><div class="intervalDivClass"></div></td></tr>
										<tr>
											<td class="fieldName">部门责任人</td>
											<td class="field"><%=ybmzrrName%></td>
										</tr>
										<tr style="height:1px !important;" class="Spacing"><td class="paddingLeft18" colspan="2"><div class="intervalDivClass"></div></td></tr>
										<tr>
											<td class="fieldName">存放地点</td>
											<td class="field"><%=ycfdd%></td>
										</tr>
										<tr style="height:1px !important;" class="Spacing"><td class="paddingLeft18" colspan="2"><div class="intervalDivClass"></div></td></tr>
										</tbody>
									</table>
								<%
							}else{
								%>
									<table class="LayoutTable" style="table-layout:fixed;width:100%;">
										<colgroup>
											<col width="20%">
											<col width="80%">
										</colgroup>
										<tbody>
										<tr>
											<td class="fieldName">部门责任人</td>
											<td class="field"><%=ybmzrrName%></td>
										</tr>
										<tr style="height:1px !important;" class="Spacing"><td class="paddingLeft18" colspan="2"><div class="intervalDivClass"></div></td></tr>
										</tbody>
									</table>
								<%
							}%>
						</td>
					</tr>

					<tr class="intervalTR">
						<td colspan="2">
							<table class="LayoutTable" style="width:100%;">
								<colgroup><col width="50%"><col width="50%"></colgroup>
								<tbody>
								<tr class="groupHeadHide">
									<td class="interval"><span class="groupbg"></span><span class="e8_grouptitle">转移后信息</span></td>
									<td class="interval" colspan="2" style="text-align:right;"><span class="toolbar"></span><span _status="0" class="hideBlockDiv" style="">
										<img src="/wui/theme/ecology8/templates/default/images/2_wev8.png"></span></td>
								</tr>
								</tbody>
							</table>
						</td>
					</tr>
					<tr class="Spacing" style="height:1px;"><td class="Line" colspan="2"></td></tr>
					<tr class="items intervalTR">
						<td colspan="2">
							<%
								if("1".equals(changeType)){
									%>
										<table class="LayoutTable" style="table-layout:fixed;width:100%;">
											<colgroup>
												<col width="20%">
												<col width="80%">
											</colgroup>
											<tbody>
											<tr>
												<td class="fieldName">接收人</td>
												<td class="field">
													<button type=button class=Browser  onClick="onShowResource('resourceSpan','hrmid')" name="showdepartment"></BUTTON>
													<INPUT type="hidden" id="hrmid" name="hrmid" >
													<span id="resourceSpan" name="resourceSpan">
															<img src="/images/BacoError_wev8.gif" align="absmiddle">
														</span>
												</td>
											</tr>
											<tr style="height:1px !important;" class="Spacing"><td class="paddingLeft18" colspan="2"><div class="intervalDivClass"></div></td></tr>
											<tr>
												<td class="fieldName">所在部门</td>
												<td class="field">
													<INPUT type="hidden" id="ssbm" name="ssbm" >
													<span id="ssbmSpan" name="ssbmSpan">
														</span>
												</td>
											</tr>
											<tr style="height:1px !important;" class="Spacing"><td class="paddingLeft18" colspan="2"><div class="intervalDivClass"></div></td></tr>
											<tr>
												<td class="fieldName">所属中心</td>
												<td class="field">
													<button type=button id = "sszxBtn"  class=Browser  onClick="onShowSszx('sszxSpan','sszxid')"></BUTTON>
													<INPUT type="hidden" id="sszxid" name="sszxid" >
													<span id="sszxSpan" name="sszxSpan">
															<img src="/images/BacoError_wev8.gif" align="absmiddle">
														</span>
												</td>
											</tr>
											<tr style="height:1px !important;" class="Spacing"><td class="paddingLeft18" colspan="2"><div class="intervalDivClass"></div></td></tr>
											<tr>
												<td class="fieldName">部门负责人</td>
												<td class="field">
													<button type=button class=Browser  onClick="onShowResource('xbmzrrSpan','xbmzrr')" name="showdepartment"></BUTTON>
													<INPUT type="hidden" id="xbmzrr" name="xbmzrr" >
													<span id="xbmzrrSpan" name="xbmzrrSpan">
															<img src="/images/BacoError_wev8.gif" align="absmiddle">
														</span>
												</td>
											</tr>
											<tr style="height:1px !important;" class="Spacing"><td class="paddingLeft18" colspan="2"><div class="intervalDivClass"></div></td></tr>
											<tr>
												<td class="fieldName">新存放地点</td>
												<td class="field">
													<INPUT type="text" id="xcfdd" name="xcfdd" >
												</td>
											</tr>
											<tr style="height:1px !important;" class="Spacing"><td class="paddingLeft18" colspan="2"><div class="intervalDivClass"></div></td></tr>
											</tbody>
										</table>
									<%
								}else{
									%>
										<table class="LayoutTable" style="table-layout:fixed;width:100%;">
											<colgroup>
												<col width="20%">
												<col width="80%">
											</colgroup>
											<tbody>
											<tr>
												<td class="fieldName">部门负责人</td>
												<td class="field">
													<button type=button class=Browser  onClick="onShowResource('xbmzrrSpan2','xbmzrr2')" name="showdepartment"></BUTTON>
													<INPUT type="hidden" id="xbmzrr2" name="xbmzrr2" >
													<span id="xbmzrrSpan2" name="xbmzrrSpan2">
														<img src="/images/BacoError_wev8.gif" align="absmiddle">
													</span>
												</td>
											</tr>
											<tr style="height:1px !important;" class="Spacing"><td class="paddingLeft18" colspan="2"><div class="intervalDivClass"></div></td></tr>
											</tbody>
										</table>
									<%
								}
							%>

						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<input type="hidden" name="billids" id="billids" value="<%=billids%>">
		<input type="hidden" name="ysyr" id="ysyr" value="<%=ysyr%>">
		<input type="hidden" name="nowUserid" id="nowUserid" value="<%=nowUserid%>">
		<input type="hidden" name="changeType" id="changeType" value="<%=changeType%>">

	</form>

</body>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
<script type="text/javascript">
	function doSubmitForm(){
		var hrmid = $("#hrmid").val();
		var ssbm = $("#ssbm").val();
		var sszxid = $("#sszxid").val();
		var xbmzrr = $("#xbmzrr").val();
		var xcfdd = $("#xcfdd").val();
		var changeType = $("#changeType").val();
		var xbmzrr2 = $("#xbmzrr2").val();
		if(changeType == "1"){
			if(hrmid == ""){
				top.Dialog.alert("接收人不能为空");
				return;
			}
			if(ssbm == ""){
				top.Dialog.alert("接收人所在部门不能为空");
				return;
			}
			if(sszxid == ""){
				top.Dialog.alert("接收人所属中心不能为空");
				return;
			}
			if(xbmzrr == ""){
				top.Dialog.alert("部门责任人不能为空");
				return;
			}
			if(xcfdd == ""){
				top.Dialog.alert("新存放地点不能为空");
				return;
			}
		}else{
			if(xbmzrr2 == ""){
				top.Dialog.alert("部门责任人不能为空");
				return;
			}
		}
		window.parent.forbiddenPage();
		$("#weaver").submit();
	}

	function onShowResource(spanid,inputid){
		var tmpids = jQuery("#"+inputid).val();
		var dialogurl = "/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="+tmpids;
		var dialog = new window.top.Dialog();
		dialog.currentWindow = window;
		dialog.URL = dialogurl;
		dialog.callbackfun = function (paramobj, id1) {
			if (id1 != null) {
				if (wuiUtil.getJsonValueByIndex(id1, 0) != "") {
					var val = wuiUtil.getJsonValueByIndex(id1, 0);
					var name = wuiUtil.getJsonValueByIndex(id1, 1);
					$("#"+inputid).val(val);
					$("#"+spanid).html(name);
					setDepartment(val);
				} else {
					$("#"+inputid).val("");
					$("#"+spanid).html("<img src=\"/images/BacoError_wev8.gif\" align=\"absmiddle\">");
					$("#ssbm").val("");
					$("#ssbmSpan").html("");
				}
			}else{
				$("#"+inputid).val("");
				$("#"+spanid).html("<img src=\"/images/BacoError_wev8.gif\" align=\"absmiddle\">");
				$("#ssbm").val("");
				$("#ssbmSpan").html("");
			}
		};
		dialog.Title = "请选择";//请选择
		dialog.Width = 500 ;
		dialog.Height = 600;
		dialog.Drag = true;
		dialog.show();
	}

	function setDepartment(hrmid){
		if(hrmid != ""){
			jQuery.ajax({
				type:"POST",
				url:"/interface/guoj/assertsmanage/getDepartmentInfo.jsp",
				data:{"hrmid":hrmid},
				success:function(res){
					var json = eval("("+res+")");
					var departmentId = json.departmentId;
					var departmentName = json.departmentName;
					$("#ssbm").val(departmentId);
					$("#ssbmSpan").html(departmentName);
				},
				error:function(e){}
			});
		}
	}

	function onShowSszx(spanid,inputid){
		var dialog = new window.top.Dialog();
		var dialogurl = "/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.gdzc_zczx";
		dialog.currentWindow = window;
		dialog.URL = dialogurl;
		dialog.callbackfun = function (paramobj, id1) {
			if (id1 != null) {
				if (wuiUtil.getJsonValueByIndex(id1, 0) != "") {
					var val = wuiUtil.getJsonValueByIndex(id1, 0);
					var name = wuiUtil.getJsonValueByIndex(id1, 1);
					$("#"+inputid).val(val);
					$("#"+spanid).html(name);
				} else {
					$("#"+inputid).val("");
					$("#"+spanid).html("<img src=\"/images/BacoError_wev8.gif\" align=\"absmiddle\">");
				}
			}else{
				$("#"+inputid).val("");
				$("#"+spanid).html("<img src=\"/images/BacoError_wev8.gif\" align=\"absmiddle\">");
			}
		};
		dialog.Title = "请选择";//请选择
		dialog.Width = 500 ;
		dialog.Height = 600;
		dialog.Drag = true;
		dialog.show();
	}
</script>

</HTML>