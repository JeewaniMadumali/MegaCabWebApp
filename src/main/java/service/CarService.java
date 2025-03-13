package service;

import db.DBConnection;
import models.Car;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CarService {


    public List<Car> getAllCars() {
        List<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM cars";  
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Car car = new Car();
                car.setId(rs.getInt("id"));
                car.setName(rs.getString("name"));
                 car.setPrice(rs.getDouble("price"));
                car.setCategory(rs.getString("category"));
                car.setAvailable(rs.getBoolean("is_available"));
                car.setImage(rs.getString("image"));
                cars.add(car);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cars;
    }

    // Get a car by ID
    public Car getCarById(int id) {
        String query = "SELECT * FROM cars WHERE id = ?";
        Car car = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    car = new Car();
                    car.setId(rs.getInt("id"));
                    car.setName(rs.getString("name"));
                    car.setCategory(rs.getString("category"));
                    car.setAvailable(rs.getBoolean("is_available"));
                    car.setImage(rs.getString("image"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return car;
    }

    // Update a car
    public boolean updateCar(Car car) {
        String query = "UPDATE cars SET name = ?, category = ?, is_available = ?, image = ? WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, car.getName());
            ps.setString(2, car.getCategory());
            ps.setBoolean(3, car.isAvailable());
            ps.setString(4, car.getImage());
            ps.setInt(5, car.getId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


   public boolean addCar(Car car) {
    String query = "INSERT INTO cars (name, category, price, is_available, image) VALUES (?, ?, ?, ?, ?)";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(query)) {

        ps.setString(1, car.getName());
        ps.setString(2, car.getCategory());
        ps.setDouble(3, car.getPrice());
        ps.setBoolean(4, car.isAvailable());
        ps.setString(5, car.getImage());

        int rowsInserted = ps.executeUpdate();
        return rowsInserted > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}


    // Delete a car
    public boolean deleteCar(int id) {
        String query = "DELETE FROM cars WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, id);

            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
