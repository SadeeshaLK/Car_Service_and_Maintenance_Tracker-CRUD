package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/UpdateVehicleServlet")  // Ensure this matches the form action in updateVehicle.jsp
public class UpdateVehicleServlet extends HttpServlet {

    private static final String FILE_PATH = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/vehicles.txt"; // Path to vehicles.txt file

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleID = request.getParameter("vehicleID");
        String newOwner = request.getParameter("owner");
        String newModel = request.getParameter("model");
        int newYear = Integer.parseInt(request.getParameter("year"));

        // Read all vehicles from file
        File file = new File(FILE_PATH);
        List<String> lines = new ArrayList<>();
        boolean vehicleFound = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts[0].equals(vehicleID)) {
                    // Update the vehicle record
                    lines.add(vehicleID + "," + newOwner + "," + newModel + "," + newYear);
                    vehicleFound = true;
                } else {
                    lines.add(line);
                }
            }
        }

        if (!vehicleFound) {
            response.sendRedirect("manageVehicles.jsp?error=Vehicle not found");
            return;
        }

        // Write the updated list back to vehicles.txt
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String updatedLine : lines) {
                writer.write(updatedLine);
                writer.newLine();
            }
        }

        response.sendRedirect("manageVehicles.jsp?success=Vehicle updated successfully");
    }
}
