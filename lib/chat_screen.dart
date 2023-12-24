import 'dart:async';
import 'package:chatbot/custom_appbar.dart';
import 'package:chatbot/custom_floating.dart';
import 'package:chatbot/openai_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator_plus/translator_plus.dart';

class ChatScreen extends StatefulWidget {
  final String initialString;
  final String response;
  final String languageKey;
  const ChatScreen(
      {super.key,
      required this.initialString,
      required this.response,
      this.languageKey = " "});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];

  final speechToText = SpeechToText();
  final translator = GoogleTranslator();
  final flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();

  @override
  void initState() {
    super.initState();
    addMessage('user', widget.initialString);
    addMessage('chatbot', widget.response);
    initSpeechToText();
    initTextToSpeech();
    systemSpeak(widget.response);
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<String> convertor(String oldString, language) async {
    var translation = await translator.translate(oldString, to: language);
    return translation.toString();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    print("speech initialized");
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(
      onResult: onSpeechResult,
    );
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
    setState(() {});
  }

  Future<void> systemStop() async {
    await flutterTts.stop();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();

    flutterTts.stop();
  }

  void getVoiceMessage() async {
    if (await speechToText.hasPermission && speechToText.isNotListening) {
      await startListening();
      //ss  showToast(lastWords, animDuration: Duration(milliseconds: 500));
    } else if (speechToText.isListening) {
      Timer(
        const Duration(seconds: 1),
        () async {
          final String prompt = await convertor(lastWords, "en");
          final String langaugePrompt =
              await convertor(lastWords, widget.languageKey);
          addMessage("user", langaugePrompt);
          // final String reply = await farziApi(prompt);
          final String reply = await openAIService.CHATGPTAPI(prompt);
          final String savedLanguageAnswer =
              await convertor(reply, widget.languageKey);

          addMessage('chatbot', savedLanguageAnswer);
          await systemSpeak(savedLanguageAnswer);
          // final String question =
          //     await convertor(lastWords, "hi");
          // final String answer = await convertor(speech, "pa");
          // showBox(context, question, answer);
        },
      );

      await stopListening();
    } else {
      initSpeechToText();
    }
  }

  void getMessages() async {
    final String prompt = await convertor(_controller.text, "en");
    addMessage("user", _controller.text);
    final String reply = await openAIService.CHATGPTAPI(prompt);
    // final String reply = await farziApi(prompt);
    print(reply);
    final String savedLanguageAnswer =
        await convertor(reply, widget.languageKey);
    addMessage('chatbot', savedLanguageAnswer);
    await systemSpeak(savedLanguageAnswer);

    _controller.clear();
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
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: const SafeArea(child: CustomAppBar()),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              addRepaintBoundaries: true,
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
      bottomNavigationBar: CustomFooterClass(
        callback: () => getMessages(),
        voiceAction: getVoiceMessage,
        controller: _controller,
        isVoiceUsed: true,
      ),
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
      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: isUser ? Colors.blue : Colors.green,
            borderRadius: isUser
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
        child: Text(
          content,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
