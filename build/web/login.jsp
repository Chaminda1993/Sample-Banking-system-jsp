<%-- 
    Document   : login
    Created on : Jun 26, 2017, 10:10:50 AM
    Author     : chaminda
--%>
<%@page import="com.jspcr.servlets.sendMail"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.jspcr.servlets.db"%>
<%@page import="org.sqlite.core.CoreConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="com.jspcr.servlets.crypt"%>
<%@page import="com.jspcr.servlets.tools"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body style="background-color:lightgray">
        <div id="header">                                                      <! *************************Start Header ************************** >
            <%
                Connection con=db.getConn();
                %>
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
                                <H4 style="color:blueviolet">Account Balance : <%=  tools.curName+" "+bal %></H4>
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
        
        
        <div name="loginForm"  align="center">
            <form>
                <h2>Login to System</h2><br>
                <%
                    String paraType=request.getParameter("type");
                     tools.logOut();
                    //out.println(null==paraType);
            
            if("logErr".equals(paraType)){
                tools.logOut();
                %>
                <h4 color="red">Invalid account number or password.</h4>
                <%
            }
            if(null!=request.getParameter("accNo")){
                if(!tools.lockSys()){
String accNo=request.getParameter("accNo");
                String pw=request.getParameter("pw");
                Date date=new Date();
                crypt.setSecret(pw);                                  //************** Set password to crypt ***************
                
                String encPW="";
                Statement st=con.createStatement();
                try{
                    ResultSet rs=st.executeQuery("select customers.pw,accounts.cusNIC,customers.secret from customers left join accounts on accounts.cusNIC=customers.cusNIC where accounts.accNo='"+accNo+"'");
                    rs.next();
                    encPW=rs.getString("pw");
                    String cusNIC=rs.getString("cusNIC");
                    if(crypt.encrypt(pw).equals(encPW)){
                        crypt.setSecret(rs.getString("secret"));
                        cusNIC=crypt.decrypt(cusNIC);
                        st=con.createStatement();
                        st.executeUpdate("insert into loginLog(cusNIC,accNo,time) values('"+cusNIC+"','"+accNo+"','"+date+"')");
                        tools.loged = true;
                        tools.ANO=accNo;
                        response.sendRedirect("home.jsp");
                    }else{
                        tools.addErrCount();
                        tools.lockSys(2);
                        response.sendRedirect("login.jsp?type=logErr");
                    }
                    st.close();rs.close(); 
                }catch(Exception ex){
                    tools.logOut();
                    ex.printStackTrace();
                    response.sendRedirect("login.jsp?type=logErr&sqlErr");
                }
            }else{
                out.println("System lock for some time");
            }
                
            }
           
            %>
            <br>  <table>
                    <tr>
                        <td>Account No: </td>
                        <td><input type="text" name="accNo"></td>
                    </tr>
                    <tr>
                        <td>Password :</td>
                        <td><input type="password" name="pw"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Login" action="login.jsp"></td>
                    </tr>
                </table>
                <br><a href="login.jsp?type=rec">Recovery your account.</a>
        
            </form>
        </div>
        
        <%
            
            if("rec".equals(paraType)){
                
                %>
                <div name="loginRec"  align="center">
                    <h3>Recover your account</h3><br>
                    <p>Your account password will reset.New password will send to your e-mail.</p><br>
                    <form>
                        Enter your account no : <input type="text" name="accNoReset">
                        <input type="submit" action="login.jsp" value="Send">
                    </form>
                </div>
                <%
            }
            if(null!=request.getParameter("accNoReset")){
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery("select customers.email,customers.cusNIC from customers left join accounts on accounts.cusNIC=customers.cusNIC where accounts.accNo='"+request.getParameter("accNoReset")+"'");
                String email="";
                if(rs.next()){
                email=rs.getString("email");
                String cusNIC=rs.getString("cusNIC");
                String newKey=tools.genKey();
                crypt.setSecret(newKey);
                String cryptKey=crypt.encrypt(newKey);
                st.executeUpdate("Update customers set pw='"+cryptKey+"' where customers.cusNIC='"+cusNIC+"'");
                crypt.setSecret("");
                st.close();rs.close(); 

                //send email
                //out.println("key: "+newKey+"<br>email: "+email+"<br>This key send to customer email.");
                sendMail.send(email, "Your account password have been reset.Account no is : "+request.getParameter("accNoReset")+"New password is : "+newKey);
                }
                %>
                <div align="center" border="1px">
                    <p>Your password has been reset.New password sent to <%=email %>.</p>
                    <form>
                        <input type="submit" action="login.jsp" value="OK">
                    </form>
                </div>
                <%
            }
            %>
    </body>
</html>
