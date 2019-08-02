package weaver.interfaces.yaphets.action.service.impl;

import net.sf.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.yaphets.action.service.ifr.FixedAssetsServiceIfr;
import weaver.interfaces.yaphets.util.ActionMapUtil;
import weaver.interfaces.yaphets.util.CommonUtil;
import weaver.interfaces.yaphets.util.Constants;
import weaver.soa.workflow.request.RequestInfo;

import java.util.Map;

public class ScrapService  extends BaseBean implements FixedAssetsServiceIfr {
    @Override
    public JSONObject excute(RequestInfo request) {

        JSONObject result = new JSONObject();
        result.put("flag",true);
        String requestId = request.getRequestid();
        ActionMapUtil aUtil = new ActionMapUtil(request);

        String sql = "select * from "+ Constants.WORKFLOW_TABLENAME_SCRAP +"_dt1 where mainid = (select id from "+Constants.WORKFLOW_TABLENAME_SCRAP+" where requestid = '"+requestId+"')";
        RecordSet rs = new RecordSet();
        RecordSet rsUpdate = new RecordSet();
        rs.execute(sql);
        while(rs.next()){
            String gdzcbm = Util.null2String(rs.getString("gdzcbm"));
            String zczt = Util.null2String(rs.getString("zczt"));
            String updateSql = "update "+Constants.MODEL_TABLENAME_GDZC+" set zczt = '"+zczt+"' where gdzcbm = '"+gdzcbm+"'";
            writeLog("updateSql["+requestId+"]+"+updateSql);
            rsUpdate.execute(sql);

        }
        return result;
    }
}
