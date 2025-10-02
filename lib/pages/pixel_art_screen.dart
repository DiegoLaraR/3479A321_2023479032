import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
    logger.d("PixelArtScreen Inicializado");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pixel Art Screen'), centerTitle: true),
      body: const Center(child: Text('Pixel Art Screen Content')),
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
