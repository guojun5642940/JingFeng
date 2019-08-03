package weaver.interfaces.yaphets.util;

import weaver.general.BaseBean;
import java.sql.*;

public class JdbcUtils {
    private static BaseBean bs = new BaseBean();
    private static String  url = bs.getPropValue("weaver", "ecology.url");
    private static String user =bs.getPropValue("weaver", "ecology.user");
    private static  String passWord = bs.getPropValue("weaver", "ecology.password");

    //构造方法私有，别人不能构造，不会有实例出来.
    private JdbcUtils(){
    }

    /**
     * 静态代码块，类加载到虚拟机是只执行一次。
     */
    static {
        try {
            Class.forName(bs.getPropValue("weaver","DriverClasses"));
        } catch (ClassNotFoundException e) {

            e.printStackTrace();
        }

    }

    public static Connection getConnection() {
        Connection conn = null;
        try {
            conn =  DriverManager.getConnection(url,user,passWord);
        } catch (SQLException e) {

            e.printStackTrace();
        }
        return conn;



    }

    //释放资源，重载方法。
    public static void close(Connection conn) {
        try {
            if(conn != null){
                conn.close();
                conn = null;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
    public static void close(Statement stmt){
        try{
            if(stmt != null){
                stmt.close();
                stmt = null;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
    public static void close(ResultSet  rs){
        try{
            if(rs != null){
                rs.close();
                rs = null;
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
