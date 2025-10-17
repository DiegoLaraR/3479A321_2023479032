import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab2/providers/configuration_data.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  final List<int> sizes = [16, 18, 20, 24, 32];
  final List<String> palettes = [
    'Default',
    'Retro',
    'Grayscale',
    'Vibrant',
    'Pastel',
  ];

  String? selectedPalette;
  int? selectedSize;

  @override
  Widget build(BuildContext context) {
    selectedPalette = selectedPalette == null
        ? context.watch<ConfigurationData>().getPalette
        : "Default";
    selectedSize = selectedSize == null
        ? context.watch<ConfigurationData>().getSize
        : 16;

    return Scaffold(
      appBar: AppBar(title: const Text('Configuracion')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Tamaño del Pixel Art:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<int>(
              initialValue: selectedSize,
              items: [
                for (var e in sizes)
                  DropdownMenuItem(value: e, child: Text('$e px')),
              ],
              onChanged: (value) {
                if (value != null) {
                  context.read<ConfigurationData>().setSize(value);
                }
              },
            ),

            const SizedBox(height: 30),

            const Text(
              'Paleta de Colores:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              initialValue: selectedPalette,
              items: [
                for (var p in palettes)
                  DropdownMenuItem(value: p, child: Text(p)),
              ],

              onChanged: (value) {
                if (value != null) {
                  context.read<ConfigurationData>().setPalette(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
