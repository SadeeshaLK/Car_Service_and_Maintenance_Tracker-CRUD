package servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.FileUtil;
import java.io.IOException;

public class AddServiceServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String serviceId = request.getParameter("serviceId");
        String carId = request.getParameter("carId");
        String serviceDate = request.getParameter("serviceDate");
        String serviceType = request.getParameter("serviceType");
        double serviceCost = Double.parseDouble(request.getParameter("serviceCost"));

        String data = serviceId + "," + carId + "," + serviceDate + "," + serviceType + "," + serviceCost;
        FileUtil.writeToFile("services.txt", data);

        response.sendRedirect("viewServices.jsp");
    }
}