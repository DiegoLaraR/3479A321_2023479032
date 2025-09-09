import 'package:flutter/material.dart';

class ListCreation extends StatelessWidget {
  final Color color;
  final Color colorText;

  const ListCreation({super.key, required this.color, required this.colorText});

  final List<String> creaciones = const ['Pizza', 'Sandia', 'Aji'];
  final List<String> imagenes = const [
    "assets/pizza.webp",
    "assets/sandia.webp",
    "assets/aji.webp",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ya creadas'),
        centerTitle: true,
        backgroundColor: color,
        foregroundColor: colorText,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        itemCount: creaciones.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(Icons.landscape),
              title: Text(creaciones[index]),
              onTap: () {
                Navigator.pop(context, imagenes[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
