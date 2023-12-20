import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:chatbot/chat_screen.dart';
import 'package:chatbot/custom_appbar.dart';
import 'package:chatbot/custom_floating.dart';
import 'package:chatbot/features.dart';
import 'package:chatbot/openai_services.dart';
import 'package:chatbot/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator_plus/translator_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();

  int start = 200;
  int delay = 200;
  void getMessages()async{
    dynamic response = await farziApi(textEditingController.text);
    print(response);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(initialString: textEditingController.text, response: response),));
     textEditingController.clear();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: BounceInDown(
      //     child: const Text('Ameya Bot'),
      //   ),
      //   leading: const Icon(Icons.menu),
      //   centerTitle: true,
      // ),
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.14,
        child: const SafeArea(child: CustomAppBar()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // virtual assistant picture
            ZoomIn(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                        color: Pallete.assistantCircleColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Container(
                    height: 123,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/paagi.jpeg',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // chat bubble
            FadeInRight(
              child: Visibility(
                //  visible: generatedImageUrl == null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                    top: 30,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Pallete.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(20).copyWith(
                      topLeft: Radius.zero,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Good Morning , What task can i do for you'.tr,
                      //   generatedContent == null
                      //   ?

                      //   : generatedContent!,
                      style: const TextStyle(
                        fontFamily: 'Cera Pro',
                        color: Pallete.mainFontColor,
                        fontSize:
                            // generatedContent == null ? 25 :
                            18,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SlideInLeft(
              child: Visibility(
                //  visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 10, left: 22),
                  child: Text(
                    'Here are a few features'.tr,
                    style: const TextStyle(
                      fontFamily: 'Cera Pro',
                      color: Pallete.mainFontColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SlideInLeft(child: const Features()),
          ],
        ),
      ),
      bottomNavigationBar: ZoomIn(
          delay: Duration(milliseconds: start + 3 * delay),
          child: CustomFooterClass(callback: ()=>getMessages(), controller: textEditingController,

          )),


      // floatingActionButton: customFooter(context),
      // floatingActionButton: ZoomIn(
      //   delay: Duration(milliseconds: start + 3 * delay),
      //   child: FloatingActionButton(
      //     backgroundColor: Pallete.firstSuggestionBoxColor,
      //     onPressed: () async {
      //       if (await speechToText.hasPermission &&
      //           speechToText.isNotListening) {
      //         await startListening();
      //         //ss  showToast(lastWords, animDuration: Duration(milliseconds: 500));
      //       } else if (speechToText.isListening) {
      //         Timer(
      //           Duration(seconds: 1),
      //           () async {
      //             final speech = await openAIService.CHATGPTAPI(lastWords);
      //             final String question = await convertor(lastWords, "hi");
      //             final String answer = await convertor(speech, "hi");
      //             showBox(context, question, answer);
      //             await systemSpeak(answer);

      //             // Fluttertoast.showToast(
      //             //     msg: speech,
      //             //     toastLength: Toast.LENGTH_LONG,
      //             //     gravity: ToastGravity.CENTER,
      //             //     timeInSecForIosWeb: 5,
      //             //     backgroundColor: Colors.red,
      //             //     textColor: Colors.white,
      //             //     fontSize: 16.0);
      //           },
      //         );

      //         // if (speech.contains('https')) {
      //         //   generatedImageUrl = speech;
      //         //   generatedContent = null;
      //         //   setState(() {});
      //         // } else {
      //         //   generatedImageUrl = null;
      //         //   generatedContent = speech;
      //         //   setState(() {});
      //         //   await systemSpeak(speech);

      //         // }

      //         await stopListening();
      //       } else {
      //         initSpeechToText();
      //       }
      //     },
      //     child: Icon(
      //       speechToText.isListening ? Icons.stop : Icons.mic,
      //     ),
      //   ),
      // ),
    );

  }
}
