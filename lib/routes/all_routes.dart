import 'package:flutter/material.dart';
import 'package:invloce_generator/views/invoice_page/options/product_page/product_page.dart';
import '../views/company_data_page/company_data_page.dart';
import '../views/home_page/homepage.dart';
import '../views/invoice_page/options/client_data/client_data_page.dart';
import '../views/invoice_page/options/pdf_page/pdfpage.dart';

class AppRoutes {
  // static String splashscreen = "/";
  static String homepage = "/";
  static String pdfPage = "PdfPage";
  static String clientData = "ClientDataPage";
  static String companyData = "CompanyDataPage";
  static String productdata = "ProductDataPage";

  static Map<String, Widget Function(BuildContext)> routes = {
    // splashscreen: (context) => SplashScreen(),
    homepage: (context) => const Homepage(),
    clientData: (context) => const ClientDataPage(),
    pdfPage: (context) => const PdfPage(),
    companyData: (context) => const CompanyDataPage(),
    productdata: (context) => const ProductPage(),
  };
}
