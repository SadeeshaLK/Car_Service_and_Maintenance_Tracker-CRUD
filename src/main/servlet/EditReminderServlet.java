package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/EditReminderServlet")
public class EditReminderServlet extends HttpServlet {

    private static final String FILE_PATH = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/reminders.txt";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleID = request.getParameter("vehicleID");

        BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH));
        String line;
        String reminderToEdit = null;

        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts[0].equals(vehicleID)) {
                reminderToEdit = line;
                break;
            }
        }
        reader.close();

        if (reminderToEdit != null) {
            request.setAttribute("reminderToEdit", reminderToEdit);
            request.getRequestDispatcher("editReminder.jsp").forward(request, response);
        } else {
            response.sendRedirect("manageServiceReminders.jsp?error=Reminder not found");
        }
    }
}
