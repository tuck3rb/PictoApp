import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:pictoapp/currentuser.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title, required this.user});

  final String title;
  final CurrentUser user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<SignatureState> _signatureKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _clearSignature() {
    final state = _signatureKey.currentState;
    if (state != null) {
      state.clear();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOut,
        );
      }
    });
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
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data!.docs;

                _scrollToBottom();

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final name = message['displayname'];
                    final text = message['text'];
                    final image = message['image'];
                    final type = message['type'];

                    if (type == 'text') {
                      return ListTile(leading: Text(name), title: Text(text));
                    } else if (type == 'drawing' && image != null) {
                      final imageBytes = base64Decode(image);
                      return ListTile(leading: Text(name), title: Image.memory(imageBytes));
                    } else if (type == 'mixed' && image != null) {
                      final imageBytes = base64Decode(image);
                      return ListTile(
                        leading: Text(name), 
                        title: Stack(
                          children: [
                            Image.memory(imageBytes),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.transparent,
                                child: Text(text)
                              )
                            )
                          ],
                        )
                      );
                    } else {
                      return const SizedBox.shrink(); // if messsage is unknown type
                    }
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Signature(
                    key: _signatureKey,
                    color: widget.user.color, /// Can be updated to user color from home page.
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
          ),
          AppBar(
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
              IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: _clearSignature,
              ),
            ]
          ),
        ],
      ),
    );
  }

  Future<DocumentReference<Object?>> _sendMessage() async {
    if (FirebaseAuth.instance.currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not signed in. Please return to the home page and try again.')),
      );
      return Future.error('Not signed in');
    }
    
    String text = _textController.text.trim();
    String? base64Image;

    if (_signatureKey.currentState != null) {
      final image = await _signatureKey.currentState!.getData();
      if (image != null) {
        final bytes = await image.toByteData(format: ImageByteFormat.png);
        base64Image = base64Encode(bytes!.buffer.asUint8List());
      }
    }
    // final signatureState = _signatureKey.currentState;
    // if (signatureState != null) {
    //   final image = await signatureState.getData();
    //   if (image != null) {
    //     final bytes = await image.toByteData(format: ImageByteFormat.png);
    //     if (bytes != null) {
    //       base64Image = base64Encode(bytes.buffer.asUint8List());
    //     }
    //   }
    // }

    final Map<String, dynamic> messageData = {
      'displayname': widget.user.displayName,
      'timestamp': FieldValue.serverTimestamp(),
      'type': '',
      'text': text,
      'image': base64Image,
    };

    if (text.isNotEmpty && base64Image == null) {
      messageData['type'] = 'text';
    } else if (text.isEmpty && base64Image != null) {
      messageData['type'] = 'drawing';
    } else {
      messageData['type'] = 'mixed';
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
