package weaver.interfaces.yaphets.mutiaction.service;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.yaphets.util.ActionMapUtil;
import weaver.interfaces.yaphets.util.Constants;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.request.RequestComInfo;
import weaver.workflow.workflow.WorkflowComInfo;

import java.util.Map;

/**
 *  @author: guojun
 *  @Date: 2020/11/7 13:02
 *  @Description: 固定资产返还
 */
public class MutiFixedAssetsReturnServiceImpl implements Action {

    private RequestComInfo requestComInfo;
    private weaver.workflow.workflow.WorkflowComInfo WorkflowComInfo;
    private BaseBean bs;

    public MutiFixedAssetsReturnServiceImpl() {
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
        bs.writeLog("MutiFixedAssetsReturnServiceImpl--进入action--workflowId：{"+workflowId+"},workflowName：{"+workflowName+"},requestId：{"+requestId+"},requestName：{"+requestName+"}");

        ActionMapUtil aUtil = new ActionMapUtil(request);
        Map dataMap = aUtil.getDataMap();

        RecordSet rs = new RecordSet();
        RecordSet rsUpdate = new RecordSet();
        String mxTablename = CommonService.getFormTableName(workflowId);
        String sql = "select * from "+mxTablename+"_dt1 where mainid = (select id from "+mxTablename+" where requestid = '"+requestId+"')";
        rs.execute(sql);
        while(rs.next()){
            String gdzcbm = Util.null2String(rs.getString("gdzcbm"));
            String updateSql = "update "+ Constants.MODEL_TABLENAME_GDZC+" set zczt = '0',syr='',sybm='',syzx='',lyrq='',cfdd='' where id = '"+gdzcbm+"'";
            bs.writeLog("MutiFixedAssetsReturnServiceImpl-updateSql["+requestId+"]+"+updateSql);
            rsUpdate.execute(updateSql);
        }
        return SUCCESS;
    }
}
