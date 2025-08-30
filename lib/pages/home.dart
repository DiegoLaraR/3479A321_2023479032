import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final int _initialCounter = 0;
  Color _color = Colors.blue;

  void _changeColor(Color nuevoColor) {
    setState(() {
      _color = nuevoColor;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      // This call to setState decrements the counter.
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      // This call to setState resets the counter to zero.
      _counter = _initialCounter;
    });
  }

  List<Widget> _interactiveButtons() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: _incrementCounter,
            child: const Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: _decrementCounter,
            child: const Icon(Icons.remove),
          ),
          ElevatedButton(
            onPressed: _resetCounter,
            child: const Icon(Icons.restart_alt),
          ),
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
                            onPressed: () => Navigator.pop(context, Colors.red),
                          ),
                          IconButton(
                            icon: const Icon(Icons.circle, color: Colors.green),
                            onPressed: () =>
                                Navigator.pop(context, Colors.green),
                          ),
                          IconButton(
                            icon: const Icon(Icons.circle, color: Colors.blue),
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
                            icon: const Icon(Icons.circle, color: Colors.black),
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
                            icon: const Icon(Icons.circle, color: Colors.brown),
                            onPressed: () =>
                                Navigator.pop(context, Colors.brown),
                          ),
                          IconButton(
                            icon: const Icon(Icons.circle, color: Colors.pink),
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: _color, title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Pixel art sobre una grilla personalizable'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/Pixel-Art-Pizza-2.webp',
                      height: 400,
                      width: 400,
                    ),
                    Image.asset(
                      'assets/Pixel-Art-Pizza-2.webp',
                      height: 400,
                      width: 400,
                    ),
                    Image.asset(
                      'assets/Pixel-Art-Pizza-2.webp',
                      height: 400,
                      width: 400,
                    ),
                    Image.asset(
                      'assets/Pixel-Art-Pizza-2.webp',
                      height: 400,
                      width: 400,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      persistentFooterButtons: _interactiveButtons(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
