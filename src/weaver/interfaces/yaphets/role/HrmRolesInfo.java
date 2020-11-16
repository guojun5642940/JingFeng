package weaver.interfaces.yaphets.role;

import java.util.ArrayList;
import java.util.List;

import weaver.conn.RecordSet;
import weaver.general.Util;

public class HrmRolesInfo {
	/**
	 * 获取人员的角色
	 * @param hrmId
	 * @return
	 */
	public List getRolesLitByHrmId(String hrmId){
		List list = new ArrayList();
		RecordSet rs = new RecordSet();
		String sql = "select a.id as rid,rolesname from hrmroles a left outer join HrmRoleMembers b on a.id=b.roleid where resourceid="+hrmId;
		rs.executeSql(sql);
		while(rs.next()){
			list.add(Util.null2String(rs.getString("rid")));
		}
		return list;
	}

	public List getHrmIdByRole(String RoleId){
		List list = new ArrayList();
		RecordSet rs = new RecordSet();
		String sql = "select resourceid from hrmroles a left outer join HrmRoleMembers b on a.id=b.roleid where a.id='"+RoleId+"'";
		rs.executeSql(sql);
		while(rs.next()){
			list.add(Util.null2String(rs.getString("resourceid")));
		}
		return list;
	}
}
