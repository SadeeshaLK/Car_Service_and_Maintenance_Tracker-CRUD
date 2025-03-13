package servlet;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String FILE_PATH = "src/main/users.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH));
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts[0].equals(username) && parts[1].equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", new User(parts[0], parts[1], parts[2]));

                response.sendRedirect(parts[2].equals("admin") ? "adminDashboard.jsp" : "index.jsp");
                reader.close();
                return;
            }
        }
        reader.close();
        response.sendRedirect("login.jsp?error=Invalid credentials");
    }
}