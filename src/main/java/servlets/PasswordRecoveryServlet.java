package servlets;

import crud.UserController;
import entity.User;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Properties;

/**
 * Created by Vlad on 20.12.2017.
 */
@WebServlet("/PasswordRecovery")
public class PasswordRecoveryServlet extends BaseHttpServlet {

    private void sendEmail(String email, String mes) {
        try {
            Properties emailAccountProperties = new Properties();

            final String username = "storkexpress";
            final String password = "welovetofi";

            Properties prop = new Properties();
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.starttls.enable", "true");
            prop.put("mail.smtp.host", "smtp.yandex.ru");
            prop.put("mail.smtp.port", "587");

            Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

            try {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress("storkexpress@yandex.ru"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                message.setSubject("Test email");
                message.setContent(mes,
                        "text/html; charset=utf-8");
                Transport.send(message);
            } catch (MessagingException e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected void process(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setStatus(200);

        String refererURI = null;
        String s = request.getHeader("Referer");
        if (s == null){
            response.sendRedirect(request.getContextPath());
            return;
        }
        try {
            refererURI = new URI(request.getHeader("Referer")).getPath();
        }
        catch (URISyntaxException e) {
            e.printStackTrace();
        }


        UserController userController = new UserController();

        User sesUser = (User) request.getSession().getAttribute("user");
        if (sesUser.getUsername() != null){
            response.sendRedirect(request.getContextPath());
            return;
        }

        String email = request.getParameter("email");
        User user = userController.getUserByEmail(email);

        if (user != null) {
            String  pass = "6fcg24kl";
//            user.setPassword(pass);
            sendEmail(user.getEmail(), "your password: " + pass);
        } else {
            request.getSession().setAttribute("passwordRecoveryError", "Wrong email");
            response.sendRedirect(request.getContextPath()+"/jsp/passwordRecovery.jsp");
            return;
        }
        response.sendRedirect(request.getContextPath());
    }
}

