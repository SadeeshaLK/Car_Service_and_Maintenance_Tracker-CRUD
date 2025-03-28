package model;

import java.io.*;
import java.util.LinkedList;
import java.util.List;

public class ServiceHistory {
    private LinkedList<ServiceRecord> records = new LinkedList<>();
    private static final String FILE_PATH = "/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/services.txt";

    public void addService(ServiceRecord record) throws IOException {
        records.add(record);
        saveToFile();
    }


    public void saveToFile() throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH));
        for (ServiceRecord record : records) {
            writer.write(record.toString());
            writer.newLine();
        }
        writer.close();
    }

    public void loadFromFile() throws Exception {
        BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH));
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            ServiceRecord record = new ServiceRecord(parts[0], parts[1], parts[2], Double.parseDouble(parts[3]), Integer.parseInt(parts[4]));
            records.add(record);
        }
        reader.close();
    }

    public List<ServiceRecord> getAllRecords() {
        return records;
    }
}