<%-- 
    Document   : about
    Created on : Jun 27, 2017, 5:49:56 PM
    Author     : chaminda
--%>

<%@page import="java.sql.Connection"%>
<%@page import="com.jspcr.servlets.db"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.jspcr.servlets.tools"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>About</title>
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
                                <H4 style="color:blueviolet">Account Balance : <%= tools.curName+" "+ bal %></H4>
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
                <br>
                <img src="proc/logo.png" alt="logo" style="width:200px;height:200px;"><br>
                <p>
                    Golden Pacific National Bank<br>
                    No 123, King Street, Matale,<br>
                    Sri Lanka.<br>
                    T.P : 0663523353 / 0663425232<br>
                    Fax : 0663523353<br>
                    E-mail : goldenpacificnationalbank@gmail.com
                </p>
                
            </div>
        
    </body>
</html>
