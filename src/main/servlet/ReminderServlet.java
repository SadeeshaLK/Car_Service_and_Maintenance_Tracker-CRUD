package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/ReminderServlet")
public class ReminderServlet extends HttpServlet {

    private static final String REMINDERS_FILE = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/reminders.txt"; // Store reminders

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleID = request.getParameter("vehicleID");
        String nextServiceDate = request.getParameter("nextServiceDate");
        String nextServiceMileage = request.getParameter("nextServiceMileage");

        if ((nextServiceDate == null || nextServiceDate.isEmpty()) && (nextServiceMileage == null || nextServiceMileage.isEmpty())) {
            response.sendRedirect("index.jsp?error=No reminder set.");
            return;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(REMINDERS_FILE, true))) {
            writer.write(vehicleID + "," + nextServiceDate + "," + nextServiceMileage);
            writer.newLine();
        }

        response.sendRedirect("index.jsp?success=Reminder set successfully.");
    }
}
