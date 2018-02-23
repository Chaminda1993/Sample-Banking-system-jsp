<%-- 
    Document   : home
    Created on : Jun 26, 2017, 11:17:59 AM
    Author     : chaminda
--%>

<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.jspcr.servlets.db"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.jspcr.servlets.tools"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
    </head>
    <body style="background-color:lightgray">
        <% 
            if("out".equals(request.getParameter("type"))){
                tools.logOut();
            }
            %>
            <div id="header">                                                      <! *************************Start Header ************************** >
        <%
                Connection con=db.getConn();
                %>
                <div style="background-color: lightsteelblue" align="center">   
            <table width="80%">
                <tr>
                    <td><img src="proc/logo.png" alt="logo" style="width:100px;height:100px;"></td>
                    <td>
                        <h1 style="color:darkblue">Golden Pacific National Bank</h1>
                        <form action="about.jsp"><input type="submit" value="Contact"></form>
                    </td>
                    <td align="right">
                        <% if(tools.loged){
                            if(null!=request.getParameter("curName")){
                                tools.curName=request.getParameter("curName");
                            }
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
                                <H4 style="color:blueviolet">Account Balance :<%= tools.curName +" "+ bal %></H4>
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
                    <div align="center"><form action="home.jsp"><select  name="curName">
                            <option  value="AED">United Arab Emirates Dirham (AED)</option>
                            <option  value="AFN">Afghan Afghani (AFN)</option>
                            <option  value="ALL">Albanian Lek (ALL)</option>
                            <option  value="AMD">Armenian Dram (AMD)</option>
                            <option  value="ANG">Netherlands Antillean Guilder (ANG)</option>
                            <option  value="AOA">Angolan Kwanza (AOA)</option>
                            <option  value="ARS">Argentine Peso (ARS)</option>
                            <option  value="AUD">Australian Dollar (A$)</option>
                            <option  value="AWG">Aruban Florin (AWG)</option>
                            <option  value="AZN">Azerbaijani Manat (AZN)</option>
                            <option  value="BAM">Bosnia-Herzegovina Convertible Mark (BAM)</option>
                            <option  value="BBD">Barbadian Dollar (BBD)</option>
                            <option  value="BDT">Bangladeshi Taka (BDT)</option>
                            <option  value="BGN">Bulgarian Lev (BGN)</option>
                            <option  value="BHD">Bahraini Dinar (BHD)</option>
                            <option  value="BIF">Burundian Franc (BIF)</option>
                            <option  value="BMD">Bermudan Dollar (BMD)</option>
                            <option  value="BND">Brunei Dollar (BND)</option>
                            <option  value="BOB">Bolivian Boliviano (BOB)</option>
                            <option  value="BRL">Brazilian Real (R$)</option>
                            <option  value="BSD">Bahamian Dollar (BSD)</option>
                            <option  value="BTC">Bitcoin (฿)</option>
                            <option  value="BTN">Bhutanese Ngultrum (BTN)</option>
                            <option  value="BWP">Botswanan Pula (BWP)</option>
                            <option  value="BYN">Belarusian Ruble (BYN)</option>
                            <option  value="BYR">Belarusian Ruble (2000–2016) (BYR)</option>
                            <option  value="BZD">Belize Dollar (BZD)</option>
                            <option  value="CAD">Canadian Dollar (CA$)</option>
                            <option  value="CDF">Congolese Franc (CDF)</option>
                            <option  value="CHF">Swiss Franc (CHF)</option>
                            <option  value="CLF">Chilean Unit of Account (UF) (CLF)</option>
                            <option  value="CLP">Chilean Peso (CLP)</option>
                            <option  value="CNH">CNH (CNH)</option>
                            <option  value="CNY">Chinese Yuan (CN¥)</option>
                            <option  value="COP">Colombian Peso (COP)</option>
                            <option  value="CRC">Costa Rican Colón (CRC)</option>
                            <option  value="CUP">Cuban Peso (CUP)</option>
                            <option  value="CVE">Cape Verdean Escudo (CVE)</option>
                            <option  value="CZK">Czech Koruna (CZK)</option>
                            <option  value="DEM">German Mark (DEM)</option>
                            <option  value="DJF">Djiboutian Franc (DJF)</option>
                            <option  value="DKK">Danish Krone (DKK)</option>
                            <option  value="DOP">Dominican Peso (DOP)</option>
                            <option  value="DZD">Algerian Dinar (DZD)</option>
                            <option  value="EGP">Egyptian Pound (EGP)</option>
                            <option  value="ERN">Eritrean Nakfa (ERN)</option>
                            <option  value="ETB">Ethiopian Birr (ETB)</option>
                            <option  value="EUR">Euro (€)</option>
                            <option  value="FIM">Finnish Markka (FIM)</option>
                            <option  value="FJD">Fijian Dollar (FJD)</option>
                            <option  value="FKP">Falkland Islands Pound (FKP)</option>
                            <option  value="FRF">French Franc (FRF)</option>
                            <option  value="GBP">British Pound (£)</option>
                            <option  value="GEL">Georgian Lari (GEL)</option>
                            <option  value="GHS">Ghanaian Cedi (GHS)</option>
                            <option  value="GIP">Gibraltar Pound (GIP)</option>
                            <option  value="GMD">Gambian Dalasi (GMD)</option>
                            <option  value="GNF">Guinean Franc (GNF)</option>
                            <option  value="GTQ">Guatemalan Quetzal (GTQ)</option>
                            <option  value="GYD">Guyanaese Dollar (GYD)</option>
                            <option  value="HKD">Hong Kong Dollar (HK$)</option>
                            <option  value="HNL">Honduran Lempira (HNL)</option>
                            <option  value="HRK">Croatian Kuna (HRK)</option>
                            <option  value="HTG">Haitian Gourde (HTG)</option>
                            <option  value="HUF">Hungarian Forint (HUF)</option>
                            <option  value="IDR">Indonesian Rupiah (IDR)</option>
                            <option  value="IEP">Irish Pound (IEP)</option>
                            <option  value="ILS">Israeli New Shekel (₪)</option>
                            <option  value="INR">Indian Rupee (₹)</option>
                            <option  value="IQD">Iraqi Dinar (IQD)</option>
                            <option  value="IRR">Iranian Rial (IRR)</option>
                            <option  value="ISK">Icelandic Króna (ISK)</option>
                            <option  value="ITL">Italian Lira (ITL)</option>
                            <option  value="JMD">Jamaican Dollar (JMD)</option>
                            <option  value="JOD">Jordanian Dinar (JOD)</option>
                            <option  value="JPY">Japanese Yen (¥)</option>
                            <option  value="KES">Kenyan Shilling (KES)</option>
                            <option  value="KGS">Kyrgystani Som (KGS)</option>
                            <option  value="KHR">Cambodian Riel (KHR)</option>
                            <option  value="KMF">Comorian Franc (KMF)</option>
                            <option  value="KPW">North Korean Won (KPW)</option>
                            <option  value="KRW">South Korean Won (₩)</option>
                            <option  value="KWD">Kuwaiti Dinar (KWD)</option>
                            <option  value="KYD">Cayman Islands Dollar (KYD)</option>
                            <option  value="KZT">Kazakhstani Tenge (KZT)</option>
                            <option  value="LAK">Laotian Kip (LAK)</option>
                            <option  value="LBP">Lebanese Pound (LBP)</option>
                            <option  SELECTED value="LKR">Sri Lankan Rupee (LKR)</option>
                            <option  value="LRD">Liberian Dollar (LRD)</option>
                            <option  value="LSL">Lesotho Loti (LSL)</option>
                            <option  value="LTL">Lithuanian Litas (LTL)</option>
                            <option  value="LVL">Latvian Lats (LVL)</option>
                            <option  value="LYD">Libyan Dinar (LYD)</option>
                            <option  value="MAD">Moroccan Dirham (MAD)</option>
                            <option  value="MDL">Moldovan Leu (MDL)</option>
                            <option  value="MGA">Malagasy Ariary (MGA)</option>
                            <option  value="MKD">Macedonian Denar (MKD)</option>
                            <option  value="MMK">Myanmar Kyat (MMK)</option>
                            <option  value="MNT">Mongolian Tugrik (MNT)</option>
                            <option  value="MOP">Macanese Pataca (MOP)</option>
                            <option  value="MRO">Mauritanian Ouguiya (MRO)</option>
                            <option  value="MUR">Mauritian Rupee (MUR)</option>
                            <option  value="MVR">Maldivian Rufiyaa (MVR)</option>
                            <option  value="MWK">Malawian Kwacha (MWK)</option>
                            <option  value="MXN">Mexican Peso (MX$)</option>
                            <option  value="MYR">Malaysian Ringgit (MYR)</option>
                            <option  value="MZN">Mozambican Metical (MZN)</option>
                            <option  value="NAD">Namibian Dollar (NAD)</option>
                            <option  value="NGN">Nigerian Naira (NGN)</option>
                            <option  value="NIO">Nicaraguan Córdoba (NIO)</option>
                            <option  value="NOK">Norwegian Krone (NOK)</option>
                            <option  value="NPR">Nepalese Rupee (NPR)</option>
                            <option  value="NZD">New Zealand Dollar (NZ$)</option>
                            <option  value="OMR">Omani Rial (OMR)</option>
                            <option  value="PAB">Panamanian Balboa (PAB)</option>
                            <option  value="PEN">Peruvian Sol (PEN)</option>
                            <option  value="PGK">Papua New Guinean Kina (PGK)</option>
                            <option  value="PHP">Philippine Peso (PHP)</option>
                            <option  value="PKG">PKG (PKG)</option>
                            <option  value="PKR">Pakistani Rupee (PKR)</option>
                            <option  value="PLN">Polish Zloty (PLN)</option>
                            <option  value="PYG">Paraguayan Guarani (PYG)</option>
                            <option  value="QAR">Qatari Rial (QAR)</option>
                            <option  value="RON">Romanian Leu (RON)</option>
                            <option  value="RSD">Serbian Dinar (RSD)</option>
                            <option  value="RUB">Russian Ruble (RUB)</option>
                            <option  value="RWF">Rwandan Franc (RWF)</option>
                            <option  value="SAR">Saudi Riyal (SAR)</option>
                            <option  value="SBD">Solomon Islands Dollar (SBD)</option>
                            <option  value="SCR">Seychellois Rupee (SCR)</option>
                            <option  value="SDG">Sudanese Pound (SDG)</option>
                            <option  value="SEK">Swedish Krona (SEK)</option>
                            <option  value="SGD">Singapore Dollar (SGD)</option>
                            <option  value="SHP">St. Helena Pound (SHP)</option>
                            <option  value="SKK">Slovak Koruna (SKK)</option>
                            <option  value="SLL">Sierra Leonean Leone (SLL)</option>
                            <option  value="SOS">Somali Shilling (SOS)</option>
                            <option  value="SRD">Surinamese Dollar (SRD)</option>
                            <option  value="STD">São Tomé &amp; Príncipe Dobra (STD)</option>
                            <option  value="SVC">Salvadoran Colón (SVC)</option>
                            <option  value="SYP">Syrian Pound (SYP)</option>
                            <option  value="SZL">Swazi Lilangeni (SZL)</option>
                            <option  value="THB">Thai Baht (THB)</option>
                            <option  value="TJS">Tajikistani Somoni (TJS)</option>
                            <option  value="TMT">Turkmenistani Manat (TMT)</option>
                            <option  value="TND">Tunisian Dinar (TND)</option>
                            <option  value="TOP">Tongan Paʻanga (TOP)</option>
                            <option  value="TRY">Turkish Lira (TRY)</option>
                            <option  value="TTD">Trinidad &amp; Tobago Dollar (TTD)</option>
                            <option  value="TWD">New Taiwan Dollar (NT$)</option>
                            <option  value="TZS">Tanzanian Shilling (TZS)</option>
                            <option  value="UAH">Ukrainian Hryvnia (UAH)</option>
                            <option  value="UGX">Ugandan Shilling (UGX)</option>
                            <option  value="USD">US Dollar ($)</option>
                            <option  value="UYU">Uruguayan Peso (UYU)</option>
                            <option  value="UZS">Uzbekistani Som (UZS)</option>
                            <option  value="VEF">Venezuelan Bolívar (VEF)</option>
                            <option  value="VND">Vietnamese Dong (₫)</option>
                            <option  value="VUV">Vanuatu Vatu (VUV)</option>
                            <option  value="WST">Samoan Tala (WST)</option>
                            <option  value="XAF">Central African CFA Franc (FCFA)</option>
                            <option  value="XCD">East Caribbean Dollar (EC$)</option>
                            <option  value="XDR">Special Drawing Rights (XDR)</option>
                            <option  value="XOF">West African CFA Franc (CFA)</option>
                            <option  value="XPF">CFP Franc (CFPF)</option>
                            <option  value="YER">Yemeni Rial (YER)</option>
                            <option  value="ZAR">South African Rand (ZAR)</option>
                            <option  value="ZMK">Zambian Kwacha (1968–2012) (ZMK)</option>
                            <option  value="ZMW">Zambian Kwacha (ZMW)</option>
                            <option  value="ZWL">Zimbabwean Dollar (2009) (ZWL)</option>
                            </select>
                                <input type="submit" value="Set">
                            </form></div>
            <%
                }
            %> 
            </div>                              <! ************************* End Header ************************** >
            
            
            <div>
                <table>
                    <tr>
                        <td><img src="proc/1.jpg" alt="logo" style="width:100%;"></td>
                        <td><img src="proc/2.jpg" alt="logo" style="width:100%;"></td>
                    </tr>
                    <tr>
                        <td><img src="proc/3.jpg" alt="logo" style="width:100%;"></td>
                        <td><img src="proc/4.jpg" alt="logo" style="width:100%;"></td>
                    </tr>
                </table>
            </div>
    </body>
</html>
