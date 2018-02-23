<%-- 
    Document   : billPay
    Created on : Jun 27, 2017, 3:17:13 PM
    Author     : chaminda
--%>

<%@page import="com.jspcr.servlets.db"%>
<%@page import="java.util.concurrent.Executor"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.jspcr.servlets.tools"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bill Payments</title>
    </head>
    <body style="background-color:lightgray">
        <%
                Connection con=db.getConn();
                %>
            <div id="header">                                                      <! *************************Start Header ************************** >
        <div style="background-color: lightsteelblue" align="center">   
            <table width="80%">
                <tr>
                    <td><img src="proc/logo.png" alt="logo" style="width:100px;height:100px;"></td>
                    <td><h1 style="color:darkblue">Golden Pacific National Bank</h1></td>
                    <td align="right">
                        <% if(tools.loged){
                            Statement st=con.createStatement();
                            ResultSet rs=st.executeQuery("Select balance from accounts where accNo='"+tools.ANO+"'");
                            rs.next();
                            double bal=rs.getDouble("balance");
                            bal=tools.curCon(bal);
                            %>
                            <form action="home.jsp">
                                <input type="submit" value=" Logut ">
                                <input type="hidden" value="out" name="type"><br>
                                <H4 style="color:blueviolet">Account Number : <%= tools.ANO %></H4>
                                <H4 style="color:blueviolet">Account Balance :  <%= tools.curName+" "+ bal %></H4>
                            </form><br>
                            <%
                        }else{
                            %>
                        <form action="login.jsp"><input type="submit" value=" Login "></form><br>
                        <a href="login.jsp?type=rec" style="text-decoration: none">Forget password</a>
                        <% } %>
                    </td>
                </tr>
            </table>
        </div>
                    
            <%
                if(tools.loged){
            %>    
                    <div align="center" style="background-color:lightblue">
                        <table width="60%">
                            <tr>
                                <th><a href="home.jsp" style="text-decoration: none">Home</a></th>
                                <th><a href="transection.jsp" style="text-decoration: none">Transection</a></th>
                                <th><a href="billPay.jsp" style="text-decoration: none">Bill Payments</a></th>
                                <th><a href="customer.jsp" style="text-decoration: none">Accounts</a></th>
                                <th><a href="logs.jsp" style="text-decoration: none">Logs</a></th>
                                <th><a href="about.jsp" style="text-decoration: none">About</a></th>
                            </tr>
                        </table>
                    </div>        
            <%
                }
            %> 
            </div>                              <! ************************* End Header ************************** >
        
        <%
            
            
            String para=request.getParameter("billLogID");
            
            if(null==para){            
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("Select Max(paymentID) from BillLog");
            rs.next();
            int newbillID=rs.getInt("Max(paymentID)")+1;
            Date date=new Date();
            %>
        
        <div align="center" name="billpay">
            <form action="billPay.jsp" >
            <h2>Bill Payments</h2>
            <table>
                <tr>
                    <td>Payment ID :</td>
                    <td><%= newbillID %> <input type="hidden" name="billLogID" value="<%= newbillID %>"></td>
                </tr>
                <tr>
                    <td>Date :</td>
                    <td> <%= date %><input type="hidden" name="date" value="<%= date %>"></td>
                </tr>
                <tr>
                    <td>Account No :</td>
                    <td> <%= tools.ANO %><input type="hidden" name="accNo" value="<%= tools.ANO %>"></td>
                </tr>
                <tr>
                    <td>Bill Account :</td>
                    <td>
                        <select name="billName">
                            <option selected>Electricity</option>
                            <option>Water</option>
                            <option>Telephone</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Amount : (LKR)</td>
                    <td><input type="text" name="amount"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Pay"></td>
                </tr>
            </table>
            </form>
        </div>
                <% }else{
                String date = request.getParameter("date");
                String accNo =request.getParameter("accNo");
                String billName = request.getParameter("billName");
                int amount = Integer.valueOf(request.getParameter("amount"));
                
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery("Select balance from accounts where accNo='"+accNo+"'");
                rs.next();
                int AccBal=rs.getInt("balance");

                rs=st.executeQuery("Select balance from BillAcc where billName='"+billName+"'");
                rs.next();
                int billAccBal=rs.getInt("balance");

                AccBal -= amount ;
                billAccBal += amount;

                st.executeUpdate("Update Accounts set balance='"+AccBal+"' where accNo='"+accNo+"'");
                st.executeUpdate("Update BillAcc set balance='"+billAccBal+"' where billName='"+billName+"'");
                st.executeUpdate("insert into billLog(paymentID,time,accNo,billID,amount) values('"+para+"','"+date+"','"+accNo+"','"+billName+"','"+amount+"')");
                
            %>

            <div align="center">
                <form action="billPay.jsp">
                    <h2>Payment successful.</h2>
                    <input type="submit" value="OK">
                </form>
            </div>

            <%

}
                %>
    </body>
</html>
