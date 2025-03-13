package models;



public class Car {
    private int id;
    private String name;
    private String category;
    private double price;
    private boolean isAvailable;
    private String image;

    
    public Car() {
        
    }

    public Car(int id, String name,double price, String category, boolean isAvailable, String image) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
        this.isAvailable = isAvailable;
        this.image = image;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }
    
     public double getPrice() {
        return price;
    }

    public String getCategory() {
        return category;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public String getImage() {
        return image;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }
    public void setPrice(double price) {
        this.price = price;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Car{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", category='" + category + '\'' +
                ", price=" + price +
                ", isAvailable=" + isAvailable +
                ", image='" + image + '\'' +
                '}';
    }
}
