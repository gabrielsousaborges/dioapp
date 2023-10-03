import 'package:dioapp/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        textTheme: GoogleFonts.chakraPetchTextTheme(),
      ),
    );
  }
}
