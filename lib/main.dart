import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _color = Colors.blue; // color inicial

  void _updateColor(Color newColor) {
    setState(() {
      _color = newColor;
    });
  }

  Widget build(BuildContext context) {
    var logger = Logger();

    logger.d("Logger is working!");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2023479032',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _color),
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

      home: MyHomePage(title: '2023479032', onChangeColor: _updateColor),
    );
  }
}
