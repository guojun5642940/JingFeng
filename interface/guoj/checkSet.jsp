<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.Util,weaver.rtx.RTXConfig" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rtxConfig" class="weaver.rtx.RTXConfig" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="SubComanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<HTML>
<HEAD>
    <link href="/wui/theme/ecology8/templates/default/css/default2_wev8.css" rel="stylesheet" type="text/css"/>
    <link href="/wui/theme/ecology8/skins/default/wui_wev8.css" rel="stylesheet" type="text/css"/>
    <link href="/wui/common/jquery/plugin/zTree/css/zTreeStyle/zTreeStyle_wev8.css" rel="stylesheet" type="text/css"/>
    <link href="/css/ecology8/request/seachBody_wev8.css" rel="stylesheet" type="text/css"/>
    <LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET></LINK>

    <link href="/js/checkbox/jquery.tzCheckbox_wev8.css" type=text/css rel=STYLESHEET>
    <script type="text/javascript" src="/js/ecology8/jNice/jNice/jquery.jNice_wev8.js"></script>

</head>
<%
    String imagefilename = "/images/hdSystem.gif";
    String titlename = "盘点开关设置" ;
    String needfav ="1";
    String needhelp ="";

    String checkstate = "";
    RecordSet rs = new RecordSet();
    String sql = "select checkstate from uf_checkstate";
    rs.execute(sql);
    if(rs.next()){
        checkstate = Util.null2String(rs.getString(1));
    }

%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<FORM style="MARGIN-TOP: 0px" name=frmMain method=post action="SystemSetOperation.jsp">
    <table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
        <colgroup>
            <col width="10">
            <col width="">
            <col width="10">
            <tr>
                <td height="10" colspan="3"></td>
            </tr>
            <tr>
                <td ></td>
                <td valign="top">
                    <TABLE class="Shadow">
                        <tr>
                            <td valign="top">
                                <TABLE class=ViewForm>
        <COLGROUP> <COL width="20%"> <COL width="80%"><TBODY>
    <TR class=Title>
        <td align="left" style="width: 43px;"><img src="/js/tabs/images/nav/mnav12_wev8.png"/>盘点开关设置</td>
        <td align="right" style="padding-right: 10px;"></td>
    </TR>
    <TR class=Spacing><TD class=Line colSpan=2></TD></TR>
    <tr >
        <td>
            盘点状态
        </td>
        <td class=Field>
            <INPUT type="checkbox" tzCheckbox="true" class=InputStyle name="checkState" id="checkState" value="<%=checkstate%>" >
        </td>
    </tr>
    <TR class=Spacing><TD class=Line colSpan=2></TD></TR>
    </TBODY>
    </TABLE>
    </td>
    </tr>
    </TABLE>
    </td>
    <td></td>
    </tr>
    <tr>
        <td height="10" colspan="3"></td>
    </tr>
    </table>
</FORM>
</BODY>
<script type="text/javascript">

    jQuery(document).ready(function(){
        jQuery("input[type=checkbox]").each(function(){
            if(jQuery(this).attr("tzCheckbox")=="true"){
                jQuery(this).tzCheckbox({labels:['','']});

                if($(this).val() == "1"){
                    $(this).next().addClass("checked");
                }
            }
        });
    });

    $("#checkState").click(function() {
        var val = $(this).attr('checked');
        if(val){
            window.top.Dialog.confirm("确定开启资产盘点，上一期盘点数据全部失效？",function (){
                setCheckState("1");
                return;
            },function (){
                $("#checkState").next().removeClass("checked");
            });
        }else{
            window.top.Dialog.confirm("确定关闭本期资产盘点？",function (){
                setCheckState("0");
                return;
            },function (){
                $("#checkState").next().addClass("checked");
            });
        }
    });


    function setCheckState(state){
        jQuery.ajax({
            type:"POST",
            url:"/interface/guoj/setCheckStateAjaxjs.jsp",
            data:{"state":state},
                success:function(res){
            },
            error:function(e){}
        });
    }

</script>
<SCRIPT language="javascript"  src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<SCRIPT language="javascript"  src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</HTML>
