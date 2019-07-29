package weaver.interfaces.yaphets.action.service.ifr;

import net.sf.json.JSONObject;
import weaver.soa.workflow.request.RequestInfo;

public interface FixedAssetsServiceIfr {
    JSONObject excute(RequestInfo request);
}
