package weaver.interfaces.yaphets.util;

/**
 * @author guoj
 * @Title: Constants
 * @ProjectName JingFeng
 * @Description: TODO
 * @date 2019/7/2915:17
 */
public class Constants {

    /*****************************测试环境************************************/
    /**
     * 固定资产调拨申请流程-WFID
     */
    public static final int WORKFLOWID_ALLOCATION_APPLICATION = 740;

    /**
     * 固定资产采购申请流程-WFID
     */
    public static final int WORKFLOWID_PURCHASE = 741;

    /**
     * 固定资产卡片批量录入-WFID
     */
    public static final int WORKFLOWID_BATCH_PURCHASE = 742;


    /**
     * 固定资产报废申请-WFID
     */
    public static final int WORKFLOWID_SCRAP = 744;

    /**
     * 固定资产归还-WFID
     */
    public static final int WORKFLOWID_RETURN = 745;


    /**
     * 固定资产采购申请流程-tableName
     */
    public static final String WORKFLOW_TABLENAME_GDZCSQ = "formtable_main_490";

    /**
     * 固定资产卡片批量录入-tableName
     */
    public static final String WORKFLOW_TABLENAME_BATCH_PURCHASE = "formtable_main_491";

    /**
     * 固定资产报废申请-WFID
     */
    public static final String WORKFLOW_TABLENAME_SCRAP = "formtable_main_493";

    /**
     * 固定资产-建模-表名
     */
    public static final String MODEL_TABLENAME_GDZC = "uf_zckp";

    /**
     * 固定资产-建模-MODEID
     */
    public static final String MODEID_GDZC = "23";

    /**
     * 固定资产盘点记录-建模-MODEID
     */
    public static final String MODEID_GDZC_CHECKSTATE = "25";


    /**
     * 固定资产采购申请流程-发起节点nodeid
     */
    public static final String NODEID_FIRST_GDZCSQ = "8392";

    /**
     * 固定资产采购申请流程-归档前节点(目前为了测试写第一个节点)
     */
    public static final String NODEID_LAST_GDZCSQ = "8392";

    /**
     * 固定资产批量录入流程-发起节点nodeid
     */
    public static final String NODEID_FIRST_PLLR = "8387";

    /**
     * 固定资产批量录入流程-归档前节点(目前为了测试写第一个节点)
     */
    public static final String NODEID_LAST_PLLR = "8387";






    /*****************************生产环境************************************/
//    /**
//     * 固定资产调拨申请流程-WFID
//     */
//    public static final int WORKFLOWID_ALLOCATION_APPLICATION = 748;
//
//    /**
//     * 固定资产采购申请流程-WFID
//     */
//    public static final int WORKFLOWID_PURCHASE = 749;
//
//    /**
//     * 固定资产卡片批量录入-WFID
//     */
//    public static final int WORKFLOWID_BATCH_PURCHASE = 750;
//
//
//    /**
//     * 固定资产报废申请-WFID
//     */
//    public static final int WORKFLOWID_SCRAP = 752;
//
//    /**
//     * 固定资产归还-WFID
//     */
//    public static final int WORKFLOWID_RETURN = 753;
//
//
//    /**
//     * 固定资产采购申请流程-tableName
//     */
//    public static final String WORKFLOW_TABLENAME_GDZCSQ = "formtable_main_501";
//
//    /**
//     * 固定资产卡片批量录入-tableName
//     */
//    public static final String WORKFLOW_TABLENAME_BATCH_PURCHASE = "formtable_main_502";
//
//    /**
//     * 固定资产报废申请-WFID
//     */
//    public static final String WORKFLOW_TABLENAME_SCRAP = "formtable_main_504";
//
//    /**
//     * 固定资产-建模-表名
//     */
//    public static final String MODEL_TABLENAME_GDZC = "uf_zckp";
//
//    /**
//     * 固定资产-建模-MODEID
//     */
//    public static final String MODEID_GDZC = "22";
//
//    /**
//     * 固定资产盘点记录-建模-MODEID
//     */
//    public static final String MODEID_GDZC_CHECKSTATE = "24";
//
//
//    /**
//     * 固定资产采购申请流程-发起节点nodeid
//     */
//    public static final String NODEID_FIRST_GDZCSQ = "8491";
//
//    /**
//     * 固定资产采购申请流程-归档前节点(目前为了测试写第一个节点)
//     */
//    public static final String NODEID_LAST_GDZCSQ = "8392";
//
//    /**
//     * 固定资产批量录入流程-发起节点nodeid
//     */
//    public static final String NODEID_FIRST_PLLR = "8387";
//
//    /**
//     * 固定资产批量录入流程-归档前节点(目前为了测试写第一个节点)
//     */
//    public static final String NODEID_LAST_PLLR = "8387";

}
