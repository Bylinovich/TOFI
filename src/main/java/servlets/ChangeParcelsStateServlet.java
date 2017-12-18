package servlets;

import crud.CurrencyController;
import crud.ParcelController;
import entity.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet("/ChangeParcelsState")
public class ChangeParcelsStateServlet extends BaseHttpServlet {
    protected void process(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setStatus(200);
        String refererURI = null;
        String s = request.getHeader("Referer");
        if (s == null){
            response.sendRedirect(request.getContextPath()+"/NewOrder");
            return;
        }
        try {
            refererURI = new URI(request.getHeader("Referer")).getPath();
            System.out.println("!@!@");
            System.out.println(refererURI);
        }
        catch (URISyntaxException e) {
            e.printStackTrace();
        }
//        if (!refererURI.contains("jsp/showParcels.jsp")){
//            response.sendRedirect(request.getContextPath()+"/NewOrder");
//            return;
//        }

        User user = (User) request.getSession().getAttribute("user");
        if(user.getUsername() == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath());
            return;
        }

        ArrayList<Parcel> parcels = (ArrayList<Parcel>) request.getSession().getAttribute("parcels");

        ParcelController parcelController = new ParcelController();

        for (Parcel parcel:parcels
             ) {
            String state = request.getParameter("state".concat(String.valueOf(parcel.getId())));
            parcel.setState(state);
            parcelController.updateParcel(parcel);
        }
        response.sendRedirect(request.getContextPath()+"/ShowParcels");
    }
}
