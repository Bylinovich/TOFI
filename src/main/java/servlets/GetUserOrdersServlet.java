package servlets;

import crud.OrderController;
import entity.Order;
import entity.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


@WebServlet("/UserOrders")
public class GetUserOrdersServlet extends BaseHttpServlet {
    protected void process(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setStatus(200);
        //!!not used!!
        User user = (User) request.getSession().getAttribute("user");
        OrderController orderController = new OrderController();

        List<Order> userOrders = orderController.getUserOrders(user.getId());

        if(userOrders != null) {
            request.getSession().setAttribute("userOrders", userOrders);
            response.sendRedirect(request.getContextPath()+"/jsp/history.jsp");
        }
        else {
            request.getSession().setAttribute("message", "This user hasn't any orders");
            response.sendRedirect(request.getContextPath()+"/jsp/history.jsp");
        }

    }
}
