import 'package:flutter/material.dart';
import 'package:lab2/providers/configuration_data.dart';
import 'pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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

    return ChangeNotifierProvider<ConfigurationData>(
      create: (context) => ConfigurationData(),
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(
          title: 'Flutter Demo Home Page',
          onChangeColor: _updateColor,
        ),
      ),
    );
  }
}
