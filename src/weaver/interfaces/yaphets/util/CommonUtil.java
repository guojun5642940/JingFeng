package weaver.interfaces.yaphets.util;

import weaver.conn.RecordSet;
import weaver.general.Util;

public class CommonUtil {


    /**
     * getseqnum获取流水号
     * @param companyCode 公司名称简码
     * @param assetsKind 资产类别简码
     * @param assetsTypeCode 资产类型
     * @return
     */
    public static String createAssetsCode(String companyCode,String assetsKind,String assetsTypeCode){
        String result = "";
        RecordSet rs = new RecordSet();
        if(!"".equals(companyCode)){
            result += "-"+companyCode;
        }
        if(!"".equals(assetsKind)){
            result += "-"+assetsKind;
        }
        if(!"".equals(assetsTypeCode)){
            result += "-"+assetsTypeCode;
        }
        result = result.length()>=1?result.substring(1):result;

        rs.executeProc("getseqnum",result);
        String code = rs.getString(1);
        return code;
    }

    /**
     * @param requestid
     * @return
     */
    public static String getCurrentNodeId(String requestid){
        RecordSet rs = new RecordSet();
        String sql = "select currentnodeid from workflow_requestbase where requestid = '"+requestid+"'";
        rs.execute(sql);
        String currentnodeid = "";
        if(rs.next()){
            currentnodeid = Util.null2String(rs.getString("currentnodeid"));
        }
        return currentnodeid;
    }
}
