package weaver.interfaces.yaphets.mutiaction.service;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.yaphets.mutiaction.GdzcDto;
import weaver.interfaces.yaphets.util.ActionMapUtil;
import weaver.interfaces.yaphets.util.CommonUtil;
import weaver.interfaces.yaphets.util.Constants;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.request.RequestComInfo;
import weaver.workflow.workflow.WorkflowComInfo;

import java.util.Map;

/**
 *  @author: guojun
 *  @Date: 2020/11/4 23:07
 *  @Description: 固定资产调拨流程-多明细
 */
public class MutiFixedAssetsAllocationServiceImpl implements Action {

    private RequestComInfo requestComInfo;
    private WorkflowComInfo WorkflowComInfo;
    private BaseBean bs;

    public MutiFixedAssetsAllocationServiceImpl() {
        try {
            requestComInfo = new RequestComInfo();
            WorkflowComInfo = new WorkflowComInfo();
        } catch (Exception e) {
            e.printStackTrace();
        }
        bs = new BaseBean();
    }

    @Override
    public String execute(RequestInfo request) {
        String workflowId = request.getWorkflowid();
        String requestId = request.getRequestid();
        String requestName = requestComInfo.getRequestname(requestId);
        String workflowName = WorkflowComInfo.getWorkflowname(workflowId);
        bs.writeLog("MutiFixedAssetsAllocationServiceImpl--进入action--workflowId：{"+workflowId+"},workflowName：{"+workflowName+"},requestId：{"+requestId+"},requestName：{"+requestName+"}");

        ActionMapUtil aUtil = new ActionMapUtil(request);
        Map dataMap = aUtil.getDataMap();
        String fqrq = Util.null2String(dataMap.get("fqrq".toLowerCase()).toString());

        RecordSet rs = new RecordSet();
        RecordSet rsUpdate = new RecordSet();
        String mxTablename = CommonService.getFormTableName(workflowId);
        String sql = "select * from "+mxTablename+"_dt1 where mainid = (select id from "+mxTablename+" where requestid = '"+requestId+"')";
        rs.execute(sql);
        while(rs.next()){
            String	cfdd = Util.null2String(rs.getString("cfdd")); //存放地点
            String	gdzcbm = Util.null2String(rs.getString("gdzcbm")); //固定资产编码 实际存资产卡片ID
            String	xsybm = Util.null2String(rs.getString("xsybm")); //现使用部门
            String	xsyr = Util.null2String(rs.getString("xsyr")); //现使用人
            String	xsyzx = Util.null2String(rs.getString("xsyzx")); //现使用中心
            String updateSql = "update "+ Constants.MODEL_TABLENAME_GDZC +" set syr = '"+xsyr+"'," +
                    "sybm='"+xsybm+"',lyrq='"+fqrq+"',syzx='"+xsyzx+"',cfdd = '"+cfdd+"',zczt='1' where id = '"+gdzcbm+"' ";
            bs.writeLog("sql-MutiFixedAssetsAllocationServiceImpl:["+sql+"]");
            rsUpdate.execute(updateSql);
        }
        return SUCCESS;
    }
}
