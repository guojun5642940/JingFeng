package weaver.interfaces.yaphets.role;

import java.util.ArrayList;
import javax.servlet.http.HttpServletResponse;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;

/**
 *
 * @ClassName: PowerUtil
 * @Description: TODO
 * @author xwd
 * @date 2013-9-12 上午15:28:00
 *
 */
public class PowerUtil extends BaseBean
{
	private RecordSet rs;
	private HrmRolesInfo hrif;

	public PowerUtil()
	{
		hrif = null;
		try
		{
			hrif = new HrmRolesInfo();
		}
		catch (Exception ex)
		{
			writeLog(ex+"new HrmRolesInfo对象 出现异常!");
		}
	}

	public void CheckModuleRole(String roleid,HttpServletResponse response,int userId)
	{
		System.out.println("进行入了权限控制类");
		//boolean rflag = false;
		String temp_role="";
		ArrayList rolelist = null;
		rolelist = (ArrayList)hrif.getRolesLitByHrmId(""+userId);
		if(!rolelist.contains(roleid))
		{   try{
			response.sendRedirect("/notice/noright.jsp");
		}catch(Exception ex){
			writeLog(ex+"使用工具类实现权限不够跳转页面出现异常!");
		}

		}
	}

	public boolean CheckModuleRole(String roleid,int userId)
	{
		System.out.println("进行入了权限控制类");
		boolean rflag = false;
		String temp_role="";
		ArrayList rolelist = null;
		rolelist = (ArrayList)hrif.getRolesLitByHrmId(""+userId);
		if(!rolelist.contains(roleid)&&(!"".equals(roleid)))
		{
			rflag = true;
		}
		return rflag;
	}
	public boolean CheckModuleRole(String roleid,String userId)
	{
		System.out.println("进行入了权限控制类");
		boolean rflag = false;
		String temp_role="";
		ArrayList rolelist = null;
		rolelist = (ArrayList)hrif.getRolesLitByHrmId(""+userId);
		if(!rolelist.contains(roleid)&&(!"".equals(roleid)))
		{
			rflag = true;
		}
		return rflag;
	}
}
