<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.interfaces.yaphets.util.CommonUtil" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.general.BaseBean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

  </head>
  <%

      String result = "";
      result = CommonUtil.callProcedure("HrmQuerySeqByTypeString","hyu-");
  %>
  <body>

    	<div id = "resultDiv">code=<%=result%></div>
  </body>
  
<script type="text/javascript">
function getJson() {
	//var val = $("#textinput").val();data:{"val":val},
	jQuery.ajax({
		type : "POST",
		async : false,
		url : "/interface/weite/guoj/test/getJson.jsp",
		success : function(data) {
			alert(1);
		},
		error : function(e) {
			alert("查询出错!");
		}
	});
}
</script>
  
<SCRIPT language="javascript"  src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<SCRIPT language="javascript"  src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript"  src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</html>
