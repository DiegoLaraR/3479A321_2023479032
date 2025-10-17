import 'package:flutter/material.dart';
import 'package:lab2/pages/configuration.dart';
import 'package:lab2/providers/configuration_data.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

class PixelArtScreen extends StatefulWidget {
  const PixelArtScreen({super.key});
  @override
  _PixelArtScreenState createState() => _PixelArtScreenState();
}

class _PixelArtScreenState extends State<PixelArtScreen> {
  Logger logger = Logger();
  int _sizeGrid = 16;
  Color _selectedColor = Colors.black;

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

  //Cambios de codigo original
  // Ya no se inicializa aquí porque depende de _sizeGrid
  late List<Color> _cellColors;

  @override
  void initState() {
    super.initState();
    // Initialization code here
    logger.d("PixelArtScreen initialized. Mounted: $mounted");
    _sizeGrid = context.read<ConfigurationData>().getSize;

    //Cambios de codigo original
    // Se inicaliza _cellColors aquí para asegurar que usa el valor correcto de _sizeGrid
    _cellColors = List<Color>.generate(
      _sizeGrid * _sizeGrid,
      (index) => Colors.transparent,
    );

    logger.d("Grid size set to: $_sizeGrid");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Code to handle changes in dependencies
    _sizeGrid = context.watch<ConfigurationData>().getSize;

    //Cambios de codigo original
    // Se ajusta _cellColors si cambia el tamaño de la cuadrícula
    final newSize = context.watch<ConfigurationData>().getSize;
    if (newSize != _sizeGrid) {
      final old = _cellColors;
      final newLen = newSize * newSize;
      final newList = List<Color>.filled(newLen, Colors.transparent);
      final copyLen = (old.length < newLen) ? old.length : newLen;
      for (var i = 0; i < copyLen; i++) {
        newList[i] = old[i];
      }
      setState(() {
        _sizeGrid = newSize;
        _cellColors = newList;
      });
    }

    logger.d("Dependencies changed in PixelArtScreen. Mounted: $mounted");
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation Process'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                      logger.d('Button pressed');
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            // GridView above the footer
            Expanded(
              child: GridView.builder(
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
          ],
        ),
      ),
    );
  }
}
