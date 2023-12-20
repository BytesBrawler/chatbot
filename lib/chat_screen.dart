import 'package:chatbot/custom_appbar.dart';
import 'package:chatbot/custom_floating.dart';
import 'package:chatbot/openai_services.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String initialString;
  final String response;
  const ChatScreen(
      {super.key, required this.initialString, required this.response});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];

  void getMessages()async{
    addMessage("user", _controller.text);
    dynamic response = await farziApi(_controller.text);
    print(response);
    addMessage("chatbot", response);
    _controller.clear();


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addMessage('user', widget.initialString);
    addMessage('chatbot', widget.response);
  }

  void addMessage(String role, String content) {
    setState(() {
      messages.add({'role': role, 'content': content});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.14,
        child: const SafeArea(child: CustomAppBar()),
      ),
      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
             //jobs
              // reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatBubble(
                  isUser: message['role'] == 'user',
                  content: message['content']!,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomFooterClass(callback: ()=>
        getMessages()
      , controller: _controller ,),
    );

  }

}



class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String content;

  ChatBubble({required this.isUser, required this.content});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: 
      Container(
        constraints: BoxConstraints(maxWidth: 300),

        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          
          color: isUser ? Colors.blue : Colors.green,

          borderRadius: isUser ? BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)) :  BorderRadius.only(topRight: Radius.circular(30), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
        ),
        child: Text(
          content,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
