package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/AddServiceServlet")  // Ensure this matches the form action in addService.jsp
public class AddServiceServlet extends HttpServlet {

    private static final String SERVICES_FILE = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/services.txt"; // Path to services.txt

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleID = request.getParameter("vehicleID");
        String serviceDate = request.getParameter("serviceDate");
        String serviceType = request.getParameter("serviceType");
        double cost = Double.parseDouble(request.getParameter("cost"));
        int mileage = Integer.parseInt(request.getParameter("mileage"));

        String nextServiceDate = request.getParameter("nextServiceDate");
        String nextServiceMileage = request.getParameter("nextServiceMileage");

        // Append new service record to services.txt
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(SERVICES_FILE, true))) {
            writer.write(vehicleID + "," + serviceDate + "," + serviceType + "," + cost + "," + mileage);
            writer.newLine();
        }

        // Store reminder if set
        if ((nextServiceDate != null && !nextServiceDate.isEmpty()) || (nextServiceMileage != null && !nextServiceMileage.isEmpty())) {
            try (BufferedWriter reminderWriter = new BufferedWriter(new FileWriter("/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/reminders.txt", true))) {
                reminderWriter.write(vehicleID + "," + (nextServiceDate.isEmpty() ? "N/A" : nextServiceDate) + "," + (nextServiceMileage.isEmpty() ? "N/A" : nextServiceMileage));
                reminderWriter.newLine();
            }
        }

        // Redirect to view service records
        response.sendRedirect("viewService.jsp?success=Service added successfully");
    }
}
