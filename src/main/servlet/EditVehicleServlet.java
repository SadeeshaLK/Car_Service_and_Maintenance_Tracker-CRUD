package servlet;

import jakarta.servlet.*;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Vehicle;

import java.io.*;
import java.util.*;

@WebServlet("/EditVehicleServlet")
public class EditVehicleServlet extends HttpServlet {

    private static final String FILE_PATH = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/vehicles.txt";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleID = request.getParameter("vehicleID");

        BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH));
        String line;
        Vehicle vehicleToEdit = null;

        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts[0].equals(vehicleID)) {
                vehicleToEdit = new Vehicle(parts[0], parts[1], parts[2], Integer.parseInt(parts[3]));
                break;
            }
        }
        reader.close();

        if (vehicleToEdit != null) {
            request.setAttribute("vehicleToEdit", vehicleToEdit);
            request.getRequestDispatcher("updateVehicle.jsp").forward(request, response);
        } else {
            response.sendRedirect("manageVehicles.jsp?error=Vehicle not found");
        }
    }
}
