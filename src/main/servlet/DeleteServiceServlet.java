package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/DeleteServiceServlet")
public class DeleteServiceServlet extends HttpServlet {

    private static final String FILE_PATH = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/services.txt"; // Path to services.txt file

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleIDToDelete = request.getParameter("vehicleID");
        String serviceDateToDelete = request.getParameter("serviceDate");

        // Read all service records from services.txt
        File file = new File(FILE_PATH);
        List<String> lines = new ArrayList<>();
        boolean recordFound = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (!parts[0].equals(vehicleIDToDelete) || !parts[1].equals(serviceDateToDelete)) {
                    lines.add(line);
                } else {
                    recordFound = true;
                }
            }
        }

        if (!recordFound) {
            response.sendRedirect("manageServices.jsp?error=Service record not found");
            return;
        }

        // Write the updated list back to services.txt
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String updatedLine : lines) {
                writer.write(updatedLine);
                writer.newLine();
            }
        }

        // Redirect back to manage services page with success message
        response.sendRedirect("manageServices.jsp?success=Service record deleted successfully");
    }
}
