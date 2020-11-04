package weaver.interfaces.yaphets.job;

import weaver.general.BaseBean;
import weaver.general.TimeUtil;
import weaver.interfaces.schedule.BaseCronJob;
import weaver.interfaces.yaphets.util.DocUtil;

import java.io.File;

public class BatchSetPictureJob extends BaseCronJob {

    private BaseBean bs = new BaseBean();


    public void execute(){
        bs.writeLog("--------------开始扫描资产图片--------------"+ TimeUtil.getCurrentDateString());
        String loginName = bs.getPropValue("jf","DOC_LOGINNAME");
        String password = bs.getPropValue("jf","DOC_PASSWORD");

        String session = DocUtil.getSession(loginName,password,0,"127.0.0.1");
        if(session != null && !"".equals(session)){
            scanTargetPath("",session);
        }else{
            bs.writeLog("调用文档登录接口失败");
        }
    }

    /**
     * 扫描指定路径下的所有文件
     * @param path
     */
    public static void scanTargetPath(String path,String session) {

        // File对象 可以是文件或者目录
        File file = new File(path);
        File[] array = file.listFiles();
        for (int i = 0; i < array.length; i++) {
            if (array[i].isFile()) {
                System.out.println("name:" + array[i].getName());
                System.out.println("path:" + array[i].getPath());
                String fileName = array[i].getName();

                String fileNameWithOutSuffix = fileName.substring(0,fileName.indexOf("."));
                String realPath = array[i].getPath();
                int docId = DocUtil.createImageFile(realPath,fileName,session);




            } else if (array[i].isDirectory()) {
                scanTargetPath(array[i].getPath(),session);
            }
        }
    }


}
