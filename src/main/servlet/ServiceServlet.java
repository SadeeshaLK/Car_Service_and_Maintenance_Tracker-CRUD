package servlet;


import model.ServiceHistory;
import model.ServiceRecord;

import java.io.IOException;
import java.text.ParseException;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedList;
import java.io.FileWriter;
import java.io.BufferedWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ServiceServlet")
public class ServiceServlet extends HttpServlet {
    private static final String FILE_PATH = "services.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleID = request.getParameter("vehicleID");
        String serviceDate = request.getParameter("serviceDate");
        String serviceType = request.getParameter("serviceType");
        double cost = Double.parseDouble(request.getParameter("cost"));
        int mileage = Integer.parseInt(request.getParameter("mileage"));

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(vehicleID + "," + serviceDate + "," + serviceType + "," + cost + "," + mileage);
            writer.newLine();
        }

        response.sendRedirect("viewService.jsp");
    }
}