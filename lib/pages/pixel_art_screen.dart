import 'dart:io';
import 'dart:ui' as ui;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab2/pages/configuration.dart';
import 'package:lab2/providers/configuration_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:image_picker/image_picker.dart';

class PixelArtScreen extends StatefulWidget {
  const PixelArtScreen({super.key});
  @override
  _PixelArtScreenState createState() => _PixelArtScreenState();
}

class _PixelArtScreenState extends State<PixelArtScreen> {
  Logger logger = Logger();
  int _sizeGrid = 16;
  Color _selectedColor = Colors.black;
  File? _backgroundImage;
  double _backgroundOpacity = 0.5;

  // Cambios agregados por IA
  bool _showNumbers = true;

  final List<Color> _listColors = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.brown,
    Colors.grey,
    Colors.pink,
  ];

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/background_image.png';
      // Save the new image and delete the old one if it exists
      final newImage = File(pickedFile.path);
      if (_backgroundImage != null && _backgroundImage!.existsSync()) {
        _backgroundImage!.deleteSync();
      }
      newImage.copySync(filePath);
      setState(() {
        _backgroundImage = File(filePath);
      });
    }
  }

  void _deleteBackgroundImage() {
    if (_backgroundImage != null && _backgroundImage!.existsSync()) {
      _backgroundImage!.deleteSync();
    }
    setState(() {
      _backgroundImage = null;
    });
  }

  //Cambios de codigo original
  // Ya no se inicializa aquí porque depende de _sizeGrid
  late List<Color> _cellColors;

  @override
  void initState() {
    super.initState();
    // Initialization code here
    logger.d("PixelArtScreen initialized. Mounted: $mounted");
    _sizeGrid = context.read<ConfigurationData>().getSize;
    _backgroundOpacity = context.read<ConfigurationData>().getOpacity;

    //Cambios de codigo original
    // Se inicaliza _cellColors aquí para asegurar que usa el valor correcto de _sizeGrid
    _cellColors = List<Color>.generate(
      _sizeGrid * _sizeGrid,
      (index) => Colors.transparent,
    );

    logger.d("Grid size set to: $_sizeGrid");
  }

  // Cargar PixelArt
  Future<void> _savePixelArt() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromLTWH(0, 0, _sizeGrid * 20.0, _sizeGrid * 20.0),
    );
    for (int row = 0; row < _sizeGrid; row++) {
      for (int col = 0; col < _sizeGrid; col++) {
        final color = _cellColors[row * _sizeGrid + col];
        final paint = Paint()..color = color;
        final rect = Rect.fromLTWH(col * 20.0, row * 20.0, 20.0, 20.0);
        canvas.drawRect(rect, paint);
      }
    }
    final picture = recorder.endRecording();
    final image = await picture.toImage(_sizeGrid * 20, _sizeGrid * 20);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final imageBytes = byteData!.buffer.asUint8List();
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/pixel_art_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File(filePath);
    await file.writeAsBytes(imageBytes);
    logger.d("Pixel art saved to: $filePath");
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Pixel art saved to: $filePath')));
    }

    if (mounted) {
      Navigator.pop(context, filePath);
    }
  }

  @override
  void didUpdateWidget(covariant PixelArtScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Code to handle widget updates
    logger.d("PixelArtScreen widget updated. Mounted: $mounted");
  }

  @override
  void deactivate() {
    // Code to handle deactivation
    super.deactivate();
    logger.d("PixelArtScreen deactivated. Mounted: $mounted");
  }

  @override
  void dispose() {
    // Cleanup code here
    super.dispose();
    logger.d("PixelArtScreen disposed. Mounted: $mounted");
  }

  @override
  void reassemble() {
    super.reassemble();
    // Code to handle hot reload
    logger.d("PixelArtScreen reassembled. Mounted: $mounted");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Code to handle changes in dependencies
    _sizeGrid = context.watch<ConfigurationData>().getSize;
    _backgroundOpacity = context.watch<ConfigurationData>().getOpacity;

    //Cambios de codigo original
    // Se ajusta _cellColors si cambia el tamaño de la cuadrícula
    // final newSize = context.watch<ConfigurationData>().getSize;
    // if (newSize != _sizeGrid) {
    //   final old = _cellColors;
    //   final newLen = newSize * newSize;
    //   final newList = List<Color>.filled(newLen, Colors.transparent);
    //   final copyLen = (old.length < newLen) ? old.length : newLen;
    //   for (var i = 0; i < copyLen; i++) {
    //     newList[i] = old[i];
    //   }
    //   setState(() {
    //     _sizeGrid = newSize;
    //     _cellColors = newList;
    //   });
    // }

    logger.d("Dependencies changed in PixelArtScreen. Mounted: $mounted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation Process'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // CAMBIOS AGREGADOS POR IA
              // Save Progress Button
              IconButton(
                onPressed: () async {
                  final title = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Save Progress'),
                      content: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter a title for your work in progress',
                        ),
                        onSubmitted: (value) =>
                            Navigator.of(context).pop(value),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(
                            'Untitled ${DateTime.now().toString().split(' ')[0]}',
                          ),
                          child: const Text('Save without title'),
                        ),
                      ],
                    ),
                  );

                  if (title != null) {
                    await context
                        .read<ConfigurationData>()
                        .savePixelArtProgress(_cellColors, _sizeGrid, title);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Progress saved as: $title')),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.save_outlined),
                tooltip: 'Save Progress',
              ),

              // Load Progress Button
              IconButton(
                onPressed: () async {
                  final pixelArt = await context
                      .read<ConfigurationData>()
                      .loadPixelArtProgress();
                  if (pixelArt != null) {
                    final List<dynamic> rawColorData = jsonDecode(
                      pixelArt.gridData,
                    );
                    final List<String> colorData = rawColorData
                        .map((e) => e.toString())
                        .toList();
                    setState(() {
                      _cellColors = colorData
                          .map((str) => Color(int.parse(str)))
                          .toList();
                      _sizeGrid = pixelArt.size['width'] as int;
                    });
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Loaded: ${pixelArt.title}')),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.refresh),
                tooltip: 'Load Progress',
              ),

              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Configuration()),
                ),
                icon: Icon(Icons.settings),
              ),

              // Cambios agregados por IA
              IconButton(
                icon: Icon(
                  _showNumbers ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => setState(() => _showNumbers = !_showNumbers),
              ),
            ],
          ),
        ],
      ),

      body: SafeArea(
        // Wrap the Column with SafeArea
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$_sizeGrid x $_sizeGrid'),
                  SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter title',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (value) {
                          logger.d('Title entered: $value');
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _savePixelArt();
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            // GridView above the footer
            Expanded(
              child: Stack(
                children: [
                  if (_backgroundImage != null)
                    Opacity(
                      opacity: _backgroundOpacity,
                      child: Image.file(
                        _backgroundImage!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _sizeGrid,
                    ),

                    //Cambios de codigo original
                    // Ahora en el item count se utiliza _cellColors que se inicializa en initState, en vez de _sizeGrid * _sizeGrid
                    itemCount: _cellColors.length,
                    itemBuilder: (context, index) {
                      // Cambios por IA
                      // Si el index es menor que la longitud de _cellColors, usa ese color, si no usa transparente
                      final color = (index < _cellColors.length)
                          ? _cellColors[index]
                          : Colors.transparent;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _cellColors[index] = _selectedColor;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(1),
                          color: color,
                          child: Center(
                            // Cambios agregados por IA
                            // Prgunta si debe mostrar el numero o no basandose en _showNumbers
                            child: _showNumbers
                                ? Text(
                                    '$index',
                                    style: TextStyle(
                                      color: color == Colors.black
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Footer with selectable colors
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.grey[200],
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _listColors.map((color) {
                    final bool isSelected = color == _selectedColor;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: EdgeInsets.all(isSelected ? 12 : 8),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(color: Colors.black, width: 2)
                              : null,
                        ),
                        width: isSelected ? 36 : 28,
                        height: isSelected ? 36 : 28,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Tomar captura
                ElevatedButton(
                  onPressed: _takePicture,
                  child: Icon(Icons.camera_alt),
                ),
                // Eliminar imagen de fondo
                if (_backgroundImage != null)
                  ElevatedButton.icon(
                    onPressed: _deleteBackgroundImage,
                    icon: Icon(Icons.delete),
                    label: Text('Eliminar'),
                  ),

                // Cambiar oopacidad
                if (_backgroundImage != null)
                  Column(
                    children: [
                      Text('Ajustar Opacidad'),
                      Slider(
                        value: _backgroundOpacity,
                        min: 0.1,

                        max: 1.0,
                        divisions: 10,
                        label: '${(_backgroundOpacity * 100).toInt()}%',
                        onChanged: (value) {
                          setState(() {
                            _backgroundOpacity = value;
                            context
                                .read<ConfigurationData>()
                                .setBackgroundOpacity(value);
                          });
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
