/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication1;

import java.sql.CallableStatement;
import java.sql.DriverManager;
import java.sql.Connection;
import static java.sql.JDBCType.ARRAY;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import static oracle.jdbc.OracleTypes.ARRAY;
import oracle.jdbc.driver.*;



public class Procedure_call {
    
    static Connection connection = null;
    
    public static void main(String[] argv) throws SQLException {
        System.out.println("-------- Oracle JDBC Connection Testing ------");
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            System.out.println("Where is your Oracle JDBC Driver?");
            e.printStackTrace();
            return;
        }
        System.out.println("Oracle JDBC Driver Registered!");
        try {
            connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "usermn", "mopass");
        } catch (SQLException e) {
            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
            return;
        }
        
        String query = "select get_bal(1) as bal from dual";
        
    }
    
    public static int call(String query) throws SQLException{
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(query);
        // iterate through the java resultset
        if (rs.next())
        {   
            System.err.println(rs.getInt("bal"));
        }
    
       return 0;
    }
    
    
    public static int call_2() throws SQLException{
       
        String call = "{ ? = call get_bal(?) }";
        CallableStatement cstmt = connection.prepareCall(call);
        cstmt.registerOutParameter(1, Types.INTEGER);
        cstmt.setInt(2, 1);
        cstmt.executeUpdate();
        int acctBal = cstmt.getInt(1);
        System.out.println(acctBal+" Using Callable Statement");
       return 0;
    }
}