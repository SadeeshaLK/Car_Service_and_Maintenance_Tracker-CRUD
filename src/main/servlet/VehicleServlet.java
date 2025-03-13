package servlet;

import model.Vehicle;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.*;

@WebServlet("/VehicleServlet")
public class VehicleServlet extends HttpServlet {
    private static final String FILE_PATH = "vehicles.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleID = request.getParameter("vehicleID");
        String owner = request.getParameter("owner");
        String model = request.getParameter("model");
        int year = Integer.parseInt(request.getParameter("year"));

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(vehicleID + "," + owner + "," + model + "," + year);
            writer.newLine();
        }

        response.sendRedirect("viewVehicles.jsp");
    }
}