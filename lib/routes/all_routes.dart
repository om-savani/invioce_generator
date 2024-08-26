import 'package:flutter/material.dart';
import '../views/home_page/homepage.dart';
import '../views/pdf_page/pdfpage.dart';
import '../views/splashscreen/splash_screen.dart';

class AppRoutes {
  static String splashscreen = "/";
  static String homepage = "HomePage";
  static String invoicePage = "InvoiceOptionPage";
  static String pdfPage = "PdfPage";

  static Map<String, Widget Function(BuildContext)> routes = {
    splashscreen: (context) => SplashScreen(),
    homepage: (context) => const Homepage(),
    pdfPage: (context) => const PdfPage(),
  };
}
