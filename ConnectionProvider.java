package project;
import java.sql.*;

public class ConnectionProvider {
    public static Connection getcon() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ospjsp","root","root" 
            );
        } catch (Exception e) {
            e.printStackTrace(); 
        }
        return con;
    }
}

