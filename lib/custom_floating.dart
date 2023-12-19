import 'dart:async';

import 'package:chatbot/openai_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator_plus/translator_plus.dart';

class CustomFooterClass extends StatefulWidget {
  final TextEditingController controller;
  const CustomFooterClass({super.key, required this.controller});

  @override
  State<CustomFooterClass> createState() => _CustomFooterClassState();
}

class _CustomFooterClassState extends State<CustomFooterClass> {
  //TextEditingController promptController = TextEditingController();
  final speechToText = SpeechToText();
  final translator = GoogleTranslator();
  final flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: SizedBox(
        //  decoration: BoxDecoration(
        //  border: Border.all(width: 2.0, style: BorderStyle.solid)),
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            // Container(
            //   decoration: const BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(10)),
            //     color: Colors.orange,

            //     // border: Border.all(width: 2.0, style: BorderStyle.solid)
            //   ),
            //   width: 50,
            //   height: 50,
            //   child: Icon(Icons.replay),
            // ),

            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  //color: Colors.orange,
                  border: Border.all(color: Colors.black))

              // border: Border.all(width: 2.0, style: BorderStyle.solid)
              // ),
              ,
              child: TextFormField(
                controller: widget.controller,
                decoration: const InputDecoration(
                  hintText: "Write Here ...",
                  border: InputBorder.none,
                ),
                onFieldSubmitted: (value) async {
                  //await systemSpeak(speech);
                  // final String alpha =
                  //     await textResponse(widget.controller.text);
                  // print(alpha);
                  final String alpha = await OpenAIService().farziApi(value);
                  print(alpha);
                  setState(() {
                    widget.controller.clear();
                  });
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.orange,

                // border: Border.all(width: 2.0, style: BorderStyle.solid)
              ),
              width: 60,
              height: 60,
              child: InkWell(
                onTap: () async {
                  if (await speechToText.hasPermission &&
                      speechToText.isNotListening) {
                    await startListening();
                    //ss  showToast(lastWords, animDuration: Duration(milliseconds: 500));
                  } else if (speechToText.isListening) {
                    Timer(
                      const Duration(seconds: 1),
                      () async {
                        final speech =
                            await openAIService.CHATGPTAPI(lastWords);
                        final String question =
                            await convertor(lastWords, "hi");
                        final String answer = await convertor(speech, "pa");
                        showBox(context, question, answer);
                        await systemSpeak(speech);

                        // Fluttertoast.showToast(
                        //     msg: speech,
                        //     toastLength: Toast.LENGTH_LONG,
                        //     gravity: ToastGravity.CENTER,
                        //     timeInSecForIosWeb: 5,
                        //     backgroundColor: Colors.red,
                        //     textColor: Colors.white,
                        //     fontSize: 16.0);
                      },
                    );

                    // if (speech.contains('https')) {
                    //   generatedImageUrl = speech;
                    //   generatedContent = null;
                    //   setState(() {});
                    // } else {
                    //   generatedImageUrl = null;
                    //   generatedContent = speech;
                    //   setState(() {});
                    //   await systemSpeak(speech);

                    // }

                    await stopListening();
                  } else {
                    initSpeechToText();
                  }
                },
                child: Icon(
                  speechToText.isListening ? Icons.stop : Icons.mic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBox(
    BuildContext context,
    String heading,
    String respMesg,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  backgroundColor: Colors.red,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),

          //  title: Text(heading, style: const TextStyle(color: Colors.white),),
          title: Text(
            'Ques : $heading ',
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: "Cera Pro",
                fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
              child:
                  Text(respMesg, style: const TextStyle(color: Colors.black))),
          actions: [
            TextButton(
                onPressed: () async => await systemStop(),
                child: Text("Stop sound only")),
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                await systemStop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> textResponse(String value) async {
    final String mainPrompt =
        '$value , please tell me from given prompt in which category should i move "Jobs" or "Skill Development" or "Self Employemnt" , answer in single word';
    final speech = await openAIService.CHATGPTAPI(mainPrompt);

//    final String question = await convertor(lastWords, "hi");
//  final String answer = await convertor(speech, "pa");
    //  showBox(context, question, answer);

    //  final speech = await openAIService.CHATGPTAPI(value);
    //   final String question = await convertor(lastWords, "hi");
    //final String answer = await convertor(speech, "pa");
    //
    // showBox(context, question, answer);
    return speech;
  }
}

// Widget customFooter(BuildContext context, TextEditingController controller) {
//   return 
// }
