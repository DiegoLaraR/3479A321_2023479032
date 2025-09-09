import 'package:flutter/material.dart';
import 'package:lab2/pages/about.dart';
import 'package:lab2/pages/list_art.dart';
import 'package:lab2/pages/list_creation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _color = Colors.blue;
  Color _colorText = Colors.black;
  String selectedImage = "assets/pizza.webp";

  void _changeColor(Color nuevoColor) {
    setState(() {
      _colorText = (nuevoColor.computeLuminance() > 0.5)
          ? Colors.black
          : Colors.white;
      _color = nuevoColor;
    });
  }

  List<Widget> _interactiveButtons() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () async {
                final nuevoColor = await showModalBottomSheet<Color>(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Container(
                      constraints: const BoxConstraints(maxHeight: 500),
                      padding: const EdgeInsets.all(5),
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 3,
                          runSpacing: 3,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.circle, color: Colors.red),
                              onPressed: () =>
                                  Navigator.pop(context, Colors.red),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.circle,
                                color: Colors.green,
                              ),
                              onPressed: () =>
                                  Navigator.pop(context, Colors.green),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.circle,
                                color: Colors.blue,
                              ),
                              onPressed: () =>
                                  Navigator.pop(context, Colors.blue),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.circle,
                                color: Colors.purple,
                              ),
                              onPressed: () =>
                                  Navigator.pop(context, Colors.purple),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.circle,
                                color: Colors.black,
                              ),
                              onPressed: () =>
                                  Navigator.pop(context, Colors.black),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.circle,
                                color: Colors.yellow,
                              ),
                              onPressed: () =>
                                  Navigator.pop(context, Colors.yellow),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.circle,
                                color: Colors.brown,
                              ),
                              onPressed: () =>
                                  Navigator.pop(context, Colors.brown),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.circle,
                                color: Colors.pink,
                              ),
                              onPressed: () =>
                                  Navigator.pop(context, Colors.pink),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.circle,
                                color: Colors.orange,
                              ),
                              onPressed: () =>
                                  Navigator.pop(context, Colors.orange),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 43, 84, 40),
                              ),
                              onPressed: () => Navigator.pop(
                                context,
                                Color.fromARGB(255, 43, 84, 40),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                if (nuevoColor != null) _changeColor(nuevoColor);
              },
              child: const Icon(Icons.color_lens),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        foregroundColor: _colorText,
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          About(color: _color, colorText: _colorText),
                    ),
                  ),
                  icon: Icon(Icons.info),
                  label: Text("About"),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 400,
                  height: 400,
                  child: Image.asset(selectedImage),
                ),

                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 1.0,
                    horizontal: 4.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.rtl,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ListArt(color: _color, colorText: _colorText),
                          ),
                        ),
                        icon: Icon(Icons.brush),
                        label: Text("Crear"),
                      ),

                      TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        icon: Icon(Icons.share),
                        label: Text("Compartir"),

                        onPressed: () {},
                      ),

                      TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          final result = await Navigator.push<String>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListCreation(
                                color: _color,
                                colorText: _colorText,
                              ),
                            ),
                          );
                          if (result != null) {
                            setState(() => selectedImage = result);
                          }
                        },
                        icon: Icon(Icons.landscape),
                        label: Text("Creadas"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      persistentFooterButtons: _interactiveButtons(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
