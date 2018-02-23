/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.jspcr.servlets;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

/**
 *
 * @author chaminda
 */
@WebServlet(name = "tools", urlPatterns = {"/tools"})
public class tools extends HttpServlet {
    
    public static boolean loged=false;
    public static String ANO="";
    private static Date lockTo=null;
    private static int errCount=0;
    public static String curName="LKR";
    private static double rate=0;
    public static String AdminEmail="gayani.kosgahawewa@gmail.com";

    public static String genKey(){
        int j=(int)(Math.random()*100000);
        return Integer.toString(j);
    }
    
    public static void logOut(){
        crypt.setSecret(""); tools.loged=false; tools.ANO="";curName="LKR";
    }
    
    public static void lockSys(int minites){
        lockTo = new Date(System.currentTimeMillis()+minites*errCount*60*1000);
    }
    public static boolean lockSys(){
        if(lockTo!=null && lockTo.after(new Date()) ){
            return true;
        }else{
            return false;
        }
    }
    public static void addErrCount(){
        errCount++;
        if(errCount>5){
            sendMail.send(AdminEmail, "Someone try to login system within incorrect password.");
        }
    }
    
    public static double curCon(double amount){
        try {
                String thisLine;
                URL u = new URL("http://download.finance.yahoo.com/d/quotes.csv?f=l1&s=LKR"+curName+"=X");
                DataInputStream theHTML = new DataInputStream(u.openStream());
                if((thisLine = theHTML.readLine()) != null) {
                    rate=Double.valueOf(thisLine);
                }
            amount=amount*rate;
            
        } catch (Exception ex) {
            Logger.getLogger(tools.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (double)Math.round(amount*100)/100;
    }
}
