# Invoice Generator

Invoice Generator is a Flutter application designed to streamline the process of creating and managing invoices. The app allows users to input company, client, and product details, and then generates a PDF invoice that can be shared or printed.

## Features

- Add company details, customer information, and product list.
- Automatically calculate totals, including an 18% GST.
- Generate and preview PDF invoices.

## Screenshots

### 1. Invoice Page
<img src="https://github.com/user-attachments/assets/cf957e25-a8d3-49d3-87de-19f35f5ee3e4" width="300">
- **Description:** The main screen where the user inputs invoice-related details such as invoice number, customer name, and invoice date. Users can also upload a company logo or photo, and add products to the invoice.
- **Features:**
  - Upload company photo/logo.
  - Input Invoice Number, Customer Name, and Invoice Date.
  - Add multiple products to the invoice.
  - Submit the details and generate the invoice PDF.

### 2. PDF Page
<img src="https://github.com/user-attachments/assets/00bb5bf0-b4bb-4874-86a8-eeb8008bbd73" width="300">

- **Description:** After filling in all the details, 
users are redirected to this page to preview the generated PDF invoice. The PDF includes all the entered details and calculates the total with GST.
- **Features:**
  - Preview the generated invoice PDF.
  - Invoice includes product details, GST, and the final total.
  - Options to save, share, or print the invoice.

### 3. Customer Details Page
<img src="https://github.com/user-attachments/assets/76685ca0-d702-4c3f-a09c-e231d88d9045" width="300">

- **Description:** This page captures the customer's details such as name and contact information.
- **Features:**
  - Input fields for Customer Name and Contact Number.
  - Save customer details to be used in the invoice.

### 4. Company Details Page
<img src="https://github.com/user-attachments/assets/6a057f0c-d1f7-4b31-b52b-81362c2a1a18" width="300">

- **Description:** Allows users to enter their company details, including the company name, address, and contact information.
- **Features:**
  - Input fields for company-specific information.
  - Save details for use in invoices.

### 5. Product Page
<img src="https://github.com/user-attachments/assets/6ce144e6-9c15-441d-b775-9f30275eb94f" width="300">

- **Description:** A page where users can add, edit, and manage products that will be included in the invoice.
- **Features:**
  - Add product name, price, and quantity.
  - Display a list of added products.
  - Edit or delete products from the list.

## How to Use

1. **Start by entering the company details** on the Company Details Page.
2. **Move to the Customer Details Page** to input client information.
3. **Add products** via the Product Page, including names, prices, and quantities.
4. **Fill in the Invoice Page** with the relevant invoice details such as the invoice number and date.
5. **Submit the form** to generate the PDF.
6. **Preview the generated invoice** on the PDF Page, and save or share it as needed.

## Technologies Used

- **Flutter**: For building the cross-platform app.
- **Dart**: The programming language used for Flutter.
- **pdf**: Flutter package for generating PDFs.
- **intl**: Flutter package for date formatting.

## Getting Started

To run this project locally:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/invoice-generator.git
