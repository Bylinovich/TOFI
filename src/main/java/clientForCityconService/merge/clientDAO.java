package clientForCityconService.merge;

import java.sql.*;
import java.util.ArrayList;

/**
 * Created by Vlad on 11.12.2016.
 */
public class clientDAO {
    private static String url = "jdbc:mysql://127.0.0.1:3306/nc_2";
    private static String username = "root";
    private static String password = "root";

    public void addInUsers(String log,String pass,String email){
        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(
                    url, username, password);
            Statement statement = connection.createStatement();
            String sql = "INSERT INTO users (username,password,email,role) " +
                    "VALUES ('" + log + "', '" + pass + "', '" + email + "',1)";
            statement.executeUpdate(sql);
            statement.close();
            connection.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        catch (NumberFormatException e){
            e.printStackTrace();
        }
    }

    public ArrayList<String> getOldUsers(String colName){
        ArrayList<String> newLog = new ArrayList<>();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(
                    url, username, password);
            Statement statement = connection.createStatement();
            String sql = "SELECT "+colName+" from nc_2.users;";
            ResultSet rs = statement.executeQuery(sql);
            while (rs.next()) {
                newLog.add(rs.getString(1).toLowerCase());
            }
            rs.close();
            statement.close();
            connection.close();

        }
        catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        catch (NumberFormatException e){
            e.printStackTrace();
        }
        return newLog;
    }

}
