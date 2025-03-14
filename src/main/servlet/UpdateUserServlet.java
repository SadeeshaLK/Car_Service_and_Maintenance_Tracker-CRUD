package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {

    private static final String FILE_PATH = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/users.txt"; // Path to users.txt file

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameToEdit = request.getParameter("username");
        String newRole = request.getParameter("role");

        // Read all users from the file
        BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH));
        List<String> lines = new ArrayList<>();
        String line;

        // Update user data
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts[0].equals(usernameToEdit)) {
                // Update the user information
                lines.add(parts[0] + "," + parts[1] + "," + newRole);
            } else {
                lines.add(line);
            }
        }
        reader.close();

        // Rewrite the file with the updated data
        BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH));
        for (String updatedLine : lines) {
            writer.write(updatedLine);
            writer.newLine();
        }
        writer.close();

        // Redirect back to manage users page
        response.sendRedirect("manageUsers.jsp");
    }
}
