import 'package:flutter/material.dart';
import 'package:lab2/pages/configuration.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:lab2/providers/configuration_data.dart';

class PixelArtScreen extends StatefulWidget {
  const PixelArtScreen({super.key});

  @override
  State<PixelArtScreen> createState() => _PixelArtScreenState();
}

class _PixelArtScreenState extends State<PixelArtScreen> {
  var logger = Logger();
  @override
  void initState() {
    super.initState();
    logger.d('Initializando PixelArtScreen');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sizeGrid = context.read<ConfigurationData>().getSize;

    logger.d('Tamaño de Grid: $sizeGrid');
    logger.d("PixelArtScreen dependencias cambiadas");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    logger.d("PixelArtScreen setState llamado");
  }

  @override
  void didUpdateWidget(covariant PixelArtScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    logger.d("PixelArtScreen didUpdateWidget llamado");
    logger.d("Tamaño de grid: ${context.read<ConfigurationData>().getSize}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pixel Art Screen'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Text('Pixel Art Screen Content'),
            Text(
              "Tamaño del SizeGrid: ${context.watch<ConfigurationData>().getSize}",
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Configuration()),
            );
          },
          child: const Text('config'),
        ),
      ],
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    logger.d("PixelArtScreen desactivado");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    logger.d("PixelArtScreen dispuesto");
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    logger.d("PixelArtScreen reassembled");
  }
}
