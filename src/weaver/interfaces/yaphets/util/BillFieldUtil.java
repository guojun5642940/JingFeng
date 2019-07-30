package weaver.interfaces.yaphets.util;

import java.util.HashMap;
import java.util.Map;

import weaver.conn.RecordSet;
import weaver.general.Util;

/**
 * 
* 类描述：字段名称工具类 
* 创建者： ocean
* 项目名称： ecologyTest
* 创建时间： 2013-9-14 下午3:13:07
* 版本号： v1.0
 */
public class BillFieldUtil {
	
	 /**
	  *
	 * 方法描述 : 获取字段的ID
	 * 创建者：ocean
	 * 项目名称： ecologyTest
	 * 类名： CwUtil.java
	 * 版本： v1.0
	 * 创建时间： 2013-9-14 下午3:05:53
	 * @param workFlowId  流程id
	 * @param num         明细表
	 * @return Map
	  */
	 public static Map getFieldId(int formid,String num){
		  formid =  Math.abs(formid);
		  String sql = "";
		  if("0".equals(num))
		  {
			 sql = "select b.id,fieldname,detailtable from workflow_billfield b ,workflow_base a where b.billid=-"+formid+" and a.formid=b.billid and (detailtable is null or detailtable = '')";
		  }else {
			 sql = "select b.id,fieldname,detailtable from workflow_billfield b ,workflow_base a where b.billid=-"+formid+" and a.formid=b.billid and detailtable='formtable_main_"+formid+"_dt"+num+"'";
		  }

		  RecordSet rs = new RecordSet();
		  rs.execute(sql);
		  Map array = new HashMap();
		  while(rs.next()){
			  array.put(Util.null2String(rs.getString("fieldname")).toLowerCase(), Util.null2String(rs.getString("id")));
		  }
		  return array;
	 }
     
     
     
	 /**
	 *
	 * @Title: getlabelId
	 * @Description: TODO
	 * @param @param name   数据库字段名称
	 * @param @param formid 表单ID
	 * @param @param ismain 是否主表  0:主表 1：明细表
	 * @param @param num    明细表序号
	 * @param @return
	 * @return String
	 * @throws
	 */
	public static String getlabelId(String name,String formid,String ismain ,String num)
	{
		String id = "";
		String sql = "";
		if("0".equals(ismain))
		{
			sql = "select b.id,fieldname,detailtable from workflow_billfield b ,workflow_base a where b.billid=-"+formid+" and a.formid=b.billid and lower(fieldname)='"+name+"'";
		}else {
			sql = "select b.id,fieldname,detailtable from workflow_billfield b ,workflow_base a where b.billid=-"+formid+" and a.formid=b.billid and detailtable='formtable_main_"+formid+"_dt"+num+"' and lower(fieldname)='"+name+"'";
		}
		//System.out.println(sql);
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		rs.next();
		id = Util.null2String(rs.getString("id"));
		return id ;
	}
}
