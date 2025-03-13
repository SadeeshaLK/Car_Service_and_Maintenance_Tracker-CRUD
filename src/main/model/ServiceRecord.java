package model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ServiceRecord {
    private String vehicleID;
    private Date serviceDate;
    private String serviceType;
    private double cost;
    private int mileage;

    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public ServiceRecord(String vehicleID, String serviceDate, String serviceType, double cost, int mileage) throws Exception {
        this.vehicleID = vehicleID;
        this.serviceDate = dateFormat.parse(serviceDate);
        this.serviceType = serviceType;
        this.cost = cost;
        this.mileage = mileage;
    }

    public String getVehicleID() { return vehicleID; }
    public Date getServiceDate() { return serviceDate; }
    public String getServiceType() { return serviceType; }
    public double getCost() { return cost; }
    public int getMileage() { return mileage; }
    public String getServiceDateString() { return dateFormat.format(serviceDate); }

    @Override
    public String toString() {
        return vehicleID + "," + getServiceDateString() + "," + serviceType + "," + cost + "," + mileage;
    }
}