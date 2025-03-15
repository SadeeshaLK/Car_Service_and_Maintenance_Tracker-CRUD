package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/DeleteReminderServlet")
public class DeleteReminderServlet extends HttpServlet {

    private static final String REMINDERS_FILE = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/reminders.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleIDToDelete = request.getParameter("vehicleID");

        List<String> reminders = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(REMINDERS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.startsWith(vehicleIDToDelete + ",")) {
                    reminders.add(line);
                }
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(REMINDERS_FILE))) {
            for (String updatedLine : reminders) {
                writer.write(updatedLine);
                writer.newLine();
            }
        }

        response.sendRedirect("manageServiceReminders.jsp?success=Reminder deleted successfully");
    }
}
