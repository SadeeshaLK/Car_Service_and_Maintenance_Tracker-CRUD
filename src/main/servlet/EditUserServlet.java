package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.*;
import java.util.*;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {

    private static final String FILE_PATH = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/users.txt"; // Path to users.txt file

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameToEdit = request.getParameter("username");

        // Load the user data for editing
        BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH));
        List<String> lines = new ArrayList<>();
        String line;
        while ((line = reader.readLine()) != null) {
            lines.add(line);
        }
        reader.close();

        // Find the user and prepare data for editing
        User userToEdit = null;
        for (String userLine : lines) {
            String[] parts = userLine.split(",");
            if (parts[0].equals(usernameToEdit)) {
                userToEdit = new User(parts[0], parts[1], parts[2]);
                break;
            }
        }

        if (userToEdit != null) {
            request.setAttribute("userToEdit", userToEdit);
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
        } else {
            response.sendRedirect("manageUsers.jsp?error=User not found");
        }
    }
}
