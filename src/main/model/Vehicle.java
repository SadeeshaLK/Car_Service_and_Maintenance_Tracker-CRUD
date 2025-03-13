package model;

public class Vehicle {
    private String vehicleID;
    private String owner;
    private String model;
    private int year;

    public Vehicle(String vehicleID, String owner, String model, int year) {
        this.vehicleID = vehicleID;
        this.owner = owner;
        this.model = model;
        this.year = year;
    }

    public String getVehicleID() { return vehicleID; }
    public String getOwner() { return owner; }
    public String getModel() { return model; }
    public int getYear() { return year; }

    @Override
    public String toString() {
        return vehicleID + "," + owner + "," + model + "," + year;
    }
}