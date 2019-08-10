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

    <SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
    <SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
    <style>
        .xTable_message, #loading {
            border: 1px solid #e1e1e1;
            background: white;
            color: #59627c;
            position: absolute;
            padding: 9px!important;
            z-index: 20001;
            font-size: 14px;
            background-image: url(/images/ecology8/onload_wev8.gif)!important;
            background-position: 15px 50%!important;
            background-repeat: no-repeat!important;
            padding-left: 48px!important;
        }
    </style>
</head>
<%
    String imagefilename = "/images/hdSystem.gif";
    String titlename = "盘点设置" ;
    String needfav ="1";
    String needhelp ="";

    String checkstate = "";
    String ksrq = "";
    String jsrq = "";
    RecordSet rs = new RecordSet();
    String sql = "select * from uf_checkstate";
    rs.execute(sql);
    if(rs.next()){
        checkstate = Util.null2String(rs.getString("checkstate"));
        ksrq = Util.null2String(rs.getString("startDate"));
        jsrq = Util.null2String(rs.getString("endDate"));
    }

%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<div id="message_table_Div" class="xTable_message" style="display: none; position: absolute; top: 285px; left: 559px;">正在初始化数据,请稍候...</div>
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
                                    <COLGROUP>
                                    <COL width="20%">
                                    <COL width="80%">
                                    <TBODY>
                                        <TR class=Title>
                                            <td align="left" style="width: 43px;"><img src="/js/tabs/images/nav/mnav12_wev8.png"/>盘点设置</td>
                                            <td align="right" style="padding-right: 10px;">
                                                <input type="button" value="盘点状态初始化" class='e8_btn_top middle' onclick="initDataStatus()">
                                                <input type="button" value="保存时间" class='e8_btn_top middle' onclick="saveTime()">
                                            </td>
                                        </TR>
                                        <TR class=Spacing><TD class=Line colSpan=2></TD></TR>
                                        <tr >
                                            <td>盘点状态</td>
                                            <td class=Field>
                                                <INPUT type="checkbox" tzCheckbox="true" class=InputStyle name="checkState" id="checkState" value="<%=checkstate%>" >
                                            </td>
                                        </tr>
                                        <TR class=Spacing><TD class=Line colSpan=2></TD></TR>
                                        <tr >
                                            <td>生效时间</td>
                                            <td class=Field>
                                                <input type="hidden" id="ksrq" name="ksrq" value="<%=ksrq %>" _mindate="" _maxdate="" class="wuiDate" _callback="" _isrequired="yes">
                                                <button class="calendar" type="button" name="begindateReleBtn_Autogrt&quot;" id="begindateReleBtn_Autogrt&quot;" onclick="_gdt('ksrq', 'begindateReleSpan_Autogrt', '','yes');"></button>
                                                <span id="begindateReleSpan_Autogrt" name="begindateReleSpan_Autogrt"><%=ksrq %></span><span id="begindateReleSpan_Autogrtimg" name="begindateReleSpan_Autogrtimg"></span>
                                                -
                                                <input type="hidden" id="jsrq" name="jsrq" value="<%=jsrq %>" _mindate="" _maxdate="" class="wuiDate" _callback="" _isrequired="yes">
                                                <button class="calendar" type="button" name="enddateReleBtn_Autogrt&quot;" id="enddateReleBtn_Autogrt&quot;" onclick="_gdt('jsrq', 'enddateReleSpan_Autogrt', '','yes');"></button>
                                                <span id="enddateReleSpan_Autogrt" name="enddateReleSpan_Autogrt"><%=jsrq %></span><span id="enddateReleSpan_Autogrtimg" name="enddateReleSpan_Autogrtimg"></span>
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
    //初始化开关
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
    //切换开关状态
    $("#checkState").click(function() {
        var val = $(this).attr('checked');
        if(val){
            window.top.Dialog.confirm("确定开启资产盘点？",function (){
                setCheckState("1");
                return;
            },function (){
                $("#checkState").next().removeClass("checked");
            });
        }else{
            window.top.Dialog.confirm("确定关闭资产盘点？",function (){
                setCheckState("0");
                return;
            },function (){
                $("#checkState").next().addClass("checked");
            });
        }
    });

    //保存开关状态
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
    //盘点状态初始化
    function initDataStatus(){
        window.top.Dialog.confirm("确定初始化所有资产的盘点状态？",function (){
            $("#message_table_Div").show();
            jQuery.ajax({
                type:"POST",
                url:"/interface/guoj/initDataStatusAjaxjs.jsp",
                data:{},
                success:function(res){
                    $("#message_table_Div").hide();
                    var json = eval("("+res+")");
                    var isSuccess = json.isSuccess;
                    if(isSuccess == "0"){
                        var gdzcbm = json.gdzcbm;
                        Dialog.alert("资产编号["+gdzcbm+"]同步错误，数据已回滚，请联系管理员");
                    }else{
                        Dialog.alert("初始化成功");
                    }
                },
                error:function(e){$("#message_table_Div").hide();}
            });
        });
    }
    //保存时间
    function saveTime(){
        var ksrq = $("#ksrq").val();
        var jsrq = $("#jsrq").val();
        if((ksrq == "" && jsrq !="") || (ksrq != "" && jsrq =="")){
            Dialog.alert("时间段只能同时设置或者同时为空");
            return;
        }
        jQuery.ajax({
            type:"POST",
            url:"/interface/guoj/setCheckDateAjaxjs.jsp",
            data:{"ksrq":ksrq,"jsrq":jsrq},
            success:function(res){
                var json = eval("("+res+")");
                var isSuccess = json.isSuccess;
                if(isSuccess == "0"){
                    Dialog.alert("数据保存错误，请联系管理员");
                }else{
                    Dialog.alert("保存成功");
                }
            },
            error:function(e){}
        });
    }

</script>
<SCRIPT language="javascript"  src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<SCRIPT language="javascript"  src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</HTML>
