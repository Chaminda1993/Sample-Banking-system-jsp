<%-- 
    Document   : logs
    Created on : Jun 27, 2017, 5:49:47 PM
    Author     : chaminda
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jspcr.servlets.db"%>
<%@page import="com.jspcr.servlets.crypt"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.jspcr.servlets.tools"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logs</title>
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
                                <H4 style="color:blueviolet">Account Balance :<%= tools.curName+" "+bal %></H4>
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
        
        
        
        
            <div align="center" >
            <form action="logs.jsp">
                Search by Date : 
                <input type="date" name="date">
                <input type="submit" value="Search">
            </form>
                <h2>Transection Logs</h2>
                <%
                    tools.ANO="888-266266";
                    Statement st=con.createStatement();
                    ResultSet trs=st.executeQuery("Select * from transferLog where accNoFrom='"+tools.ANO+"' order by time desc");
                    if(null!=request.getParameter("date") && ""!=request.getParameter("date")){
                        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                        Date sDate = df.parse(request.getParameter("date"));
                        String date=sDate.toString();
                        date=sDate.toString().substring(0, 10)+"%"+sDate.toString().substring(20, 28);
                        trs=st.executeQuery("Select * from transferLog where accNoFrom='"+tools.ANO+"' and time like '"+date+"' order by time desc");
                    }
                    %>
                <table border="1" width="60%">
                    <tr>
                        <th>Transection ID</th>
                        <th>Time</th>
                        <th>Transfer Account</th>
                        <th>Amount</th>
                    </tr>
                    <%
                        while(trs.next()){
                             %>
                            <tr>
                                <td><%= trs.getString("trID") %></td> 
                                <td><%= trs.getString("time") %></td> 
                                <td><%= trs.getString("accNoTo") %></td>
                                <td><%= tools.curName+" "+tools.curCon(Double.valueOf(trs.getString("amount"))) %></td>                              
                            </tr>
                            <%
                        }
                        %>
                </table>
            </div>                     <br>
        
        
        
        
            <div align="center" >
                <h2>Bill payment Logs</h2>
                <%
                    st=con.createStatement();
                    ResultSet brs=st.executeQuery("Select * from billLog where accNo='"+tools.ANO+"' order by time desc");
                    if(null!=request.getParameter("date") && ""!=request.getParameter("date")){
                        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                        Date sDate = df.parse(request.getParameter("date"));
                        String date=sDate.toString();
                        date=sDate.toString().substring(0, 10)+"%"+sDate.toString().substring(20, 28);
                        brs=st.executeQuery("Select * from billLog where accNo='"+tools.ANO+"' and time like '"+date+"' order by time desc");
                    }
                    %>
                <table border="1" width="60%">
                    <tr>
                        <th>Payment ID</th>
                        <th>Bill Name</th>
                        <th>Time</th>
                        <th>Amount</th>
                    </tr>
                    <%
                        while(brs.next()){
                             %>
                            <tr>
                                <td><%= brs.getString("PaymentID") %></td> 
                                <td><%= brs.getString("BillID") %></td> 
                                <td><%= brs.getString("time") %></td>
                                <td><%= tools.curName+" "+tools.curCon(Double.valueOf(brs.getString("amount"))) %></td>                              
                            </tr>
                            <%
                        }
                        %>
                </table>
            </div>              <br>
            
        
        
        
            <div align="center" >
                <h2>System Login Logs</h2>
                <%
                    st=con.createStatement();
                    ResultSet lrs=st.executeQuery("Select * from LoginLog where accNo='"+tools.ANO+"' order by time desc");
                    if(null!=request.getParameter("date") && ""!=request.getParameter("date")){
                        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                        Date sDate = df.parse(request.getParameter("date"));
                        String date=sDate.toString();
                        date=sDate.toString().substring(0, 10)+"%"+sDate.toString().substring(20, 28);
                        lrs=st.executeQuery("Select * from LoginLog where accNo='"+tools.ANO+"' and time like '"+date+"' order by time desc");
                    }
                    %>
                <table border="1" width="60%" height="20%">
                    <tr>
                        <th>Login Time</th>
                    </tr>
                    <%
                        while(lrs.next()){
                             %>
                            <tr>
                                <td><%= lrs.getString("time") %></td>                              
                            </tr>
                            <%
                        }
                        %>
                </table>
            </div> 
    </body>
</html>
