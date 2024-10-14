import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<SignatureState> _signatureKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Room ${widget.title}')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('rooms')
                  .doc(widget.title)
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final content = message['content'];
                    final type = message['type'];

                    if (type == 'text') {
                      return ListTile(title: Text(content));
                    } else if (type == 'drawing' && content != null) {
                      final imageBytes = base64Decode(content);
                      return Image.memory(imageBytes);
                    } else {
                      return const SizedBox.shrink(); // In case of unknown type
                    }
                  },
                );
              },
            ),
          ),
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Signature(
                  key: _signatureKey,
                  color: Colors.black, /// Can be updated to user color from home page.
                  strokeWidth: 3.0,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      filled: false,
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    minLines: 1,
                    textAlignVertical: TextAlignVertical.top,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Future<DocumentReference<Object?>> _sendMessage() async {
    String text = _textController.text.trim();
    String? base64Image;

    if (_signatureKey.currentState != null) {
      final image = await _signatureKey.currentState!.getData();
      if (image != null) {
        final bytes = await image.toByteData(format: ImageByteFormat.png);
        base64Image = base64Encode(bytes!.buffer.asUint8List());
      }
    }

    final Map<String, dynamic> messageData = {
      'timestamp': FieldValue.serverTimestamp(),
      'type': '',
      'content': text.isNotEmpty ? text : base64Image,
    };

    if (text.isNotEmpty) {
      messageData['type'] = 'text';
    } else if (base64Image != null) {
      messageData['type'] = 'drawing';
    }

    _textController.clear();
      _signatureKey.currentState?.clear();

    return FirebaseFirestore.instance
          .collection('rooms')
          .doc(widget.title)
          .collection('messages')
          .add(messageData);
  }
}
