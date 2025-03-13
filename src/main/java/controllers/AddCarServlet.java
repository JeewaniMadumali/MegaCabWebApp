package controllers;

import models.Car;
import service.CarService;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/AddCarServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, 
    maxFileSize = 1024 * 1024 * 10, 
    maxRequestSize = 1024 * 1024 * 50 
)
public class AddCarServlet extends HttpServlet {
    private CarService carService = new CarService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    String carName = request.getParameter("carName");
    String category = request.getParameter("category");
    double price = 0.0;

    // Validate and parse price
    try {
        String priceStr = request.getParameter("price");
        if (priceStr == null || priceStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Price cannot be empty.");
        }
        price = Double.parseDouble(priceStr);
        if (price <= 0) {
            throw new IllegalArgumentException("Price must be greater than zero.");
        }
    } catch (Exception e) {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<script>alert('" + e.getMessage() + "'); window.location.href='addCar.jsp';</script>");
        return; 
    }

    // Handle file upload
    Part filePart = request.getPart("carImage");
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    String filePath;

    // Use a relative path instead of an absolute path
    String uploadPath = getServletContext().getRealPath("/uploads");

    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs(); // Create the directory if it doesn't exist
    }

    if (fileName != null && !fileName.isEmpty()) {
        // Generate a unique file name to avoid overwriting existing files
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
        filePath = "uploads" + File.separator + uniqueFileName;
        String fullFilePath = uploadPath + File.separator + uniqueFileName;

        // Debugging: Print the full file path
        System.out.println("Full file path: " + fullFilePath);

        // Write the file using InputStream
        try (InputStream fileContent = filePart.getInputStream();
             FileOutputStream fos = new FileOutputStream(fullFilePath)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
        }
    } else {
        // Use a default image if no file is uploaded
        filePath = "uploads" + File.separator + "default.jpg"; 
    }

    // Create a new Car object and add it to the database
    Car car = new Car(0, carName, price, category, true, filePath);
    boolean isAdded = carService.addCar(car);

    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    if (isAdded) {
        response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp"); 
        out.println("<script>alert('Car added successfully!');</script>");
    } else {
        out.println("<script>alert('Failed to add car. Try again.'); window.location.href='addCar.jsp';</script>");
    }
}
    
}