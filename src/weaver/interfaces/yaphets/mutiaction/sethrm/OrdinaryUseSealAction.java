package weaver.interfaces.yaphets.mutiaction.sethrm;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.yaphets.mutiaction.service.CommonService;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.request.RequestComInfo;
import weaver.workflow.workflow.WorkflowComInfo;

public class OrdinaryUseSealAction implements Action {

    private RequestComInfo requestComInfo;
    private weaver.workflow.workflow.WorkflowComInfo WorkflowComInfo;
    private BaseBean bs;

    public OrdinaryUseSealAction() {
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
        bs.writeLog("OrdinaryUseSealAction--进入action--workflowId：{"+workflowId+"},workflowName：{"+workflowName+"},requestId：{"+requestId+"},requestName：{"+requestName+"}");

        RecordSet rs = new RecordSet();
        RecordSet rsUpdate = new RecordSet();
        String mxTablename = CommonService.getFormTableName(workflowId);
        String sql = "select ggsfr from "+mxTablename+"_dt1 where mainid = (select id from "+mxTablename+" where requestid = '"+requestId+"')";
        rs.execute(sql);
        String rlzy = "";
        while(rs.next()){
            String	ggsfr = Util.null2String(rs.getString("ggsfr"));
            if((","+rlzy+",").indexOf(","+ggsfr+",") < 0){
                rlzy += (ggsfr+",");
            }
        }
        rlzy = rlzy.length()>0?(rlzy.substring(0,rlzy.length()-1)):"";
        //更新主表字段
        sql = "update "+mxTablename+" set rlzy = '"+rlzy+"' where requestId = '"+requestId+"'";
        bs.writeLog("sql-OrdinaryUseSealAction:["+sql+"]");
        rsUpdate.execute(sql);
        return SUCCESS;
    }
}
