package weaver.interfaces.yaphets.action.service.impl;

import net.sf.json.JSONObject;
import weaver.general.BaseBean;
import weaver.interfaces.yaphets.action.service.ifr.FixedAssetsServiceIfr;
import weaver.interfaces.yaphets.util.ActionMapUtil;
import weaver.interfaces.yaphets.util.CommonUtil;
import weaver.soa.workflow.request.RequestInfo;

import java.util.Map;

/**
 * @author guoj
 * @Title: BatchPurchaseService
 * @ProjectName JingFeng
 * @Description: 批量申请
 * @date 2019/7/3016:33
 */
public class BatchPurchaseService extends BaseBean implements FixedAssetsServiceIfr {

    @Override
    public JSONObject excute(RequestInfo request) {
        JSONObject result = new JSONObject();
        result.put("flag",true);
        String requestId = request.getRequestid();
        ActionMapUtil aUtil = new ActionMapUtil(request);
        Map dataMap = aUtil.getDataMap();
        String currentNodeid = CommonUtil.getCurrentNodeId(requestId);

        return null;
    }
}
