package servlets;

import crud.ParcelController;
import entity.Parcel;
import entity.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * Created by Влад on 12.11.2016.
 */
@WebServlet("/ShowParcels")
public class ShowParcelsServlet extends BaseHttpServlet {

    private boolean isDigit(String digit){
        try{
            Integer.parseInt(digit);
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    protected void process(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setStatus(200);
        Object object = request.getSession().getAttribute("user");
        if (object == null){
            response.sendRedirect(request.getContextPath());
            return;
        }
        User user = (User) object;
        if (!user.isAdmin()){
            response.sendRedirect(request.getContextPath());
            return;
        }

        ParcelController parcelController = new ParcelController();
        Object obj = request.getParameter("page");
        Integer pageNumber = 1;
        Integer pageAmount = parcelController.getPageAmount(5);
        if (obj != null && isDigit((String) obj)){
            Integer reqPage = Integer.parseInt((String) obj);
            if (reqPage < 1){
                reqPage = 1;
            }
            if (reqPage > pageAmount){
                reqPage = pageAmount;
            }
            pageNumber = reqPage;
        }

        ArrayList<Parcel> parcels = (ArrayList<Parcel>) parcelController.getPageOfUsers(pageNumber, 5);
        ArrayList<String> states = new ArrayList<>();
        states.add("Not delivered");
        states.add("On the way");
        states.add("Delivered");
        states.add("Canceled");
        request.setAttribute("states", states);
        request.getSession().setAttribute("parcels", parcels);
        request.setAttribute("pageAmount", pageAmount);
        request.setAttribute("pageNumber", pageNumber);

        RequestDispatcher rd = request.getRequestDispatcher("jsp/showParcels.jsp");
        rd.forward(request, response);
    }
}
