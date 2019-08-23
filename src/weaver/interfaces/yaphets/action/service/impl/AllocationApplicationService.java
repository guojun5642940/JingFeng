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

/**
 * @author guoj
 * @Title: AllocationApplicationService
 * @ProjectName JingFeng
 * @Description: 固定资产调拨申请流程
 * @date 2019/7/2915:22
 */
public class AllocationApplicationService extends BaseBean implements FixedAssetsServiceIfr {
    @Override
    public JSONObject excute(RequestInfo request) {
        JSONObject result = new JSONObject();
        ActionMapUtil aUtil = new ActionMapUtil(request);
        Map dataMap = aUtil.getDataMap();

        String gdzcm = Util.null2String(dataMap.get("gdzcm".toLowerCase()).toString());
        String xsyr = Util.null2String(dataMap.get("xsyr".toLowerCase()).toString());
        String xsybm = Util.null2String(dataMap.get("xsybm".toLowerCase()).toString());
        String xsyzx = Util.null2String(dataMap.get("xsyzx".toLowerCase()).toString());
        String fqrq = Util.null2String(dataMap.get("fqrq".toLowerCase()).toString());
        String cfdd = Util.null2String(dataMap.get("cfdd".toLowerCase()).toString());

        String sql = "update "+ Constants.MODEL_TABLENAME_GDZC +" set syr = '"+xsyr+"'," +
                "sybm='"+xsybm+"',lyrq='"+fqrq+"',syzx='"+xsyzx+"',cfdd = '"+cfdd+"',cfdd='1' where id = '"+gdzcm+"' ";
        writeLog("sql-AllocationApplicationService:["+sql+"]");
        RecordSet rs = new RecordSet();
        try {
            boolean isSuccess = rs.execute(sql);
            result.put("flag",isSuccess);
            result.put("msg",isSuccess?"":"数据库脚本执行失败，请联系管理员！");
        } catch (Exception e) {
            result.put("flag",false);
            result.put("msg","数据库脚本执行失败:"+e.getMessage()+",请联系管理员！");
            e.printStackTrace();
        }
        return result;
    }
}
