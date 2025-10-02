import 'package:flutter/material.dart';

class About extends StatelessWidget {
  final Color color;
  final Color colorText;

  const About({super.key, required this.color, required this.colorText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: color,
        foregroundColor: colorText,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            children: [
              Spacer(),
              SizedBox(
                width: 150,
                height: 70,
                child: Card(
                  child: Center(
                    child: Text(
                      "Diego Lara",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(150, 50),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text("Volver"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
