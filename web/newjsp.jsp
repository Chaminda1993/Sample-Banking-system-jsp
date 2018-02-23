<%-- 
    Document   : newjsp
    Created on : Jun 25, 2017, 1:54:10 PM
    Author     : chaminda
--%>
<%@page import="com.jspcr.servlets.crypt"%>
<%@ page extends="com.jspcr.servlets.NutrientDatabaseServlet" %>
<%@ page import="java.io.*,java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <%
        
        crypt.secret=request.getParameter("pw");
        Statement st=con.createStatement();
        
        switch(request.getParameter("tbl")){
            case "customer":
                String ccusNIC=crypt.encrypt(request.getParameter("cusNIC"));
                String ccusName=crypt.encrypt(request.getParameter("cusName"));
                String ccusAddress=crypt.encrypt(request.getParameter("cusAddress"));
                String ccusTP=crypt.encrypt(request.getParameter("cusTP"));
                String cPW=crypt.encrypt(request.getParameter("password"));
                String cemail=request.getParameter("email");
                String csql="insert into customers(cusNIC,cusName,cusAddress,cusTP,pw,email,secret) values('"+ccusNIC+"','"+ccusName+"','"+ccusAddress+"','"+ccusTP+"','"+cPW+"','"+cemail+"','"+request.getParameter("password")+"')";
                st.executeUpdate(csql);
                response.sendRedirect("addDataToDB.jsp");
                break;
            case "account":
                String aaccNo=request.getParameter("accNo");
                String aaccName=crypt.encrypt(request.getParameter("accName"));
                String aaccType=crypt.encrypt(request.getParameter("accType"));
                String acusNIC=crypt.encrypt(request.getParameter("cusNIC"));
                String aBalance=request.getParameter("balance");
                String asql="insert into accounts(accNo,accName,accType,cusNIC,balance) values('"+aaccNo+"','"+aaccName+"','"+aaccType+"','"+acusNIC+"','"+aBalance+"')";
                st.executeUpdate(asql);
                response.sendRedirect("addDataToDB.jsp");
                break;
            case "billAcc":
                String bbillID=request.getParameter("billID");
                String bbillName=request.getParameter("billName");
                String bBalance=request.getParameter("billBal");
                String bsql="insert into billAcc(billID,billName,Balance) values('"+bbillID+"','"+bbillName+"','"+bBalance+"')";
                st.executeUpdate(bsql);
                response.sendRedirect("addDataToDB.jsp");
                break;
        }
        
            
            
            
        
        
   %>
   
    </body>
</html>
