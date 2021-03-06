package weaver.interfaces.yaphets.util;

import org.apache.axis.encoding.Base64;
import weaver.general.BaseBean;
import weaver.interfaces.yaphets.webservice.DocAttachment;
import weaver.interfaces.yaphets.webservice.DocInfo;
import weaver.interfaces.yaphets.webservice.docService.DocServicePortType;
import weaver.interfaces.yaphets.webservice.docService.DocServicePortTypeProxy;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.rmi.RemoteException;

/**
 * 文档相关工具类
 */
public class DocUtil {

    /**
     * 获取登录session
     * @Description:TODO
     * @author: guojun
     * @date:   2020年7月9日
     * @return
     */
    public static String getSession(String loginName, String password, int loginType, String ipAddress) {
        DocServicePortTypeProxy proxy = new DocServicePortTypeProxy();
        DocServicePortType service = proxy.getDocServicePortType();
        String session = "";
        try {
            session = service.login(loginName, password, loginType, ipAddress);
        } catch (RemoteException e) {
            e.printStackTrace();
        }
        return session;
    }

    /**
     * 将图片生成ecology附件
     * @param imagePath
     * @return
     */
    public static int createImageFile(String imagePath,String imageName,String session){
        DocServicePortTypeProxy proxy = new DocServicePortTypeProxy();
        DocServicePortType service = proxy.getDocServicePortType();
        byte[] content = new byte[102400];
        // 上传附件，创建html文档
        content = null;
        try {
            int byteread;
            byte data[] = new byte[1024];
            InputStream input = new FileInputStream(new File(imagePath));
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            while ((byteread = input.read(data)) != -1) {
                out.write(data, 0, byteread);
                out.flush();
            }
            content = out.toByteArray();
            input.close();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        DocAttachment da = new DocAttachment();
        da.setDocid(0);
        da.setImagefileid(0);
        da.setFilecontent(Base64.encode(content));
        da.setFilerealpath(imagePath);
        da.setIszip(0);
        da.setFilename(imageName);
        da.setIsextfile("0");
        da.setDocfiletype("2");
        da.setFiletype("image/jpeg");

        DocInfo doc = new DocInfo();//创建文档
        doc.setDoccreaterid(1);//
        doc.setDoccreatertype(0);
        doc.setAccessorycount(1);

        BaseBean bs = new BaseBean();
        String maincategory = bs.getPropValue("jf","DOC_MAINCATEGORY");
        String subcategory = bs.getPropValue("jf","DOC_SUBCATEGORY");
        String seccategory = bs.getPropValue("jf","DOC_SECCATEGORY");

        doc.setMaincategory(Integer.parseInt(maincategory));//主目录id
        doc.setSubcategory(Integer.parseInt(subcategory));//分目录id
        doc.setSeccategory(Integer.parseInt(seccategory));//子目录id
        doc.setOwnerid(1);
        doc.setDocStatus(1);
        doc.setId(0);
        doc.setDocType(1);
        doc.setDocSubject(imageName);
        doc.setDoccontent(imageName);
        doc.setAttachments(new DocAttachment[] { da });
        doc.setKeyword(imageName);
        int docId = 0;
        try {
            docId = service.createDoc(doc, session);
        } catch (RemoteException e) {
            e.printStackTrace();
        }
        return docId;
    }
}
