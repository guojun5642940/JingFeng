package weaver.interfaces.yaphets.action.factory;

import weaver.interfaces.yaphets.action.service.ifr.FixedAssetsServiceIfr;
import weaver.interfaces.yaphets.action.service.impl.*;
import weaver.interfaces.yaphets.util.Constants;

/**
 * @author guoj
 * @Title: ActionFactory
 * @ProjectName JingFeng
 * @Description: TODO
 * @date 2019/7/2914:54
 */
public class ActionFactory {

    /**
     * 获取处理类
     * @param workflowId
     * @return
     */
    public FixedAssetsServiceIfr createActionHandle(int workflowId){
        FixedAssetsServiceIfr fixedAssetsServiceIfr;
        switch (workflowId){
            case Constants.WORKFLOWID_ALLOCATION_APPLICATION :
                fixedAssetsServiceIfr = new AllocationApplicationService();
                break;
            case Constants.WORKFLOWID_PURCHASE:
                fixedAssetsServiceIfr = new PurchaseService();
                break;
             case Constants.WORKFLOWID_BATCH_PURCHASE:
                 fixedAssetsServiceIfr = new BatchPurchaseService();
                 break;
             case Constants.WORKFLOWID_SCRAP:
                fixedAssetsServiceIfr = new ScrapService();
                break;
            case Constants.WORKFLOWID_RETURN:
                fixedAssetsServiceIfr = new ReturnService();
                break;
            default:
                fixedAssetsServiceIfr = null;
        }
        return fixedAssetsServiceIfr;
    }
}
