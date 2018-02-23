<%-- 
    Document   : addDataToDB
    Created on : Jun 25, 2017, 10:57:28 AM
    Author     : chaminda
--%>

<%@page import="com.jspcr.servlets.crypt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AddDataToDB</title>
    </head>
    <body>
        <div>
            <form action="addDataToDB.jsp">
                Select table: 
                <select name="tbl">
                    <option selected>Customer</option>
                    <option>Account</option>
                    <option>BillAcc</option>
                </select><br>
                <input type="submit" value="submit">
            </form>
        </div>
        <br><br>
        <div>
            <%
                
                out.println(getServletContext().getRealPath("/DB/BankingDB.sqlite"));
                String selected="Customer";
                if(!(request.getParameter("tbl")==null)){
                    selected=request.getParameter("tbl");
                }
                switch(selected){
                    case "Customer":%>
                    <form id="customer" name="customer" action="newjsp.jsp" enctype="multipart/form-data">
                        <h2>Customer</h2><br>
                        
                <input type="text" name="pw">
                        cusNIC<input type="text" name="cusNIC" id="cusNIC"><br><br>
                        cusName<input type="text" name="cusName" id="cusName"><br><br>
                        cusAddress<input type="text" name="cusAddress" id="cusAddress"><br><br>
                        cusTP<input type="text" name="cusTP" id="cusTP"><br><br>
                        password<input type="password" name="password" id="PW"><br><br>
                        email<input type="text" name="email" id="recOp"><br><br>
                        <input type="hidden" name="tbl" value="customer">
                        <input type="submit" value="Save">
                    </form>
            <%;break;
            case "Account":%>
                    <form action="newjsp.jsp">
                        <h2>Account</h2><br>
                        
                <input type="text" name="pw">
                        AccNo<input type="text" name="accNo" id="accNo"><br><br>
                        accName<input type="text" name="accName" id="accName"><br><br>
                        acctype<input type="text" name="accType" id="accType"><br><br>
                        cusNIC<input type="text" name="cusNIC" id="cusNIC"><br><br>
                        balance<input type="text" name="balance" id="balance"><br><br>
                        <input type="hidden" name="tbl" value="account">
                        <input type="submit" value="Save">
                    </form>
            <%;break;
            case "BillAcc":%>
                    <form action="newjsp.jsp">
                        <h2>BillAcc</h2><br>
                        
                <input type="text" name="pw">
                        billID<input type="text" name="billID" id="billID"><br><br>
                        billName<input type="text" name="billName" id="billName"><br><br>
                        Balance<input type="text" name="billBal" id="billBal"><br><br>
                        <input type="hidden" name="tbl" value="billAcc">
                        <input type="submit" value="Save">
                    </form>
            <%;break;
                }
                %>
        </div>
    </body>
</html>
