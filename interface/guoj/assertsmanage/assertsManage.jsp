<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.PageManagerUtil "%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.systeminfo.setting.HrmUserSettingComInfo"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="UserDefaultManager" class="weaver.docs.tools.UserDefaultManager" scope="session" />
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page" />
<jsp:useBean id="bs" class="weaver.general.BaseBean"></jsp:useBean>

<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css">
	</head>
	<%
		String imagefilename = "/images/hdDOC_wev8.gif";
		String titlename = "资产批量管理";
		String needfav ="1";
		String needhelp ="";
		String sqlCondition = "";
		String pageflag = Util.null2String(request.getParameter("pageflag"));
		String pageId = "";

		String hrmid = Util.null2String(request.getParameter("hrmid"));
		String hrmName = Util.null2String(request.getParameter("hrmName"));
	%>
	
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
		RCMenu += "{搜索,javascript:submitData(),_self} " ;
		RCMenuHeight += RCMenuHeightStep;
	%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

<BODY>
	<script language=javascript src="/js/ecology8/docs/docExt_wev8.js"></script>
	<script language=javascript src="/js/ecology8/docs/docSearchInit_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>

	<script type="text/javascript">
		function onBtnSearchClick(){
			jQuery('#weavertop').submit();
		}
		
		function submitData(){
			jQuery('#weaver').submit();
		}
	</script>
	<FORM id=weavertop name=weavertop method=post action='assertsManage.jsp'>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td></td>
				<td class="rightSearchSpan">
				    <%--<input type="button" value="导出当页" class='e8_btn_top middle' onclick="_xtable_getExcel()">--%>
				    <%--<input type="button" value="导出全部" class='e8_btn_top middle' onclick="_xtable_getAllExcel()">--%>
					<input type="button" value="批量转移" class='e8_btn_top middle' onclick="batchTransfer()">
					<input type="text" id="searchInput" name=hrmName class="searchInput middle" value="<%=hrmName%>" /> &nbsp;&nbsp;
					<span id="advancedSearch" class="advancedSearch">高级搜索</span>&nbsp;&nbsp;
					<span title="菜單" class="cornerMenu"></span>
				</td>
			</tr>
		</table>
	</form>
	<FORM id=weaver name=weaver method=post action='assertsManage.jsp'>
		<div class="advancedSearchDiv" id="advancedSearchDiv">
			<input type="hidden" name="ids" /> 
			<input type="hidden" name="method" />
			<wea:layout type="4col">
				<wea:group context="常用条件">
					<%--<wea:item>开始日期</wea:item>--%>
					<%--<wea:item>--%>
						<%--<span>--%>
							<%--<BUTTON class=Calendar type="button" onclick="onShowDate1(swrqfromspan,swrqfrom)"></BUTTON> --%>
							<%--<SPAN id=swrqfromspan></SPAN> --%>
							<%--&nbsp;<input type="hidden"	name="swrqfrom" value="<%=swrqfrom%>"> - &nbsp;&nbsp;--%>
							<%--<BUTTON class=Calendar type="button" onclick="onShowDate1(swrqtospan,swrqto)"></BUTTON> --%>
							<%--<SPAN id=swrqtospan></SPAN> --%>
							<%--<input type="hidden" name="swrqto" value="<%=swrqto%>">--%>
						<%--</span>--%>
					<%--</wea:item>--%>
					<%----%>
					<%--<wea:item>姓名</wea:item>--%>
					<%--<wea:item>--%>
						<%--<input type="text" id="lastname" name=lastname class="InputStyle" value="<%=lastname%>" /> &nbsp;&nbsp; --%>
					<%--</wea:item>--%>

					<%--<wea:item>部门</wea:item>--%>
					<%--<wea:item>--%>
						<%--<button type=button id = "deptBtn"  class=Browser  onClick="onShowDepart('bmspan','departmentid')" name="showdepartment"></BUTTON>--%>
						<%--<INPUT type="hidden" id="departmentid" name="departmentid" value="<%=departmentid %>">--%>
						<%--<span id="bmspan" name="bmspan"><%=DepartmentComInfo.getDepartmentname(departmentid)%></span>--%>
					<%--</wea:item>--%>
					<wea:item>使用人</wea:item>
					<wea:item>
						<button type=button id = "deptBtn"  class=Browser  onClick="onShowResource('resourceSpan','hrmid')" name="showdepartment"></BUTTON>
						<INPUT type="hidden" id="hrmid" name="hrmid" value="<%=hrmid %>">
						<span id="resourceSpan" name="resourceSpan"><%=ResourceComInfo.getLastname(hrmid)%></span>
					</wea:item>
					
				</wea:group>
				<!-- search div initing****** -->
				<wea:group context="">
					<wea:item type="toolbar">
						<input type="submit" value="搜索" class="e8_btn_submit" />
						<span class="e8_sep_line">|</span>
						<input type="reset" name="reset" onclick="resetCondtion()" value="重置" class="e8_btn_cancel">
						<span class="e8_sep_line">|</span>
						<input type="button" value="取消" class="e8_btn_cancel" id="cancel" />
					</wea:item>
				</wea:group>
			</wea:layout>
		</div>
		<!--列表部分-->
		<%
			 String UF_REVISITINFTAB_FORMMODEID = bs.getPropValue("Crm_data", "UF_REVISITINFTAB_FORMMODEID");

             //设置好搜索条件
	         String backFields =" u.id,d.dwmc as gsmc,(case u.zclb when '0' then '固定资产' when '1' then '低值易耗品' else '' end) as zclb, z.zclxmc as zclx,u.ggxh,u.gdzcbm,x.sszx as syzx,u.syr,u.sybm,u.cfdd,u.bmzrr";
	         String dtable = " uf_zckp u ";
			 dtable += " left join uf_dwmc d on u.gsmc = d.dwbm ";
			 dtable += " left join uf_zclx z on u.zclx = z.zclxbm ";
			 dtable += " left join uf_zczx x on u.syzx = x.id ";
			 dtable += " left join hrmresource h on h.id = u.syr ";
	         String fromSql = " from "+dtable ;
	         String sqlWhere = " where 1=1 " ;

	         if("".equals(hrmid) && "".equals(hrmName)){
				 sqlWhere += " and 1=2";
			 }else if(!"".equals(hrmid)){
				sqlWhere += " and u.syr = '"+hrmid+"'";
			 }else if(!"".equals(hrmName)){
				 sqlWhere += " and h.lastname = '"+hrmName+"'";
			 }
			 
			 //拼接sql条件
	         pageId = "";
	         String primarykey = " u.id ";
	         String pagesize = "30";
	         String sqlorderby = " u.id ";
	         String sqlsortway = " asc ";
	         String tableString = "";

	         tableString += "<table pageId=\""+pageId+"\" pagesize=\""+pagesize+"\" tabletype=\"checkbox\">";
	         tableString += "<sql backfields=\""+backFields+"\" sqlform=\""+Util.toHtmlForSplitPage(fromSql)+"\" sqlorderby=\""+sqlorderby+"\"  sqlprimarykey=\""+primarykey+"\" sqlsortway=\""+sqlsortway+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" />";
	         tableString += "<head>"+          
		                     "<col width=\"15%\"  text=\"公司名称\" column=\"gsmc\" orderkey=\"gsmc\" />"+
							 "<col width=\"8%\"  text=\"资产类别\" column=\"zclb\" orderkey=\"zclb\" />"+
							 "<col width=\"7%\"  text=\"资产类型\" column=\"zclx\" orderkey=\"zclx\" />"+
							 "<col width=\"10%\"  text=\"规格型号\" column=\"ggxh\" orderkey=\"ggxh\" />"+
							 "<col width=\"10%\"  text=\"固定资产编码\" column=\"gdzcbm\" orderkey=\"gdzcbm\" />"+
							 "<col width=\"10%\"  text=\"使用中心\" column=\"syzx\" orderkey=\"syzx\" />"+
							 "<col width=\"10%\"  text=\"使用人\" column=\"syr\" orderkey=\"syr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getMulResourcename1\" />"+
							 "<col width=\"10%\"  text=\"使用部门\" column=\"sybm\" orderkey=\"sybm\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentName\" />"+
							 "<col width=\"10%\"  text=\"存放地点\" column=\"cfdd\" orderkey=\"cfdd\" />"+
							 "<col width=\"10%\"  text=\"部门责任人\" column=\"bmzrr\" orderkey=\"bmzrr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getMulResourcename1\" />"+

		                     "</head>"+
	               			 "</table>";
	         String sqlOut = "select "+backFields +" "+fromSql +" "+sqlWhere;
		%>
		<wea:SplitPageTag isShowTopInfo="true" tableString="<%=tableString%>" mode="run" /><!-- showExpExcel="true" -->
	</FORM>
</BODY>
</HTML>
<script language="javaScript">
	function batchTransfer(){
		var ids = _xtable_CheckedCheckboxId();
		if(ids == ""){
			top.Dialog.alert("未选中数据");
			return;
		}
		ids = ids.substring(0,ids.length-1);
		if(window.top.Dialog){
			diag_vote = new window.top.Dialog();
		} else {
			diag_vote = new Dialog();
		}
		diag_vote.currentWindow = window;
		diag_vote.Width = 500;
		diag_vote.Height = 550;
		diag_vote.Modal = true;
		diag_vote.maxiumnable = true;
		diag_vote.checkDataChange = false;
		diag_vote.Title = "批量转移";
		diag_vote.URL = "/interface/guoj/assertsmanage/tab.jsp?billids="+ids;
		diag_vote.show();
	}
	function search(){
		jQuery("#weavertop").submit();
	}

	function onShowDepart(spanid,inputid){
		var tmpids = jQuery("#"+inputid).val();
		var dialogurl = "/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="+tmpids;
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
				} else {
					$("#"+inputid).val("");
					$("#"+spanid).html("");
				}
			}else{
				$("#"+inputid).val("");
				$("#"+spanid).html("");
			}
		};
		dialog.Title = "请选择";//请选择
		dialog.Width = 500 ;
		dialog.Height = 500;
		dialog.Drag = true;
		dialog.show();
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
				} else {
					$("#"+inputid).val("");
					$("#"+spanid).html("");
				}
			}else{
				$("#"+inputid).val("");
				$("#"+spanid).html("");
			}
		};
		dialog.Title = "请选择";//请选择
		dialog.Width = 500 ;
		dialog.Height = 600;
		dialog.Drag = true;
		dialog.show();
	}
jQuery(document).ready(function(){
	jQuery(".e8tips").wTooltip({html:true});
});

function jump(src){
	window.open(src);
}
</script>
<script language="javascript" src="/js/datetime_wev8.js"></script>
<script language="javascript" src="/js/selectDateTime_wev8.js"></script>
<script language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
