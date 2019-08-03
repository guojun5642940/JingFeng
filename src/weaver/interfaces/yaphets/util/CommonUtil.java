package weaver.interfaces.yaphets.util;

import oracle.jdbc.OracleTypes;
import oracle.jdbc.oracore.OracleType;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;

public class CommonUtil{


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
        result = result.length()>=1?result.substring(1):result+"-";
        String code = callProcedure("HrmQuerySeqByTypeString",result);
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

    /**
     * 调用存储过程
     * @param methodName
     * @param param
     * @return
     */
    public static String callProcedure(String methodName,String param){
        Connection conn = null;
        CallableStatement call = null;
        String code = "";
        try {
            conn = JdbcUtils.getConnection();
            call = conn.prepareCall("{ call "+methodName+"(?,?) }");
            call.setString(1, param);
            call.registerOutParameter(2, Types.VARCHAR);
            call.execute();
            code = call.getString(2);
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            JdbcUtils.close(call);
            JdbcUtils.close(conn);
        }
        return code;
    }
}
