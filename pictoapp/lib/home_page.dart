import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // _counter is only here so that the buttons do anything
  // Once button navigation takes you to the right pages, 
  // then _counter will no longer be needed
  int _counter = 0; 
  Color _textColor = Colors.black;

  // _incrementCounter is only here so that the buttons do anything
  // Once button navigation takes you to the right pages, 
  // then _incrementCounter will no longer be needed
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Allows for display name to change with user's selection
  // I want to continue this value to the user's profile probably,
  // so that in the chat they have a username color and can maybe 
  // type and draw in that color (if not others).
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
                // We should either make it to where you can edit your display name
                // straight from here OR we could make it to where your display name
                // is written here and you can click a little pencil icon to edit your
                // profile settings (similar to profile button in the firebase demo).
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
                children: [ // Different colors for user to select. Could totally put more!
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
                // I think we'll be able to figure out Private Rooms,
                // but if not we could have multiple public ones easily.
                // However if we can make multiple public ones, then private
                // rooms shouldn't be that much harder!
                child: const Text('Private Room', style: TextStyle(fontSize: 24, color: Colors.white),),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // Made a special type of elevated button for selecting display name color
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
