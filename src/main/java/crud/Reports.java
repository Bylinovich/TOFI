package crud;

import java.sql.*;

public class Reports {
    private static String url = "jdbc:mysql://127.0.0.1:3306/nc_2";
    private static String username = "root";
    private static String password = "root";

    public int countOrdersOnDate(int year, int month, int day)
    {
        int count =0;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(
                    url, username, password);
            Statement statement = connection.createStatement();
            String sql = "SELECT count(o.date) FROM nc_2.orders o " +
                    "where YEAR(o.date)= "+year+" and MONTH(o.date)= "+month+" and DAY(o.date)= "+day+";";
            ResultSet resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                count = resultSet.getInt(1);
            }
            statement.close();
            connection.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return count;
    }

    public String[][] ordersOnDate(int year, int month, int day, int count) {
        String[][] result = new String[4][count+1];
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(
                    url, username, password);
            Statement statement = connection.createStatement();
            String sql = "SELECT u.username,o.totalCost,o.currency,o.date FROM nc_2.orders o "+
                    "inner join nc_2.users u on u.id=o.userId "+
                    "where YEAR(o.date)= "+year+" and MONTH(o.date)= "+month+" and DAY(o.date)= "+day+";";
            ResultSet resultSet = statement.executeQuery(sql);

            ResultSetMetaData rsmd = resultSet.getMetaData();
            result[0][0]=rsmd.getColumnName(1);
            result[1][0]=rsmd.getColumnName(2);
            result[2][0]=rsmd.getColumnName(3);
            result[3][0]=rsmd.getColumnName(4);

            int i = 1;
            while(resultSet.next()) {
                result[0][i] = resultSet.getString(1);
                result[1][i] = resultSet.getString(2);
                result[2][i] = resultSet.getString(3);
                result[3][i] = resultSet.getString(4);
                i++;
            }
            resultSet.close();
            statement.close();
            connection.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return result;
    }

    public String[][] bestUsers() {
        String[][] result = new String[2][21];
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(
                    url, username, password);
            Statement statement = connection.createStatement();
            String sql = "select u.username as USERID,sum(t.finCost) as COST from( " +
                    "(select o.userId,o.currency,(o.totalCost/c.currencyScale*c.currencyRate) as finCost,'BYN' as BYN from nc_2.orders o " +
                    "inner join nc_2.currency c on c.currencyAbbreviation=o.currency) t) " +
                    "inner join nc_2.users u on t.userId=u.id " +
                    "group by t.userID " +
                    "order by COST desc " +
                    "limit 20;";
            ResultSet resultSet = statement.executeQuery(sql);
            System.out.println("~~~~");
            System.out.println(resultSet);
            ResultSetMetaData rsmd = resultSet.getMetaData();
            result[0][0]=rsmd.getColumnName(1);
            result[1][0]=rsmd.getColumnName(2);
            int i = 1;
            while (resultSet.next()) {
                result[0][i] = resultSet.getString(1);
                result[1][i] = resultSet.getString(2);
                i++;
            }
            statement.close();
            connection.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return result;
    }

    public String[][] yearReport() {
        String[][] result = new String[3][13];
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(
                    url, username, password);
            Statement statement = connection.createStatement();
            String sql = "select monthname(o.date) as MONTH,count(o.id) as ORDERS,sum(o.totalCost/c.currencyScale*c.currencyRate) as 'MONEY(BYN)' from nc_2.orders o "+
                    "inner join nc_2.currency c on c.currencyAbbreviation=o.currency "+
                    "group by month(o.date);";
            ResultSet resultSet = statement.executeQuery(sql);
            ResultSetMetaData rsmd = resultSet.getMetaData();
            result[0][0]=rsmd.getColumnName(1);
            result[1][0]=rsmd.getColumnName(2);
            result[2][0]=rsmd.getColumnName(3);
            int i = 1;
            while (resultSet.next()) {
                result[0][i] = resultSet.getString(1);
                result[1][i] = resultSet.getString(2);
                result[2][i] = resultSet.getString(3);
                i++;
            }
            statement.close();
            connection.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return result;
    }
}
