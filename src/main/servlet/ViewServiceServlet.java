package servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ViewServiceServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String services = FileUtil.readFromFile("services.txt");
        request.setAttribute("services", services);
        request.getRequestDispatcher("viewServices.jsp").forward(request, response);
    }
}