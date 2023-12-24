import 'package:animate_do/animate_do.dart';
import 'package:chatbot/chat_screen.dart';
import 'package:chatbot/custom_appbar.dart';
import 'package:chatbot/custom_floating.dart';
import 'package:chatbot/features.dart';
import 'package:chatbot/openai_services.dart';
import 'package:chatbot/pallete.dart';
import 'package:chatbot/translation.dart/change_translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  String selectedLanguage = 'English';
  String selectedLanguageKey = 'en';
  int start = 200;
  int delay = 200;
  void getMessages() async {
    //  dynamic response = await farziApi(textEditingController.text);
    dynamic response =
        await OpenAIService().CHATGPTAPI(textEditingController.text);
    print(response);
    final String intitialString = textEditingController.value.text;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            initialString: intitialString,
            response: response,
            languageKey: selectedLanguageKey,
          ),
        ));
    textEditingController.clear();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.14,
        child: SafeArea(
            child: Column(
          children: [
            CustomAppBar(),
            const SizedBox(
              height: 20,
            ),
            BounceInDown(
                child: Wrap(
              spacing: 10.0,
              children: [
                buildChoiceChip('English'),
                buildChoiceChip('हिंदी'),
                buildChoiceChip('ਪੰਜਾਬੀ'),
              ],
            )),
          ],
        )),
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
          child: CustomFooterClass(
            callback: () => getMessages(),
            controller: textEditingController,
            isVoiceUsed: false,
          )),
    );
  }

  Widget buildChoiceChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: selectedLanguage == label,
      selectedColor: Colors.orange,
      onSelected: (bool selected) {
        setState(() {
          print(selected);
          if (selected) {
            selectedLanguage = label;
            if (label == "ਪੰਜਾਬੀ'") {
              selectedLanguage = "ਪੰਜਾਬੀ'";
              selectedLanguageKey = "pa";
              ChangeTranslation().updateTranslation(const Locale('pa_IN'));
            } else if (label == "हिंदी") {
              selectedLanguage = "हिंदी";
              selectedLanguageKey = "hi";
              ChangeTranslation().updateTranslation(const Locale('hi_IN'));
            } else {
              selectedLanguage = "English";
              selectedLanguageKey = "en";
              ChangeTranslation().updateTranslation(const Locale('en_US'));
            }
          }
        });
      },
    );
  }
}
