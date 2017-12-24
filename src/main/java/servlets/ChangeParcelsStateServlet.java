package servlets;

import crud.CurrencyController;
import crud.OrderController;
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

import static java.lang.Byte.valueOf;

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

        String generalState = request.getParameter("state_selected");
        for (Parcel parcel:parcels
             ) {
            if ("Waiting for the parcel".equals(parcel.getState())) {
                double weight = Double.parseDouble(request.getParameter("weight".concat(String.valueOf(parcel.getId()))).replace(",", "."));
                if (parcel.getWeight() != weight) {
                    parcel.setWeight(weight);
                }
            }
            String state = request.getParameter("state".concat(String.valueOf(parcel.getId())));
            parcel.setState(state);
            if (request.getParameter("select_".concat(String.valueOf(parcel.getId()))) != null) {
                parcel.setState(generalState);
            }
            parcelController.updateParcel(parcel);
            if ("Canceled".equals(parcel.getState())) {
                OrderController orderController = new OrderController();
                Order order = orderController.getOrderById(parcel.getOrderId());
                ParcelController parcelController1 = new ParcelController();
                parcelController.deleteParcel(parcel.getId());
                order.updateCost();
            }
        }
        response.sendRedirect(request.getContextPath()+"/ShowParcels");
    }
}
