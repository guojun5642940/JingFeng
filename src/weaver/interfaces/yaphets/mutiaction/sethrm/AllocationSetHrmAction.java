package weaver.interfaces.yaphets.mutiaction.sethrm;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.yaphets.mutiaction.service.CommonService;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.request.RequestComInfo;
import weaver.workflow.workflow.WorkflowComInfo;

/**
 *  @author: guojun
 *  @Date: 2020/11/21 14:06
 *  @Description: 调拨流程 明细表的负责人字段的值传到主表的多人力资源
 */
public class AllocationSetHrmAction implements Action {
    private RequestComInfo requestComInfo;
    private weaver.workflow.workflow.WorkflowComInfo WorkflowComInfo;
    private BaseBean bs;

    public AllocationSetHrmAction() {
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
        bs.writeLog("AllocationSetHrmAction--进入action--workflowId：{"+workflowId+"},workflowName：{"+workflowName+"},requestId：{"+requestId+"},requestName：{"+requestName+"}");

        RecordSet rs = new RecordSet();
        RecordSet rsUpdate = new RecordSet();
        String mxTablename = CommonService.getFormTableName(workflowId);
        String sql = "select bmzrr from "+mxTablename+"_dt1 where mainid = (select id from "+mxTablename+" where requestid = '"+requestId+"')";
        rs.execute(sql);
        String drlzy = "";
        while(rs.next()){
            String	xfzr = Util.null2String(rs.getString("xfzr"));
            drlzy += (xfzr+",");
        }
        drlzy = drlzy.length()>0?(drlzy.substring(0,drlzy.length()-1)):"";
        //更新主表字段
        sql = "update "+mxTablename+" set drlzy = '"+drlzy+"' where requestId = '"+requestId+"'";
        bs.writeLog("sql-AllocationSetHrmAction:["+sql+"]");
        rsUpdate.execute(sql);
        return SUCCESS;
    }
}
