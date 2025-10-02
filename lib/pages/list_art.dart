import 'package:flutter/material.dart';

final List<String> elementos = ["Hola", "Si", "Nose"];

class ListArt extends StatelessWidget {
  final Color color;
  final Color colorText;

  const ListArt({super.key, required this.color, required this.colorText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pixel art disponible'),
        backgroundColor: color,
        foregroundColor: colorText,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: elementos.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: ListTile(
              leading: Icon(Icons.brush),
              title: Text(elementos[index]),
            ),
          );
        },
      ),
    );
  }
}
