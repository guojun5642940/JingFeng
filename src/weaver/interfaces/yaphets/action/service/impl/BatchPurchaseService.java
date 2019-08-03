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

import java.util.HashMap;
import java.util.Map;

/**
 * @author guoj
 * @Title: BatchPurchaseService
 * @ProjectName JingFeng
 * @Description: 批量申请
 * @date 2019/7/3016:33
 */
public class BatchPurchaseService extends BaseBean implements FixedAssetsServiceIfr {

    @Override
    public JSONObject excute(RequestInfo request) {
        JSONObject result = new JSONObject();
        result.put("flag",true);
        String requestId = request.getRequestid();
        ActionMapUtil aUtil = new ActionMapUtil(request);
        Map dataMap = aUtil.getDataMap();
        String currentNodeid = CommonUtil.getCurrentNodeId(requestId);

        String sql = "select * from "+ Constants.WORKFLOW_TABLENAME_BATCH_PURCHASE +"_dt1 where mainid = (select id from "+ Constants.WORKFLOW_TABLENAME_BATCH_PURCHASE +" where requestid = '"+requestId+"')";
        RecordSet rs = new RecordSet();
        RecordSet rsUpdate = new RecordSet();

        //第一个节点生成资产编码
        if(currentNodeid.equals(Constants.NODEID_FIRST_PLLR)){
            rs.execute(sql);
            while(rs.next()){
                String id = Util.null2String(rs.getString("id"));
                String gsmc = Util.null2String(rs.getString("gsmc"));
                String zclb = Util.null2String(rs.getString("zclb"));
                String gdzcbm = Util.null2String(rs.getString("gdzcbm"));
                String zclx = Util.null2String(rs.getString("zclx"));
                if(!"".equals(gdzcbm)){
                    continue;
                }else{
                    String zclbCode = "";
                    if("0".equals(zclb)){
                        //固定资产
                        zclbCode = "GD";
                    }else if("1".equals(zclb)){
                        zclbCode = "DZ";
                    }
                    if("".equals(gdzcbm)){
                        gdzcbm = CommonUtil.createAssetsCode(gsmc,zclbCode,zclx);
                        writeLog("requestId:"+requestId+"-明细id"+id+"-"+"获取流水号："+gdzcbm);
                        String updateSql = "update "+ Constants.WORKFLOW_TABLENAME_BATCH_PURCHASE +"_dt1 set gdzcbm = '"+gdzcbm+"' where id = '"+id+"' ";
                        writeLog("updateSql="+updateSql);
                        rsUpdate.execute(updateSql);
                    }
                }

            }
        }

        //归档前将数据写入表单建模
        if(currentNodeid.equals(Constants.NODEID_LAST_PLLR)){
            FormModeHandler modeHandler = new FormModeHandler();
            rs.execute(sql);
            while(rs.next()){
                String gsmc = Util.null2String(rs.getString("gsmc"));
                String zclb = Util.null2String(rs.getString("zclb"));
                String zclx = Util.null2String(rs.getString("zclx"));
                String ggxh = Util.null2String(rs.getString("ggxh"));
                String jldw = Util.null2String(rs.getString("jldw"));
                String gzny = Util.null2String(rs.getString("gzny"));
                String gzrq = Util.null2String(rs.getString("gzrq"));
                String syr = Util.null2String(rs.getString("syr"));
                String sybm = Util.null2String(rs.getString("sybm"));
                String syzx = Util.null2String(rs.getString("syzx"));
                String cgr = Util.null2String(rs.getString("cgr"));
                String bmzrr = Util.null2String(rs.getString("bmzrr"));
                String lyrq = Util.null2String(rs.getString("lyrq"));
                String cfdd = Util.null2String(rs.getString("cfdd"));
                String gdzcbm = Util.null2String(rs.getString("gdzcbm"));
                String gmdj = Util.null2String(rs.getString("gmdj"));
                if("".equals(gmdj)){
                    gmdj = "0.00";
                }

                Map<String, String> formDataMap = new HashMap<>();
                formDataMap.put("gsmc" ,gsmc);
                formDataMap.put("zclb" ,zclb);
                formDataMap.put("zclx" ,zclx);
                formDataMap.put("gdzcbm" ,gdzcbm);
                formDataMap.put("ggxh" ,ggxh);
                formDataMap.put("gzny" ,gzny);
                formDataMap.put("jldw" ,jldw);
                formDataMap.put("gzrq" ,gzrq);
                formDataMap.put("cfdd" ,cfdd);
                formDataMap.put("syzx" ,syzx);
                formDataMap.put("cgr" ,cgr);
                formDataMap.put("syr" ,syr);
                formDataMap.put("sybm" ,sybm);
                formDataMap.put("lyrq" ,lyrq);
                formDataMap.put("bmzrr" ,bmzrr);
                formDataMap.put("zczt" ,"1");
                formDataMap.put("gmdj" ,gmdj);
                int modeDataId = modeHandler.saveModeData(Constants.MODEID_GDZC,"1",formDataMap,"");
            }
        }
        return result;
    }
}
