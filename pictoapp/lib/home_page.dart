import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart' // new
    hide EmailAuthProvider, PhoneAuthProvider;
import 'currentuser.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.user});

  final String title;
  final CurrentUser user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _textColor = Colors.black; // default user selected color before any selection is made

  // Allows for display name color to change with user's selection
  // This value continues to the user's chats in the public room
  void _changeColor(Color color) { 
    setState(() {
      _textColor = color;
      widget.user.color = color;
    });
  }

  void _changeName(String name) { 
    setState(() {
      widget.user.displayName = name;
    });
  }

  Future<void> _signInAnonymously() async { // Error handling for signing in without profiles
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print("Error signing in anonymously: $e");
    }
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
              'Create a username:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox( // Display name box is the only place you have to sign in (no profiles)
              width: 250,
              child: TextField( 
                onChanged: (text){ 
                  _changeName(text);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Display name',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 156, 156, 156)),
                ),
                style: TextStyle(color: _textColor, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              'Select a brush color:',
              style: TextStyle(fontSize: 25),
            ),
            SingleChildScrollView( // Selecting brush color/username color
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ // Different colors for user to select. Could totally put more!
                  _colorButton(Colors.black),
                  _colorButton(Colors.red),
                  _colorButton(Colors.orange),
                  _colorButton(const Color.fromARGB(255, 255, 208, 0)),
                  _colorButton(Colors.green),
                  _colorButton(Colors.blue),
                  _colorButton(Colors.purple),
                  _colorButton(const Color.fromARGB(255, 255, 108, 157)),
                ],
              ),
            ),
            const SizedBox(height: 0,),
            SizedBox(
              width: 250,
              height: 100,
              child: OutlinedButton(
                onPressed: () async {
                  if (widget.user.displayName.isNotEmpty) {
                    await _signInAnonymously(); // Ensures you are able to join room via cloud
                    context.push('/chatpage');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a display name')),
                    );
                  }
                },
                style: OutlinedButton.styleFrom( // Style for 'Join Room' button
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Color.fromARGB(255, 0, 46, 83)),
                  backgroundColor: const Color.fromARGB(255, 0, 122, 222),
                  shape: const BeveledRectangleBorder(),
                ),
                child: const Text('Join Room', style: TextStyle(fontSize: 30, color: Colors.white),),
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
      padding: const EdgeInsets.all(1.0),
      child: ElevatedButton(
        onPressed: () => _changeColor(color),
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
  
