package utils;

import model.ServiceRecord;
import java.util.List;

public class ServiceSorter {
    public static void selectionSort(List<ServiceRecord> records) {
        int n = records.size();
        for (int i = 0; i < n - 1; i++) {
            int minIndex = i;
            for (int j = i + 1; j < n; j++) {
                if (records.get(j).getServiceDate().before(records.get(minIndex).getServiceDate())) {
                    minIndex = j;
                }
            }
            ServiceRecord temp = records.get(minIndex);
            records.set(minIndex, records.get(i));
            records.set(i, temp);
        }
    }
}