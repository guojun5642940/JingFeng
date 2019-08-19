package weaver.interfaces.yaphets.action.service.impl;

import net.sf.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.yaphets.action.service.ifr.FixedAssetsServiceIfr;
import weaver.interfaces.yaphets.util.ActionMapUtil;
import weaver.interfaces.yaphets.util.Constants;
import weaver.soa.workflow.request.RequestInfo;

import java.util.Map;

public class ReturnService  extends BaseBean implements FixedAssetsServiceIfr {
    @Override
    public JSONObject excute(RequestInfo request) {

        String requestId = request.getRequestid();
        JSONObject result = new JSONObject();
        result.put("flag",true);
        ActionMapUtil aUtil = new ActionMapUtil(request);
        Map dataMap = aUtil.getDataMap();

//        String syr = Util.null2String(dataMap.get("syr".toLowerCase()).toString());
//        String sybm = Util.null2String(dataMap.get("sybm".toLowerCase()).toString());
//        String syzx = Util.null2String(dataMap.get("syzx".toLowerCase()).toString());
        String gdzcbm = Util.null2String(dataMap.get("gdzcbm".toLowerCase()).toString());
        RecordSet rsUpdate = new RecordSet();

        try {
            String updateSql = "update "+ Constants.MODEL_TABLENAME_GDZC+" set zczt = '0',syr='',sybm='',syzx='',lyrq='' where id = '"+gdzcbm+"'";
            writeLog("ReturnService-updateSql["+requestId+"]+"+updateSql);
            boolean isSuccess = rsUpdate.execute(updateSql);
            if(!isSuccess){
                result.put("flag",false);
                result.put("msg","数据更新错误，请联系管理员");
            }
        } catch (Exception e) {
            result.put("flag",false);
            result.put("msg","数据库脚本执行失败:"+e.getMessage()+",请联系管理员！");
            e.printStackTrace();
        }
        return result;
    }
}
