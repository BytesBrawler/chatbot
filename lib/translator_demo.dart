import 'package:flutter/material.dart';
import 'package:translator_plus/translator_plus.dart';

class TranslatorDemo extends StatefulWidget {
  const TranslatorDemo({super.key});

  @override
  State<TranslatorDemo> createState() => _TranslatorDemoState();
}

class _TranslatorDemoState extends State<TranslatorDemo> {
  final controller = TextEditingController();
  final translator = GoogleTranslator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: controller,
                ),
                TextButton(
                    onPressed: () => convertor(controller.text),
                    child: Text("Convert")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> convertor(String oldString) async {
    var translation = await translator.translate(oldString, to: "pa");
    print(translation);
  }
}
