<%-- 
    Document   : customer
    Created on : Jun 27, 2017, 4:59:32 PM
    Author     : chaminda
--%>

<%@page import="java.sql.Connection"%>
<%@page import="com.jspcr.servlets.db"%>
<%@page import="com.jspcr.servlets.crypt"%>
<%@page import="com.jspcr.servlets.tools"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Details</title>
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
        
        <div align="center">
            <%
                
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("Select cusNIC from Accounts where accNo='"+tools.ANO+"'");
            rs.next();
            String cusNIC=rs.getString("cusNIC");
            
            rs=st.executeQuery("Select * from customers where cusNIC='"+cusNIC+"'");
            rs.next();
            String cusName=crypt.decrypt(rs.getString("cusName"));
            String address=crypt.decrypt(rs.getString("cusAddress"));
            String tel=crypt.decrypt(rs.getString("cusTP"));
            String email=rs.getString("email");
                %>
            <h2>Customer Details</h2>
            <table width="40%">
                <tr>
                    <td>NIC No :</td>
                    <td><%= crypt.decrypt(cusNIC) %></td>
                </tr>
                <tr>
                    <td>Name :</td>
                    <td><%= cusName %></td>
                </tr>
                <tr>
                    <td>Address :</td>
                    <td><%= address %></td>
                </tr>
                <tr>
                    <td>Telephone :</td>
                    <td><%= tel %></td>
                </tr>
                <tr>
                    <td>E-mail :</td>
                    <td><%= email %></td>
                </tr>
            </table>
        </div>
                <br><br><br><br>
                
                <div align="center">
                    <h2>Account Details</h2>
                    <%
                        ResultSet ars=st.executeQuery("select * from accounts where cusNIC='"+cusNIC+"'");
                        
                        %>
                    <table width="60%" border="1">
                        <tr>
                            <th>Account No</th>
                            <th>Account Type</th>
                            <th>Account Name</th>
                            <th>Balance</th>
                        </tr>
                        <%
                            while(ars.next()){
                            %>
                            <tr>
                                <td><%= ars.getString("accNo") %></td>
                                <td><%= crypt.decrypt(ars.getString("accType")) %></td>
                                <td><%= crypt.decrypt(ars.getString("accName")) %></td>
                                <td><%= tools.curName+" "+tools.curCon(Double.valueOf(ars.getString("balance"))) %></td>
                            </tr>
                            <%
                                }
                                %>
                    </table>
                </div>
        
    </body>
</html>
