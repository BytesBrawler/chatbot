import 'package:chatbot/custom_appbar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.08,
        child: SafeArea(child: const CustomAppBar()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(),
        ),
      ),

      // body: ,
    );
  }
}
