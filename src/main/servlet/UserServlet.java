package servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.FileUtil;
import java.io.IOException;

public class UserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        String data = username + "," + password + "," + email;
        FileUtil.writeToFile("users.txt", data);

        response.sendRedirect("userManagement.jsp");
    }
}