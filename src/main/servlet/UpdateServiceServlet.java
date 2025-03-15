package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/UpdateServiceServlet")  // Ensure this matches the form action in editService.jsp
public class UpdateServiceServlet extends HttpServlet {

    private static final String FILE_PATH = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/services.txt"; // Ensure the correct path

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleID = request.getParameter("vehicleID");
        String oldServiceDate = request.getParameter("oldServiceDate");  // Store old service date to find existing record
        String newServiceDate = request.getParameter("serviceDate");
        String serviceType = request.getParameter("serviceType");
        double cost = Double.parseDouble(request.getParameter("cost"));
        int mileage = Integer.parseInt(request.getParameter("mileage"));

        // Read all service records from file
        File file = new File(FILE_PATH);
        List<String> lines = new ArrayList<>();
        boolean recordFound = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts[0].equals(vehicleID) && parts[1].equals(oldServiceDate)) {
                    // Update the existing record
                    lines.add(vehicleID + "," + newServiceDate + "," + serviceType + "," + cost + "," + mileage);
                    recordFound = true;
                } else {
                    lines.add(line); // Keep other records unchanged
                }
            }
        }

        if (!recordFound) {
            response.sendRedirect("manageServices.jsp?error=Service record not found");
            return;
        }

        // Write the updated records back to file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String updatedLine : lines) {
                writer.write(updatedLine);
                writer.newLine();
            }
        }

        // Redirect back to manage services page with success message
        response.sendRedirect("manageServices.jsp?success=Service record updated successfully");
    }
}
