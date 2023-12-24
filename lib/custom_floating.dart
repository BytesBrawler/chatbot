import 'dart:async';
import 'package:chatbot/openai_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator_plus/translator_plus.dart';

class CustomFooterClass extends StatefulWidget {
  final VoidCallback callback;
  final VoidCallback? voiceAction;
  final TextEditingController controller;
  final bool isVoiceUsed;
  const CustomFooterClass({
    super.key,
    required this.callback,
    required this.controller,
    required this.isVoiceUsed,
    this.voiceAction,
  });

  @override
  State<CustomFooterClass> createState() => _CustomFooterClassState();
}

class _CustomFooterClassState extends State<CustomFooterClass> {
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
    //systemSpeak(widget.response);
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
        width: 350,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            widget.isVoiceUsed
                ? Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orange,

                      // border: Border.all(width: 2.0, style: BorderStyle.solid)
                    ),
                    width: 50,
                    height: 50,
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
                              final String speech =
                                  await openAIService.CHATGPTAPI(lastWords);
                              //    final String speech = await farziApi(lastWords);
                              final String question =
                                  await convertor(lastWords, "hi");
                              final String answer =
                                  await convertor(speech, "hi");
                              showBox(context, question, answer);
                              final talkingLanguage =
                                  await convertor(speech, "en");
                              await systemSpeak(talkingLanguage);

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
                  )
                : const SizedBox(
                    width: 1,
                  ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: widget.isVoiceUsed ? 250 : 290,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                  widget.callback();
                },
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.orange,

                // border: Border.all(width: 2.0, style: BorderStyle.solid)
              ),
              width: 50,
              height: 50,
              child: InkWell(
                onTap: widget.callback,
                child: const Icon(Icons.send),
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

//   Future<String> textResponse(String value) async {
// //     final String mainPrompt =
// //         '$value , please tell me from given prompt in which category should i move "Jobs" , "conselling" or "armed forces"  , answer in single word';
//     final speech = await openAIService.CHATGPTAPI(value);
//     Map<String, String> map = convertQueryStringToMap(speech);
//     final data = await OpenAIService().dataBaseApi(speech);

// //
// // if(speech == "jobs"){
// //
// // }
// //   final String question = await convertor(lastWords, "hi");
// //  final String answer = await convertor(speech, "pa");
//     //  showBox(context, question, answer);

//     //  final speech = await openAIService.CHATGPTAPI(value);
//     //   final String question = await convertor(lastWords, "hi");
//     //final String answer = await convertor(speech, "pa");
//     //
//     // showBox(context, question, answer);
//     return speech;
//   }

//   Map<String, String> convertQueryStringToMap(String queryString) {
//     Map<String, String> result = {};

//     List<String> keyValuePairs = queryString.split('&');

//     for (String pair in keyValuePairs) {
//       List<String> parts = pair.split('=');
//       if (parts.length == 2) {
//         String key = parts[0];
//         String value = parts[1];

//         // Decode URL-encoded values
//         value = Uri.decodeComponent(value);

//         result[key] = value;
//       }
//     }

//     return result;
//   }
}

// Widget customFooter(BuildContext context, TextEditingController controller) {
//   return 
// }
