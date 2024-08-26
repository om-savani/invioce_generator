import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../routes/all_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      Duration(seconds: 3),
      (timer) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.homepage);
        timer.cancel();
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: kIsWeb
              ? Image.network("lib/assets/gif/")
              : Image.asset("lib/assets/gif/")),
    );
  }
}
