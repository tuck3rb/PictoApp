import 'package:flutter/material.dart';

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
        title: Text(widget.title, 
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 46, 83), 
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(height: 75),
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
            const SizedBox(height: 100),
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
