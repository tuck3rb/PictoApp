import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PictoApp',
      theme: ThemeData(
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor: Colors.blue,
            ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'PictoApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _textColor = Colors.black;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _changeTextColor(Color color) {
    setState(() {
      _textColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(
              height: 75,
            ),
            const Text(
              'Select a chat room:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Display name',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 156, 156, 156)),
                ),
                style: TextStyle(color: _textColor, fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _colorButton(Colors.black),
                  _colorButton(Colors.red),
                  _colorButton(Colors.orange),
                  _colorButton(const Color.fromARGB(255, 255, 208, 0)),
                  _colorButton(Colors.green),
                  _colorButton(Colors.blue),
                  _colorButton(Colors.purple),
                ],
              ),
            ),
            // Color option buttons here (black, red, orange, yellow, green, blue, purple)
            // 7 boxes of different colors in this row for selecting
            // When pressed it will change color of text in textfield for display name
            // When enter a public or private room, this will also be the color of your display name for yourself and globally
            // To do this it must be set up in firebase
            SizedBox(
              width: 250,
              height: 100,
              child: OutlinedButton(
                onPressed: _incrementCounter,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Color.fromARGB(255, 0, 46, 83)),
                  backgroundColor: const Color.fromARGB(255, 0, 122, 222),
                  shape: const BeveledRectangleBorder(),
                ),
                child: const Text('Public Room', style: TextStyle(fontSize: 24, color: Colors.white),),
              ),
            ),
            SizedBox(
              width: 250,
              height: 100,
              child: OutlinedButton(
                onPressed: _incrementCounter,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Color.fromARGB(255, 0, 46, 83)),
                  backgroundColor: const Color.fromARGB(255, 0, 122, 222),
                  shape: const BeveledRectangleBorder(),
                ),
                child: const Text('Private Room', style: TextStyle(fontSize: 24, color: Colors.white),),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorButton(Color color) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () => _changeTextColor(color),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
        ),
        child: Container(),
      ),
    );
  }

}


