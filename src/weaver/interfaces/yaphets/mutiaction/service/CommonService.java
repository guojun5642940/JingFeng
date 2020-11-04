package weaver.interfaces.yaphets.mutiaction.service;

import weaver.conn.RecordSet;

public class CommonService {
    
    
    /**
    * @Description 获取流程对应表
    * @Author  guojun
    * @Date   2020/11/4 23:40
    * @Param  
    * @Return      
    *
    */
    public static String getFormTableName(String workflowid){
        String sql = "select formid from workflow_base where id = '"+workflowid+"'";
        RecordSet rs = new RecordSet();
        String formid = "";
        rs.execute(sql);
        if(rs.next()){
            formid = rs.getString("formid").replace("-","");
        }
        return "formtable_main_"+formid;
    }
}
