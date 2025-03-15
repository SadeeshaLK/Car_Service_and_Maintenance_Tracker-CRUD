package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/UpdateReminderServlet")  // Ensure this matches the form action in editReminder.jsp
public class UpdateReminderServlet extends HttpServlet {

    private static final String REMINDERS_FILE = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/reminders.txt"; // Ensure the correct file path

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleID = request.getParameter("vehicleID");
        String newServiceDate = request.getParameter("nextServiceDate");
        String newServiceMileage = request.getParameter("nextServiceMileage");

        // Read all reminders from file
        File file = new File(REMINDERS_FILE);
        List<String> lines = new ArrayList<>();
        boolean reminderFound = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts[0].equals(vehicleID)) {
                    // Update the reminder record
                    lines.add(vehicleID + "," + (newServiceDate.isEmpty() ? "N/A" : newServiceDate) + "," + (newServiceMileage.isEmpty() ? "N/A" : newServiceMileage));
                    reminderFound = true;
                } else {
                    lines.add(line);
                }
            }
        }

        if (!reminderFound) {
            response.sendRedirect("manageServiceReminders.jsp?error=Reminder not found");
            return;
        }

        // Write the updated reminders back to file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String updatedLine : lines) {
                writer.write(updatedLine);
                writer.newLine();
            }
        }

        response.sendRedirect("manageServiceReminders.jsp?success=Reminder updated successfully");
    }
}
