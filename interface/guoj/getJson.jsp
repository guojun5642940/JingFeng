<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.general.BaseBean"%>
<%
		/* FnaDataStatisticsJob f = new FnaDataStatisticsJob();
		f.execute(); */
		fullYearExcute();
%>




<%!
	/**
	 * TOD 全年执行情况的统计
	 * 2018-3-19
	 * @author guoj
	 */
	public void fullYearExcute(){
		BaseBean bs = new BaseBean();
		String sql = " select * from view_deptFeetype ";
		RecordSet rs = new RecordSet();
		RecordSet rs2 = new RecordSet();
		rs.execute(sql);
		while(rs.next()){
			String budgetorganizationid = Util.null2String(rs.getString("budgetorganizationid"));
			String budgettypeid = Util.null2String(rs.getString("budgettypeid"));
			String fnayear = Util.null2String(rs.getString("fnayear"));
			double amount1 = getFnaAmountByTime(fnayear, "01", budgetorganizationid, budgettypeid, "1");
			double amount2 = getFnaAmountByTime(fnayear, "02", budgetorganizationid, budgettypeid, "1");
			double amount3 = getFnaAmountByTime(fnayear, "03", budgetorganizationid, budgettypeid, "1");
			double amount4 = getFnaAmountByTime(fnayear, "04", budgetorganizationid, budgettypeid, "1");
			double amount5 = getFnaAmountByTime(fnayear, "05", budgetorganizationid, budgettypeid, "1");
			double amount6 = getFnaAmountByTime(fnayear, "06", budgetorganizationid, budgettypeid, "1");
			double amount7 = getFnaAmountByTime(fnayear, "07", budgetorganizationid, budgettypeid, "1");
			double amount8 = getFnaAmountByTime(fnayear, "08", budgetorganizationid, budgettypeid, "1");
			double amount9 = getFnaAmountByTime(fnayear, "09", budgetorganizationid, budgettypeid, "1");
			double amount10 = getFnaAmountByTime(fnayear, "10", budgetorganizationid, budgettypeid, "1");
			double amount11 = getFnaAmountByTime(fnayear, "11", budgetorganizationid, budgettypeid, "1");
			double amount12 = getFnaAmountByTime(fnayear, "12", budgetorganizationid, budgettypeid, "1");
			
			double frozen1 = getFnaAmountByTime(fnayear, "01", budgetorganizationid, budgettypeid, "0");
			double frozen2 = getFnaAmountByTime(fnayear, "02", budgetorganizationid, budgettypeid, "0");
			double frozen3 = getFnaAmountByTime(fnayear, "03", budgetorganizationid, budgettypeid, "0");
			double frozen4 = getFnaAmountByTime(fnayear, "04", budgetorganizationid, budgettypeid, "0");
			double frozen5 = getFnaAmountByTime(fnayear, "05", budgetorganizationid, budgettypeid, "0");
			double frozen6 = getFnaAmountByTime(fnayear, "06", budgetorganizationid, budgettypeid, "0");
			double frozen7 = getFnaAmountByTime(fnayear, "07", budgetorganizationid, budgettypeid, "0");
			double frozen8 = getFnaAmountByTime(fnayear, "08", budgetorganizationid, budgettypeid, "0");
			double frozen9 = getFnaAmountByTime(fnayear, "09", budgetorganizationid, budgettypeid, "0");
			double frozen10 = getFnaAmountByTime(fnayear, "10", budgetorganizationid, budgettypeid, "0");
			double frozen11 = getFnaAmountByTime(fnayear, "11", budgetorganizationid, budgettypeid, "0");
			double frozen12 = getFnaAmountByTime(fnayear, "12", budgetorganizationid, budgettypeid, "0");
			
			if(!isExistDeptFnaType(budgetorganizationid, budgettypeid, fnayear)){
				rs2.execute("insert into uf_fullBudgetExcute(fnayear,departmentid,fnabudgettype,amount1,amount2,amount3,amount4,amount5,amount6,amount7,amount8,amount9,amount10,amount11,amount12,frozen1,frozen2,frozen3,frozen4,frozen5,frozen6,frozen7,frozen8,frozen9,frozen10,frozen11,frozen12) values ('"
						+ fnayear
						+ "','"
						+ budgetorganizationid
						+ "','"
						+ budgettypeid
						+ "','"
						+ amount1
						+ "','"
						+ amount2
						+ "','"
						+ amount3
						+ "','"
						+ amount4
						+ "','"
						+ amount5
						+ "','"
						+ amount6
						+ "','"
						+ amount7
						+ "','"
						+ amount8
						+ "','"
						+ amount9
						+ "','"
						+ amount10
						+ "','"
						+ amount11
						+ "','"
						+ amount12
						+ "','"
						+ frozen1
						+ "','"
						+ frozen2
						+ "','"
						+ frozen3
						+ "','"
						+ frozen4
						+ "','"
						+ frozen5
						+ "','"
						+ frozen6
						+ "','"
						+ frozen7
						+ "','"
						+ frozen8
						+ "','"
						+ frozen9
						+ "','"
						+ frozen10
						+ "','"
						+ frozen11
						+ "','" + frozen12 + "') ");
			}else{
				rs2.execute("update uf_fullBudgetExcute set " +
						"amount1 = '"+ amount1 + "' , " +
						"amount2 = '" + amount2+ "' , " +
						"amount3 = '" + amount3+ "' , " +
						"amount4 = '" + amount4+ "' , " +
						"amount5 = '" + amount5+ "' , " +
						"amount6 = '" + amount6+ "' , " +
						"amount7 = '" + amount7+ "' , " +
						"amount8 = '" + amount8+ "' , " +
						"amount9 = '" + amount9+ "' , " +
						"amount10 = '" + amount10+ "' , " +
						"amount11 = '" + amount11+ "' , " +
						"amount12 = '" + amount12+ "' , " +
						"frozen1 = '"+ frozen1 + "' , " +
						"frozen2 = '" + frozen2+ "' , " +
						"frozen3 = '" + frozen3+ "' , " +
						"frozen4 = '" + frozen4+ "' , " +
						"frozen5 = '" + frozen5+ "' , " +
						"frozen6 = '" + frozen6+ "' , " +
						"frozen7 = '" + frozen7+ "' , " +
						"frozen8 = '" + frozen8+ "' , " +
						"frozen9 = '" + frozen9+ "' , " +
						"frozen10 = '" + frozen10+ "' , " +
						"frozen11 = '" + frozen11+ "' , " +
						"frozen12 = '" + frozen12+ "'  " +
						"where fnayear = '" + fnayear+ "' and departmentid = '" + budgetorganizationid+ "' and fnabudgettype = '" + budgettypeid + "'  ");
			}
		}
	}
	
	/**
	 * TODO 总表中的部门科目是否存在
	 * 2018-3-19
	 * @author guoj
	 */
	public boolean isExistDeptFnaType(String budgetorganizationid,String budgettypeid,String fnayear){
		String sql = "select id from uf_fullBudgetExcute where fnayear = '"+fnayear+"' and departmentid = '"+budgetorganizationid+"' and fnabudgettype = '"+budgettypeid+"'";
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		if(rs.next()){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * TODO 每月发生额/冻结数
	 * @param fnayear  				年份
	 * @param month    				月份
	 * @param budgetorganizationid 	部门
	 * @param budgettypeid			科目
	 * @param status				状态 0冻结   1审批
	 * 2018-3-19
	 * @author guoj
	 */
	public double getFnaAmountByTime(String fnayear,String month,String budgetorganizationid,String budgettypeid,String status){
		String sql = "select SUM(amount) as test from view_fnaoccur " +
				"where fnayear = '"+fnayear+"' and  status = '"+status+"' and organizationid = '"+budgetorganizationid+"' and subject = '"+budgettypeid+"' and SUBSTRING(occurdate,6,2) = '"+month+"'";
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		rs.next();
		double sum = Util.getDoubleValue(rs.getString(1),0.00);
		return sum;
	}
%>

