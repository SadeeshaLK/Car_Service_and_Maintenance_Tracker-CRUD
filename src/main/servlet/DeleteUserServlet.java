package servlet;

import java.util.List;
import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final String FILE_PATH = "users.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameToDelete = request.getParameter("username");
        List<String> users = new ArrayList<>();

        BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH));
        String line;
        while ((line = reader.readLine()) != null) {
            if (!line.startsWith(usernameToDelete + ",")) {
                users.add(line);
            }
        }
        reader.close();

        BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH));
        for (String user : users) {
            writer.write(user);
            writer.newLine();
        }
        writer.close();

        response.sendRedirect("manageUsers.jsp");
    }
}
