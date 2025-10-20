import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ListCreation extends StatefulWidget {
  final Color color;
  final Color colorText;
  const ListCreation({super.key, required this.color, required this.colorText});

  @override
  State<ListCreation> createState() => _ListCreationState();
}

class _ListCreationState extends State<ListCreation> {
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      final imgDir = await getApplicationDocumentsDirectory();
      final List<File> images = [];

      final imagesList = imgDir.listSync();

      for (var img in imagesList) {
        if (img is File) {
          final path = img.path.toLowerCase();
          if (path.endsWith(".png")) {
            images.add(img);
          }
        }
      }

      setState(() => _images = images);
    } catch (_) {
      setState(() => _images = []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ya creadas'),
        centerTitle: true,
        backgroundColor: widget.color,
        foregroundColor: widget.colorText,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          final file = _images[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  file,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(file.uri.pathSegments.last),
              onTap: () {
                Navigator.pop(context, file.path);
              },
            ),
          );
        },
      ),
    );
  }
}
