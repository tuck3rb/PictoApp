import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pictoapp/app_state.dart';
import 'package:pictoapp/authentication.dart';
import 'package:pictoapp/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart' // new
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:provider/provider.dart';  

import 'currentuser.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.user});

  final String title;
  final CurrentUser user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _textColor = Colors.black;

  // Allows for display name to change with user's selection
  // I want to continue this value to the user's profile probably,
  // so that in the chat they have a username color and can maybe 
  // type and draw in that color (if not others).
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

  Future<void> _signInAnonymously() async {
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
            // Consumer<ApplicationState>(
            // builder: (context, appState, _) => AuthFunc(
            //     loggedIn: appState.loggedIn,
            //     signOut: () {
            //       FirebaseAuth.instance.signOut();
            //     }),
          // ),
            const SizedBox(height: 75),
            const Text(
              'Create a username:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              width: 250,
              child: TextField( 
                onChanged: (text){ 
                  _changeName(text);
                },
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
            const Text(
              'Select a brush color:',
              style: TextStyle(fontSize: 25),
            ),
            SingleChildScrollView(
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
                    await _signInAnonymously();
                    context.push('/chatpage');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a display name')),
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Color.fromARGB(255, 0, 46, 83)),
                  backgroundColor: const Color.fromARGB(255, 0, 122, 222),
                  shape: const BeveledRectangleBorder(),
                ),
                child: const Text('Join Room', style: TextStyle(fontSize: 30, color: Colors.white),),
              ),
            ),
            //SizedBox(
              //width: 250,
              //height: 100,
              //child: OutlinedButton(
                //onPressed: () {
                  //context.push('/chatpage');
                //},
                //style: OutlinedButton.styleFrom(
                  //foregroundColor: Colors.black,
                  //side: const BorderSide(color: Color.fromARGB(255, 0, 46, 83)),
                  //backgroundColor: const Color.fromARGB(255, 0, 122, 222),
                  //shape: const BeveledRectangleBorder(),
                //),
                // I think we'll be able to figure out Private Rooms,
                // but if not we could have multiple public ones easily.
                // However if we can make multiple public ones, then private
                // rooms shouldn't be that much harder!
                //child: const Text('Private Room', style: TextStyle(fontSize: 24, color: Colors.white),),
              //),
            //),
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
  
