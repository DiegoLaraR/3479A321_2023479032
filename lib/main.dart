import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var logger = Logger();

    logger.d("Logger is working!");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2023479032',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 239, 7, 7),
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.normal,
          ),
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),

      home: const MyHomePage(title: '2023479032'),
    );
  }
}
