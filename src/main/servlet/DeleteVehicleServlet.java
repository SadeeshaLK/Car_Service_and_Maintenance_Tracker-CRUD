package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/DeleteVehicleServlet")
public class DeleteVehicleServlet extends HttpServlet {

    private static final String FILE_PATH = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/vehicles.txt"; // Ensure correct path

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleIDToDelete = request.getParameter("vehicleID");

        File file = new File(FILE_PATH);
        List<String> lines = new ArrayList<>();
        boolean vehicleFound = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (!parts[0].equals(vehicleIDToDelete)) {
                    lines.add(line);
                } else {
                    vehicleFound = true;
                }
            }
        }

        if (!vehicleFound) {
            response.sendRedirect("manageVehicles.jsp?error=Vehicle not found");
            return;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String updatedLine : lines) {
                writer.write(updatedLine);
                writer.newLine();
            }
        }

        response.sendRedirect("manageVehicles.jsp?success=Vehicle deleted successfully");
    }
}
