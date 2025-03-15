package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

import model.ServiceRecord;

@WebServlet("/EditServiceServlet")
public class EditServiceServlet extends HttpServlet {

    private static final String FILE_PATH = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/services.txt"; // Ensure this is the correct path

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleID = request.getParameter("vehicleID");
        String serviceDate = request.getParameter("serviceDate");

        BufferedReader reader = null;
        ServiceRecord recordToEdit = null;

        try {
            reader = new BufferedReader(new FileReader(FILE_PATH));
            String line;

            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5 && parts[0].equals(vehicleID) && parts[1].equals(serviceDate)) {
                    recordToEdit = new ServiceRecord(parts[0], parts[1], parts[2], Double.parseDouble(parts[3]), Integer.parseInt(parts[4]));
                    break;
                }
            }

        } catch (Exception e) {  // Catch Exception properly
            e.printStackTrace();  // Print the error for debugging
            response.sendRedirect("manageServices.jsp?error=Error loading service record");
            return;
        } finally {
            if (reader != null) {
                reader.close();
            }
        }

        if (recordToEdit != null) {
            request.setAttribute("recordToEdit", recordToEdit);
            request.getRequestDispatcher("editService.jsp").forward(request, response);
        } else {
            response.sendRedirect("manageServices.jsp?error=Service record not found");
        }
    }
}
