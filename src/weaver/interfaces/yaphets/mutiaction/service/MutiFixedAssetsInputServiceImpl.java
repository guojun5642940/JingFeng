package weaver.interfaces.yaphets.mutiaction.service;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.yaphets.mutiaction.GdzcDto;
import weaver.interfaces.yaphets.util.CommonUtil;
import weaver.interfaces.yaphets.util.Constants;
import weaver.soa.workflow.request.RequestInfo;
import weaver.workflow.request.RequestComInfo;
import weaver.workflow.workflow.WorkflowComInfo;

/**
 *  @author: guojun
 *  @Date: 2020/11/7 13:56
 *  @Description:批量录入
 */
public class MutiFixedAssetsInputServiceImpl implements Action {
    private RequestComInfo requestComInfo;
    private weaver.workflow.workflow.WorkflowComInfo WorkflowComInfo;
    private BaseBean bs;

    public MutiFixedAssetsInputServiceImpl() {
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
        bs.writeLog("MutiFixedAssetsInputServiceImpl--进入action--workflowId：{"+workflowId+"},workflowName：{"+workflowName+"},requestId：{"+requestId+"},requestName：{"+requestName+"}");

        RecordSet rs = new RecordSet();
        RecordSet rsUpdate = new RecordSet();
        String mxTablename = CommonService.getFormTableName(workflowId);
        String sql = "select * from "+mxTablename+"_dt1 where mainid = (select id from "+mxTablename+" where requestid = '"+requestId+"')";
        rs.execute(sql);
        while(rs.next()){
            String id = Util.null2String(rs.getString("id"));
            String	bmzrr = Util.null2String(rs.getString("bmzrr")); //部门责任人
            String	cfdd = Util.null2String(rs.getString("cfdd")); //存放地点
            String	cgr = Util.null2String(rs.getString("cgr")); //采购人
            String	gdzcbm = Util.null2String(rs.getString("gdzcbm")); //固定资产编码
            String	ggxh = Util.null2String(rs.getString("ggxh")); //规格型号
            String	gmdj = Util.null2String(rs.getString("gmdj")); //购买单价
            String	gsmc = Util.null2String(rs.getString("gsmc")); //公司名称
            String	gzny = Util.null2String(rs.getString("gzny")); //购置年份
            String	gzrq = Util.null2String(rs.getString("gzrq")); //购置日期
            String	jldw = Util.null2String(rs.getString("jldw")); //计量单位
            String	lyrq = Util.null2String(rs.getString("lyrq")); //领用日期
            String	ssbk = Util.null2String(rs.getString("ssbk")); //所属板块
            String	sybm = Util.null2String(rs.getString("sybm")); //使用部门
            String	syr = Util.null2String(rs.getString("syr")); //使用人
            String	syzx = Util.null2String(rs.getString("syzx")); //使用中心
            String	tpsc = Util.null2String(rs.getString("tpsc")); //图片上传
            String	zclb = Util.null2String(rs.getString("zclb")); //资产类别
            String	zclx = Util.null2String(rs.getString("zclx")); //资产类型

            //没有gdzcbm 则更新固定资产编码
            if("".equalsIgnoreCase(gdzcbm)){
                String zclbCode = "";
                if("0".equals(zclb)){
                    //固定资产
                    zclbCode = "GD";
                }else if("1".equals(zclb)){
                    zclbCode = "DZ";
                }
                gdzcbm = CommonUtil.createAssetsCode(gsmc,zclbCode,zclx);
                bs.writeLog("requestId:"+requestId+"-明细id"+id+"-"+"获取流水号："+gdzcbm);
                String updateSql = "update "+ Constants.WORKFLOW_TABLENAME_BATCH_PURCHASE +"_dt1 set gdzcbm = '"+gdzcbm+"' where id = '"+id+"' ";
                bs.writeLog("updateSql="+updateSql);
                rsUpdate.execute(updateSql);
            }
            GdzcDto gdzcDto = new GdzcDto();
            gdzcDto.setGsmc(gsmc);
            gdzcDto.setZclb(zclb);
            gdzcDto.setZclx(zclx);
            gdzcDto.setGdzcbm(gdzcbm);
            gdzcDto.setGgxh(ggxh);
            gdzcDto.setJldw(jldw);
            gdzcDto.setGzrq(gzrq);
            gdzcDto.setCfdd(cfdd);
            gdzcDto.setSyzx(syzx);
            gdzcDto.setCgr(cgr);
            gdzcDto.setSyr(syr);
            gdzcDto.setSybm(sybm);
            gdzcDto.setLyrq(lyrq);
            gdzcDto.setBmzrr(bmzrr);
            gdzcDto.setZczt("1");
            gdzcDto.setGmdj(gmdj);
            gdzcDto.setZctp(tpsc);
            gdzcDto.setSsbk(ssbk);
            int modeDataId = gdzcDto.saveModeData();
            bs.writeLog("requestId：{"+requestId+"},modeDataId:"+modeDataId);
        }
        return SUCCESS;
    }
}
