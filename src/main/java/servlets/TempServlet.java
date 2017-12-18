package servlets;

import crud.*;
import entity.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Влад on 18.11.2016.
 */
@WebServlet("/Temp")
public class TempServlet extends BaseHttpServlet{
    protected void process(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setStatus(200);
        PrintWriter pw = response.getWriter();

        Order order = new Order(5);// 5 is user id
        RateController rateController = new RateController();
        Rate rate = rateController.getCurrentRate();
        CurrencyController currencyController = new CurrencyController();
        ArrayList<Currency> currencies = (ArrayList<Currency>) currencyController.getAllCurrency();

        String description =  "Phones";
        String recipientInfo = "Ivan";
        String currency = request.getParameter("currency");
        String stringWeight = request.getParameter("weight").replace(",",".");
        double weight = 0;
    }
}
