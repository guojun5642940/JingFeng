package weaver.interfaces.yaphets;

import weaver.interfaces.yaphets.webservice.DocInfo;
import weaver.interfaces.yaphets.webservice.docService.DocServicePortType;
import weaver.interfaces.yaphets.webservice.docService.DocServicePortTypeProxy;

import java.rmi.RemoteException;

/**
 * @author lilong
 * @Title: Test
 * @ProjectName JingFeng
 * @Description: TODO
 * @date 2020/7/102:55
 */
public class Test {

    public static void main(String[] args) throws Exception {
        Test t = new Test();
        DocServicePortTypeProxy proxy = new DocServicePortTypeProxy();
        DocServicePortType service = proxy.getDocServicePortType();
        String session = t.getSession("sysadmin", "1", 0, "127.0.0.1");
        try {
            DocInfo doc =service.getDoc(147185,session);


            System.out.println(doc);


        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    /**
     * 将图片挂载到对应的固定资产
     * @param imagePath
     * @param gdzcbm
     */
    public void updateDocImage(String imagePath,String gdzcbm){
    }

    /**
     * 将图片生成ecology附件
     * @param imagePath
     * @return
     */
    public int createImageFile(String imagePath){
        return 0;
    }

    /**
     * 获取登录session
     * @Description:TODO
     * @author: guojun
     * @date:   2020年7月9日
     * @return
     */
    public String getSession(String loginName, String password, int loginType, String ipAddress) {
        DocServicePortTypeProxy proxy = new DocServicePortTypeProxy();
        DocServicePortType service = proxy.getDocServicePortType();
        DocInfo docinfo = new DocInfo();
        String session = "";
        try {
            session = service.login(loginName, password, loginType, ipAddress);
            System.out.println(session);
        } catch (RemoteException e) {
            e.printStackTrace();
        }
        return session;
    }
}
