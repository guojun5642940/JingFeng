package weaver.interfaces.yaphets;

import weaver.interfaces.yaphets.webservice.DocAttachment;
import weaver.interfaces.yaphets.webservice.DocInfo;
import weaver.interfaces.yaphets.webservice.docService.DocServicePortType;
import weaver.interfaces.yaphets.webservice.docService.DocServicePortTypeProxy;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.rmi.RemoteException;
import org.apache.axis.encoding.Base64;

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
//        String session = t.getSession("sysadmin", "1", 0, "127.0.0.1");
//        try {
//            DocInfo doc =service.getDoc(147185,session);
//            System.out.println(doc);
//        } catch (RemoteException e) {
//            e.printStackTrace();
//        }
//        int docid = t.createImageFile("/Users/guojun/Desktop/Test.jpg",session);


//        getFile("/Users/guojun/Downloads/apache-maven-3.5.4/");

    }

    /**
//     * 获取文件列表
//     * @param path
//     */
//    public static void getFile(String path) {
//        // File对象 可以是文件或者目录
//        File file = new File(path);
//        File[] array = file.listFiles();
//        for (int i = 0; i < array.length; i++) {
//            if (array[i].isFile()) {
//                System.out.println("name:" + array[i].getName());
//                System.out.println("path:" + array[i].getPath());
//
//                String name = array[i].getName();
//                String realPath = array[i].getPath();
//            } else if (array[i].isDirectory()) {
//                getFile(array[i].getPath());
//            }
//        }
//    }

    /**
     * 将图片挂载到对应的固定资产
     * @param imagePath
     * @param gdzcbm
     */
    public void updateDocImage(String imagePath,String gdzcbm){

    }

//    /**
//     * 将图片生成ecology附件
//     * /Users/guojun/Desktop/Test.jpg
//     * @param imagePath
//     * @return
//     */
//    public int createImageFile(String imagePath,String session){
//        DocServicePortTypeProxy proxy = new DocServicePortTypeProxy();
//        DocServicePortType service = proxy.getDocServicePortType();
//        byte[] content = new byte[102400];
//        // 上传附件，创建html文档
//        content = null;
//        try {
//            int byteread;
//            byte data[] = new byte[1024];
//            InputStream input = new FileInputStream(new File(imagePath));
//            ByteArrayOutputStream out = new ByteArrayOutputStream();
//            while ((byteread = input.read(data)) != -1) {
//                out.write(data, 0, byteread);
//                out.flush();
//            }
//            content = out.toByteArray();
//            input.close();
//            out.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        DocAttachment da = new DocAttachment();
//        da.setDocid(0);
//        da.setImagefileid(0);
//        da.setFilecontent(Base64.encode(content));
//        da.setFilerealpath(imagePath);
//        da.setIszip(0);
//        da.setFilename("Test.jpg");
//        da.setIsextfile("0");
//        da.setDocfiletype("2");
//        da.setFiletype("image/jpeg");
//
//        DocInfo doc = new DocInfo();//创建文档
//        doc.setDoccreaterid(1);//
//        doc.setDoccreatertype(0);
//        doc.setAccessorycount(1);
//        doc.setMaincategory(-1);//主目录id
//        doc.setSubcategory(-1);//分目录id
//        doc.setSeccategory(160);//子目录id
//        doc.setOwnerid(1);
//        doc.setDocStatus(1);
//        doc.setId(0);
//        doc.setDocType(1);
//        doc.setDocSubject("Test1");
//        doc.setDoccontent("Test2-------------------------1-1-1--1-1-1-");
//        doc.setAttachments(new DocAttachment[] { da });
//        doc.setKeyword("测试文档webservice");
//        int docId = 0;
//        try {
//            docId = service.createDoc(doc, session);
//        } catch (RemoteException e) {
//            e.printStackTrace();
//        }
//        System.out.println("新文档id："+docId);
//        return docId;
//    }

//    /**
//     * 获取登录session
//     * @Description:TODO
//     * @author: guojun
//     * @date:   2020年7月9日
//     * @return
//     */
//    public String getSession(String loginName, String password, int loginType, String ipAddress) {
//        DocServicePortTypeProxy proxy = new DocServicePortTypeProxy();
//        DocServicePortType service = proxy.getDocServicePortType();
//        DocInfo docinfo = new DocInfo();
//        String session = "";
//        try {
//            session = service.login(loginName, password, loginType, ipAddress);
//            System.out.println(session);
//        } catch (RemoteException e) {
//            e.printStackTrace();
//        }
//        return session;
//    }
}
