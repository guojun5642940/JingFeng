<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>


<%
    RecordSet rs = new RecordSet();
    BaseBean bs = new BaseBean();
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

    String result = "0";
    String checkstate = "";
    String startDate = "";
    String endDate = "";
    String sql = "select checkstate,startDate,endDate from uf_checkstate";
    rs.execute(sql);
    if(rs.next()){
        checkstate = Util.null2String(rs.getString(1));
        startDate = Util.null2String(rs.getString(2));
        endDate = Util.null2String(rs.getString(3));
        if("1".equals(checkstate) && !"".equals(startDate) && !"".equals(endDate)){//开启盘点且当前时间在范围内
            //判断时间
            String nowDte = TimeUtil.getCurrentDateString();
            Date date1 = format.parse(startDate);
            Date date2 = format.parse(endDate);
            Date compareDate = format.parse(nowDte);
            int compareTo1 = compareDate.compareTo(date1);
            int compareTo2 = date2.compareTo(compareDate);


            bs.writeLog(startDate+"==date1=="+date1);
            bs.writeLog(endDate+"==date2=="+date2);
            bs.writeLog(nowDte+"==compareDate=="+compareDate);
            bs.writeLog("compareTo1=="+compareTo1);
            bs.writeLog("compareTo2=="+compareTo2);


            if(compareTo1 >=0 && compareTo2 >= 0){
                result = "1";
            }
        }else if("1".equals(checkstate) && "".equals(startDate) && "".equals(endDate)){//开启盘点且未设置时间段
            result = "1";
        }
    }
    out.print("{'result':'"+result+"'}");
%>
