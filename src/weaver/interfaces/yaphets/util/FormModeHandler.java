package weaver.interfaces.yaphets.util;

import java.util.Map;
import java.util.Map.Entry;

import weaver.conn.RecordSet;
import weaver.formmode.data.ModeDataIdUpdate;
import weaver.formmode.setup.CodeBuild;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.BaseBean;
import weaver.general.TimeUtil;
import weaver.general.Util;

public class FormModeHandler extends BaseBean{
	private ModeDataIdUpdate ModeDataIdUpdate = new ModeDataIdUpdate();
	
	public int saveModeData(String modeid, String userid,Map<String, String> formDataMap,String fieldName){
		boolean isSuc = false;
		String currentdate = TimeUtil.getCurrentDateString();
		String currenttime = TimeUtil.getOnlyCurrentTimeString();
		String billtablename = getModeTableName(modeid);
		int formmodeid = Integer.parseInt(modeid);
		int billid = ModeDataIdUpdate.getModeDataNewId(billtablename,formmodeid, Integer.parseInt(userid), 0, currentdate,currenttime);
		writeLog("billid:" + billid);
		if (billid < 1) {
			return billid;
		}
		
		String codeStr = "";
		if(!"".equals(fieldName) && fieldName != null){
			CodeBuild cbuild = new CodeBuild(formmodeid);
			codeStr = cbuild.getModeCodeStr(formmodeid, billid);// 生成编号
			formDataMap.put(fieldName, codeStr);
		}
		
		RecordSet rs = new RecordSet();
		String updateclause = "";
		String dbtype = rs.getDBType();
		String fieldname = "";
		String fieldvalue = "";
		for (Entry<String, String> entry : formDataMap.entrySet()) {
			fieldname = Util.null2String(entry.getKey());
			fieldvalue = parseSpecialChar(dbtype,
					Util.null2String(entry.getValue()));
			if(!"".equals(fieldname)){
				updateclause += fieldname + " = '" + fieldvalue + "',";
			}
		}
		writeLog("updateclause:" + updateclause);

		if (!updateclause.equals("")) {
			updateclause = updateclause.substring(0, updateclause.length() - 1);
			updateclause = " update " + billtablename + " set " + updateclause
					+ " where id = " + billid;
			writeLog("插入主表数据sql:" + updateclause);
			isSuc = rs.executeSql(updateclause);
			if (!isSuc) {
				return billid;
			}
		}
		ModeRightInfo moderight = new ModeRightInfo();
		moderight.editModeDataShare(Integer.parseInt(userid), formmodeid,
				billid);
		return billid;
	}
	
	
	/**
	 * 功能：保存数据(更新)
	 * param modeid 建模ID
	 * param userid 用户ID
	 * param formDataMap 字段集合
	 * @author guojun
	 * 2016-8-29
	 */
	public boolean EditsaveModeData(String billid,String modeid, String userid,Map<String, String> formDataMap){
		boolean isSuc = false;
		String billtablename = getModeTableName(modeid);

		RecordSet rs = new RecordSet();
		String updateclause = "";
		String dbtype = rs.getDBType();
		String fieldname = "";
		String fieldvalue = "";
		for (Entry<String, String> entry : formDataMap.entrySet()) {
			fieldname = Util.null2String(entry.getKey());
			fieldvalue = parseSpecialChar(dbtype,
					Util.null2String(entry.getValue()));
			updateclause += fieldname + " = '" + fieldvalue + "',";
		}

		if (!updateclause.equals("")) {
			updateclause = updateclause.substring(0, updateclause.length() - 1);
			updateclause = " update " + billtablename + " set " + updateclause
					+ " where id = " + billid;
			isSuc = rs.executeSql(updateclause);
			writeLog("EditsaveModeData[updateclause]:" + updateclause);
		}
		return isSuc;
	}
	
	/**
	 * 功能：获取表单建模的表名
	 * @author guojun
	 * 2016-8-29
	 */
	public String getModeTableName(String modeid){
		String sql = "select b.tablename,a.formid,b.detailkeyfield from modeinfo a,workflow_bill b where a.formid = b.id and a.id  ="
				+ modeid;
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		rs.next();
		String billtablename = rs.getString(1);
		return billtablename;
	}
	
	/**
	 * 处理特殊字符
	 * @param dbtype  数据库类型
	 * @param s 字符串
	 * @return
	 */
	private static String parseSpecialChar(String dbtype, String s) {
		String str = Util.null2String(s);
		if (!s.equals("")) {
			if (str.indexOf("'") > -1) {
				str = str.replaceAll("\'", "''");
			}
			if (dbtype.equalsIgnoreCase("oracle")) {
				if (str.indexOf("&") > -1) {
					str = str.replaceAll("&", "'||chr(38)||'");
				}
			}
		}
		return str;
	}
	
	/**
	 * 功能：建模姓名
	 * @author guojun
	 * 2016-9-28
	 */
	public String getModeName(String modeid){
		String sql = "select modename from modeinfo where id = '"+modeid+"'";
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		if(rs.next()){
			return Util.null2String(rs.getString(1));
		}else{
			return "";
		}
	}
}
