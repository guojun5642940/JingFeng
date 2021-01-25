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
 *  @Description: 固定资产归还 明细表的负责人字段的值传到主表的多人力资源
 */
public class ReturnSetHrmAction implements Action {
    private RequestComInfo requestComInfo;
    private weaver.workflow.workflow.WorkflowComInfo WorkflowComInfo;
    private BaseBean bs;

    public ReturnSetHrmAction() {
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
        bs.writeLog("ReturnSetHrmAction--进入action--workflowId：{"+workflowId+"},workflowName：{"+workflowName+"},requestId：{"+requestId+"},requestName：{"+requestName+"}");

        RecordSet rs = new RecordSet();
        RecordSet rsUpdate = new RecordSet();
        String mxTablename = CommonService.getFormTableName(workflowId);
        String sql = "select fzr from "+mxTablename+"_dt1 where mainid = (select id from "+mxTablename+" where requestid = '"+requestId+"')";
        rs.execute(sql);
        String drlzy = "";
        while(rs.next()){
            String	fzr = Util.null2String(rs.getString("fzr"));
            if((","+drlzy+",").indexOf(","+fzr+",") < 0){
                drlzy += (fzr+",");
            }
        }
        drlzy = drlzy.length()>0?(drlzy.substring(0,drlzy.length()-1)):"";
        //更新主表字段
        sql = "update "+mxTablename+" set fzr = '"+drlzy+"' where requestId = '"+requestId+"'";
        bs.writeLog("sql-ReturnSetHrmAction:["+sql+"]");
        rsUpdate.execute(sql);
        return SUCCESS;
    }
}
