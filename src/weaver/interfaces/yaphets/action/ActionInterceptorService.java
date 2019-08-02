package weaver.interfaces.yaphets.action;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import weaver.general.BaseBean;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.yaphets.action.factory.ActionFactory;
import weaver.interfaces.yaphets.action.service.ifr.FixedAssetsServiceIfr;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.request.RequestComInfo;
import weaver.workflow.workflow.WorkflowComInfo;

/**
 * @author guoj
 * @Title: ActionInterceptorService
 * @ProjectName JingFeng
 * @Description: TODO
 * @date 2019/7/2914:37
 */
public class ActionInterceptorService  implements Action {

    private RequestComInfo requestComInfo;
    private WorkflowComInfo WorkflowComInfo;
    private BaseBean bs;

    public ActionInterceptorService() {
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
        bs.writeLog("ActionInterceptorService--进入action--workflowId：{"+workflowId+"},workflowName：{"+workflowName+"},requestId：{"+requestId+"},requestName：{"+requestName+"}");
//        ActionFactory factory = new ActionFactory();
//        FixedAssetsServiceIfr service = factory.createActionHandle(Integer.parseInt(workflowId));
//        JSONObject result = service.excute(request);
//        try {
//            String flag = Util.null2String(result.get("flag"));
//            String msg = Util.null2String(result.get("msg"));
//            if("false".equals(flag)){
//                request.getRequestManager().setMessagecontent(msg);
//                request.getRequestManager().setMessageid(TimeUtil.getCurrentTimeString());
//            }
//        } catch (JSONException e) {
//            e.printStackTrace();
//        }
        return SUCCESS;
    }
}
