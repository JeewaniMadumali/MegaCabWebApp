<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Car</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Custom styles */
            .container {
                max-width: 600px;
            }
            .error-message {
                color: red;
                font-size: 0.9em;
            }
        </style>
    </head>
    <body>
        <%@ include file="/admin/layout/adminNav.jsp" %>
        <div class="container mt-5">
            <h2 class="text-center">Add New Cab</h2>
            <form action="${pageContext.request.contextPath}/AddCarServlet" method="POST" enctype="multipart/form-data" class="mt-4" novalidate>
                <!-- Car Name -->
                <div class="mb-3">
                    <label for="carName" class="form-label">Cab Name:</label>
                    <input type="text" id="carName" name="carName" class="form-control" required>
                    <div class="invalid-feedback">Please enter the cab name.</div>
                </div>
                <!-- Category -->
                <div class="mb-3">
                    <label for="category" class="form-label">Category:</label>
                    <select id="category" name="category" class="form-select" required>
                        <option value="">Select Category</option>
                        <option value="Sedan">Tuk Tuk</option>
                        <option value="SUV">Car</option>
                        <option value="Truck">MiniVan</option>
                        <option value="Coupe">Van</option>
                    </select>
                    <div class="invalid-feedback">Please select a category.</div>
                </div>
                <!-- Price -->
                <div class="mb-3">
                    <label for="price" class="form-label">Price (LKR):</label>
                    <input type="number" id="price" name="price" class="form-control" min="0" step="0.01" required>
                    <div class="invalid-feedback">Please enter a valid price (minimum LKR0).</div>
                </div>
                <!-- Image Upload -->
                <div class="mb-3">
                    <label for="carImage" class="form-label">Upload Image:</label>
                    <input type="file" id="carImage" name="carImage" class="form-control" accept="image/*">
                    <div class="text-muted small">Only image files (JPEG, PNG, etc.) are allowed.</div>
                </div>
                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary">Add Cab</button>
            </form>
        </div>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Form Validation Script -->
        <script>
            // Enable Bootstrap form validation
            (() => {
                'use strict';
                const forms = document.querySelectorAll('.needs-validation');
                Array.from(forms).forEach(form => {
                    form.addEventListener('submit', event => {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            })();
        </script>
    </body>
</html>