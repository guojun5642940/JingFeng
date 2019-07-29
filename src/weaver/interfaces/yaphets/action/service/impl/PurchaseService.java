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
 * @Description: 固定资产采购申请
 * @date 2019/7/2915:22
 */
public class PurchaseService extends BaseBean implements FixedAssetsServiceIfr {
    @Override
    public JSONObject excute(RequestInfo request) {
        JSONObject result = new JSONObject();
        ActionMapUtil aUtil = new ActionMapUtil(request);
        Map dataMap = aUtil.getDataMap();

        String gdzcm = Util.null2String(dataMap.get("gdzcm".toLowerCase()).toString());




        return result;
    }
}
