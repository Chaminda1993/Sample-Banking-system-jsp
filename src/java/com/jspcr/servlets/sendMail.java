/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.jspcr.servlets;

import static com.jspcr.servlets.sendMail.password;
import static com.jspcr.servlets.sendMail.sender_email;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author chaminda
 */
@WebServlet(name = "email", urlPatterns = {"/email"})
public class sendMail extends HttpServlet {

    
    protected static String sender_email = "GoldenPacificNationalBank@gmail.com";
    protected static String password = "Golden Pacific National Bank";
    static String host = "smtp.gmail.com";
    static String port = "465";
    //static String to = "c771904768@gmail.com";
    static String subject = "email";
    //static String text = "send by system";  // send text msg
   // static String text = "<center><h1>test</h1></center>"; //send html content
//    static String text = "<img src='http://t1.gstatic.com/images?q=tbn:ANd9GcSzAVOXh4JGnOJO72N6driVuduthsD0S5_5TdbI2rq5hVXpsUjm'/>"; //send image

    

    public static void send(String to,String text) {
        Properties props = new Properties();
        props.put("mail.smtp.user", sender_email);
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.socketFactory.port", port);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");

        try {
            // send text
            Authenticator auth = new SMTPAuthenticator();
            Session session = Session.getInstance(props, auth);

            MimeMessage msg = new MimeMessage(session);
            msg.setSubject(subject);
            msg.setFrom(new InternetAddress(sender_email));

            BodyPart messageBodyPart = new MimeBodyPart();

            messageBodyPart.setText(text);

            Multipart multipart = new MimeMultipart();

            multipart.addBodyPart(messageBodyPart);

            msg.setContent(multipart);
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            Transport.send(msg);

            

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
class SMTPAuthenticator extends Authenticator {

        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(sender_email, password);
        }
    }

