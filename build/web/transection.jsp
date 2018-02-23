<%-- 
    Document   : transcection
    Created on : Jun 26, 2017, 6:46:31 PM
    Author     : chaminda
--%>

<%@page import="java.sql.Connection"%>
<%@page import="com.jspcr.servlets.db"%>

<%@page import="com.jspcr.servlets.crypt"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.jspcr.servlets.tools"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transections</title>
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
            
            
            String para=request.getParameter("trID");
            
            if(null==para){            
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("Select Max(trID) from transferLog");
            rs.next();
            int newTrID=rs.getInt("max(trID)")+1;
            Date date=new Date();
            st.close();rs.close();                              // ********* close connections **********
            %>
        
        <div align="center" name="moneyTansfer">
            <form action="transection.jsp" >
            <h2>Money transfer</h2>
            <table>
                <tr>
                    <td>Transection ID :</td>
                    <td><%= newTrID %> <input type="hidden" name="trID" value="<%= newTrID %>"></td>
                </tr>
                <tr>
                    <td>Date :</td>
                    <td> <%= date %><input type="hidden" name="date" value="<%= date %>"></td>
                </tr>
                <tr>
                    <td>Send Account :</td>
                    <td> <%= tools.ANO %><input type="hidden" name="sendAcc" value="<%= tools.ANO %>"></td>
                </tr>
                <tr>
                    <td>Received Account :</td>
                    <td><input type="text" name="recAcc"></td>
                </tr>
                <tr>
                    <td>Amount : (LKR)</td>
                    <td><input type="text" name="amount"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Transfer"></td>
                </tr>
            </table>
            </form>
        </div>
                <% }else{
                String date = request.getParameter("date");
                String sendAcc =request.getParameter("sendAcc");
                String recAcc = request.getParameter("recAcc");
                int amount = Integer.valueOf(request.getParameter("amount"));
                
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery("Select balance from accounts where accNo='"+sendAcc+"'");
                rs.next();
                int sendAccBal=rs.getInt("balance");

                rs=st.executeQuery("Select balance from accounts where accNo='"+recAcc+"'");
                rs.next();
                int recAccBal=rs.getInt("balance");

                sendAccBal -= amount ;
                recAccBal += amount;
//                sendAcc=crypt.encrypt(sendAcc);
//                recAcc=crypt.encrypt(recAcc);

                st.executeUpdate("Update Accounts set balance='"+sendAccBal+"' where accNo='"+sendAcc+"'");
                st.executeUpdate("Update Accounts set balance='"+recAccBal+"' where accNo='"+recAcc+"'");
                st.executeUpdate("insert into transferLog(trID,time,accNoFrom,accNoTo,amount) values('"+para+"','"+date+"','"+sendAcc+"','"+recAcc+"','"+amount+"')");
                st.close();rs.close(); 
            %>

            <div align="center">
                <form action="transection.jsp">
                    <h2>Transfer successful.</h2>
                    <input type="submit" value="OK">
                </form>
            </div>

            <%

}
                %>
    </body>
</html>
