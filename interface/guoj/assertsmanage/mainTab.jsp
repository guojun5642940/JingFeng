
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util,weaver.general.BaseBean,
                 weaver.file.Prop,
                 weaver.general.GCONST,
                 weaver.hrm.settings.RemindSettings" %>
<%@ page import="weaver.systeminfo.menuconfig.*"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="ssuBb" class="weaver.general.BaseBean" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page" />
<jsp:useBean id="CheckSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="HrmListValidate" class="weaver.hrm.resource.HrmListValidate" scope="page" />
<jsp:useBean id="ManageDetachComInfo" class="weaver.hrm.moduledetach.ManageDetachComInfo" scope="page" />
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<jsp:useBean id="bs" class="weaver.general.BaseBean"></jsp:useBean>

<%
String titlename = "";
%>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<%
int detachable=0;
if(session.getAttribute("detachable")!=null){
    detachable=Util.getIntValue(String.valueOf(session.getAttribute("detachable")),0);
}else{
    rs.executeSql("select detachable from SystemSet");
    if(rs.next()){
        detachable=rs.getInt("detachable");
        session.setAttribute("detachable",String.valueOf(detachable));
    }
}
%>

<%
boolean hasTree = false;//是否有树形导航
boolean showDiv = true;

titlename = "批量调整";

String orgid = Util.null2String(request.getParameter("orgid"));
String hrmid = Util.null2String(request.getParameter("hrmid"));
String changeType = Util.null2String(request.getParameter("changeType"),"1");
%>
<%
%>
<HTML><HEAD>
<script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<SCRIPT language="javascript" src="/js/messagejs/messagejs_wev8.js"></script>
<SCRIPT language="javascript" src="/js/messagejs/simplehrm_wev8.js"></script>
<link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet" />
<link rel="stylesheet" href="/css/ecology8/request/searchInput_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/searchInput_wev8.js"></script>

<link rel="stylesheet" href="/css/ecology8/request/seachBody_wev8.css" type="text/css" />
<link rel="stylesheet" href="/css/ecology8/request/hoverBtn_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/request/titleCommon_wev8.js"></script>

<script type="text/javascript">
function showMyTree(){
	jQuery("#e8_tablogo").click();
} 

var myCurrentindex = 0;
function setMyCurrentLi(){
	jQuery("li").removeClass("current");
	jQuery(jQuery("li")[myCurrentindex]).addClass("current");
}

function refreshTab(){
	jQuery('.flowMenusTd',parent.document).toggle();
	jQuery('.leftTypeSearch',parent.document).toggle();
} 
</script>
<script type="text/javascript">
jQuery(function(){
    jQuery('.e8_box').Tabs({
        getLine:1,
        iframe:"tabcontentframe",
        staticOnLoad:true,
        objName:"<%=titlename %>",
        navLogo:"",
        navLogoEvent:jsOnNavLogClick
    });
});
function jsOnNavLogClick(){
	tabcontentframe.setUserIcon();
}
</script>
</head>
<BODY scroll="no">

	<%
	%>
	<div class="e8_box">
				<%if(showDiv){ %>
				<div class="e8_boxhead">
					<div class="div_e8_xtree" id="div_e8_xtree"></div>
			        <div class="e8_tablogo" id="e8_tablogo"></div>
					<div class="e8_ultab">
					<div class="e8_navtab" id="e8_navtab">
						<span id="objName"></span>
					</div>
				<div>
				<%} %>
      <ul class="tab_menu">
	      <%if(hasTree){%>
			  <li class="e8_tree">
			  	<a onClick="javascript:refreshTab();"></a>
			  </li>
		  <%} %>	
      
	      <li class="current">
		      <a href="/interface/guoj/assertsmanage/assertsManage.jsp?hrmid=<%=hrmid%>&changeType=<%=changeType%>" target="tabcontentframe">
			      <%="批量管理" %>
			      <span id="test1"></span>
		      </a>
	      </li>
      </ul>
     <div id="rightBox" class="e8_rightBox">
     </div>
     			<%if(showDiv){ %>
	    		</div>
				</div>
			</div>
	    <%} %>
     <div class="tab_box">
         <div>
             <iframe src="/interface/guoj/assertsmanage/assertsManage.jsp?hrmid=<%=hrmid%>&changeType=<%=changeType%>" id="tabcontentframe" name="tabcontentframe"  onload="update();" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
         </div>
     </div>
 </div>          
</body>
<script type="text/javascript">
window.notExecute = true;

function jsOnNavLogClick(){
	tabcontentframe.setUserIcon();
}

function forbiddenPage(){
	$("<div class=\"datagrid-mask\" style=\"position:fixed;z-index:2;opacity:0.4;filter:alpha(opacity=40);BACKGROUND-COLOR:#fff;\"></div>").css({display:"block",width:"100%",height:"100%",top:0,left:0}).appendTo("body");
	$("<div class=\"datagrid-mask-msg\" style=\"background:#fff;position:fixed;z-index:3;padding: 10px;padding-top: 6px;padding-bottom: 6px;border: 1px solid;\"></div>").html("<%=SystemEnv.getHtmlLabelName(25666,user.getLanguage())%>").appendTo("body").css({display:"block",left:($(document.body).outerWidth(true) - 190) / 2,top:($(window).height() - 45) / 2});
}

function closeWinAFrsh(){
	var parentWin = parent.getParentWindow(window);
	parentWin.closeDlgARfsh();
}

function closeDialog(){
	var dialog = parent.getDialog(window);
	dialog.closeByHand();
}

function closeDialogAndRefesh(hrmid){
	$("#tabcontentframe").attr("src","/interface/guoj/assertsmanage/assertsManage.jsp?hrmid="+hrmid);
}

</script>
</html>

