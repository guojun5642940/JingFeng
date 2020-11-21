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
 *  @Date: 2020/11/21 14:07
 *  @Description:  采购流程 明细表的负责人字段的值和使用人字段的值传到主表的多人力资源字段
 */
public class PurchaseSetHrmAction implements Action {
    private RequestComInfo requestComInfo;
    private weaver.workflow.workflow.WorkflowComInfo WorkflowComInfo;
    private BaseBean bs;

    public PurchaseSetHrmAction() {
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
        bs.writeLog("PurchaseSetHrmAction--进入action--workflowId：{"+workflowId+"},workflowName：{"+workflowName+"},requestId：{"+requestId+"},requestName：{"+requestName+"}");

        RecordSet rs = new RecordSet();
        RecordSet rsUpdate = new RecordSet();
        String mxTablename = CommonService.getFormTableName(workflowId);
        String sql = "select bmzrr from "+mxTablename+"_dt1 where mainid = (select id from "+mxTablename+" where requestid = '"+requestId+"')";
        rs.execute(sql);
        String fzrd = "";
        String syrd = "";
        while(rs.next()){
            String bmzrr = Util.null2String(rs.getString("bmzrr"));
            String syr = Util.null2String(rs.getString("syr"));
            fzrd += (bmzrr+",");
            syrd += (syr+",");
        }
        fzrd = fzrd.length()>0?(fzrd.substring(0,fzrd.length()-1)):"";
        syrd = syrd.length()>0?(syrd.substring(0,syrd.length()-1)):"";
        //更新主表字段
        sql = "update "+mxTablename+" set fzrd = '"+fzrd+"',syrd = '"+syrd+"' where requestId = '"+requestId+"'";
        bs.writeLog("sql-PurchaseSetHrmAction:["+sql+"]");
        rsUpdate.execute(sql);
        return SUCCESS;
    }
}
