package weaver.interfaces.yaphets.action.service.impl;

import net.sf.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.yaphets.action.service.ifr.FixedAssetsServiceIfr;
import weaver.interfaces.yaphets.util.ActionMapUtil;
import weaver.interfaces.yaphets.util.CommonUtil;
import weaver.interfaces.yaphets.util.Constants;
import weaver.interfaces.yaphets.util.FormModeHandler;
import weaver.soa.workflow.request.RequestInfo;

import javax.resource.cci.Record;
import java.util.HashMap;
import java.util.Map;

/**
 * @author guoj
 * @Title: AllocationApplicationService
 * @ProjectName JingFeng
 * @Description: 固定资产采购申请
 * @date 2019/7/2915:22
 */
public class PurchaseService extends BaseBean implements FixedAssetsServiceIfr {
    @Override
    public JSONObject excute(RequestInfo request) {
        String requestId = request.getRequestid();
        JSONObject result = new JSONObject();
        result.put("flag",true);
        ActionMapUtil aUtil = new ActionMapUtil(request);
        Map dataMap = aUtil.getDataMap();
        String currentNodeid = CommonUtil.getCurrentNodeId(requestId);

        String gdzcbm = "";
        //第一个节点后生成固定资产码
        if(Constants.NODEID_FIRST_GDZCSQ.equals(currentNodeid)){
            //公司名称
            String dwmc = Util.null2String(dataMap.get("dwmc".toLowerCase()).toString());
            String zclb = Util.null2String(dataMap.get("zclb".toLowerCase()).toString());
            String zclx = Util.null2String(dataMap.get("zclx".toLowerCase()).toString());
            gdzcbm = Util.null2String(dataMap.get("gdzcbm".toLowerCase()).toString());

            String zclbCode = "";
            if("0".equals(zclb)){
                //固定资产
                zclbCode = "GD";
            }else if("1".equals(zclb)){
                zclbCode = "DZ";
            }
            if("".equals(gdzcbm)){
                gdzcbm = CommonUtil.createAssetsCode(dwmc,zclbCode,zclx);
                writeLog("requestId:"+requestId+"获取流水号："+gdzcbm);
            }
            String sql = "update "+Constants.WORKFLOW_TABLENAME_GDZCSQ+" set gdzcbm ='"+gdzcbm+"' where requestid = '"+requestId+"'";
            RecordSet rs = new RecordSet();
            try {
                boolean isSuccess = rs.execute(sql);
                if(!isSuccess){
                    result.put("flag",false);
                    result.put("msg","数据存入建模错误，请联系管理员");
                }
            } catch (Exception e) {
                result.put("flag",false);
                result.put("msg","数据库脚本执行失败:"+e.getMessage()+",请联系管理员！");
                e.printStackTrace();
            }
        }

        //归档前一个节点写入表单建模
        if(Constants.NODEID_LAST_GDZCSQ.equals(currentNodeid)){
            boolean importResult = saveModeData(dataMap,gdzcbm);
            if(!importResult){
                result.put("flag",false);
                result.put("msg","数据库脚本执行失败，请联系管理员！");
            }
        }
        return result;
    }

    /**
     * 保存进资产卡片
     * @param dataMap
     * @return
     */
    public boolean saveModeData(Map dataMap,String gdzcbm){
        FormModeHandler modeHandler = new FormModeHandler();
        String dwmc = Util.null2String(dataMap.get("dwmc".toLowerCase()).toString());
        String zclb = Util.null2String(dataMap.get("zclb".toLowerCase()).toString());
        String zclx = Util.null2String(dataMap.get("zclx".toLowerCase()).toString());
        String ggxh = Util.null2String(dataMap.get("ggxh".toLowerCase()).toString());
        String jldw = Util.null2String(dataMap.get("jldw".toLowerCase()).toString());
        String gmdj = Util.null2String(dataMap.get("gmdj".toLowerCase()).toString());
        String gzrq = Util.null2String(dataMap.get("gzrq".toLowerCase()).toString());
        String syzx = Util.null2String(dataMap.get("syzx".toLowerCase()).toString());
        String cgr = Util.null2String(dataMap.get("cgr".toLowerCase()).toString());
        String syr = Util.null2String(dataMap.get("syr".toLowerCase()).toString());
        String sybm = Util.null2String(dataMap.get("sybm".toLowerCase()).toString());
        String cfdd = Util.null2String(dataMap.get("cfdd".toLowerCase()).toString());
        String bmzrr = Util.null2String(dataMap.get("bmzrr".toLowerCase()).toString());
        String lyrq = Util.null2String(dataMap.get("lyrq".toLowerCase()).toString());
        String zczt = "1";

        Map<String, String> formDataMap = new HashMap<>();
        formDataMap.put("gsmc" ,dwmc);
        formDataMap.put("zclb" ,zclb);
        formDataMap.put("zclx" ,zclx);
        formDataMap.put("ggxh" ,ggxh);
        formDataMap.put("gdzcbm" ,gdzcbm);
        formDataMap.put("jldw" ,jldw);
        formDataMap.put("gmdj" ,gmdj);
        formDataMap.put("gzrq" ,gzrq);
        formDataMap.put("syzx" ,syzx);
        formDataMap.put("cgr" ,cgr);
        formDataMap.put("syr" ,syr);
        formDataMap.put("sybm" ,sybm);
        formDataMap.put("cfdd" ,cfdd);
        formDataMap.put("bmzrr" ,bmzrr);
        formDataMap.put("lyrq" ,lyrq);
        formDataMap.put("zczt" ,zczt);

        int modeDataId = modeHandler.saveModeData(Constants.MODEID_GDZC,"1",formDataMap,"");
        return modeDataId>0;
    }
}
