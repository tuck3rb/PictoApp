import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title; // we will want this to be 'Public' when in that chat or the code for the private room

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
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
      body: const Center( // remove this const when actually implementing body of this page
        child: Column(
          children: [
            Text('This is the chat page.')
          ],
        ),
      ),
    );
  }

}