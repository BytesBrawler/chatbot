import 'dart:convert';

import 'package:chatbot/secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  bool isLoading = false;
  final List<Map<String, dynamic>> messages = [];

  Future<String> CHATGPTAPI(String prompt) async {
    // print("api call starts");
    // print('prompt is ${prompt}');
    messages.add({'role': 'user', 'content': prompt});
    isLoading = true;

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );
      print('messages is ${messages}');

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        Map<String, dynamic> result =
            jsonDecode(response.body)["choices"][0]["message"];
        messages.add(result);
        isLoading = false;
        print(result["content"]);
        return result["content"].toString();
        //  print(content);
      } else {
        isLoading = false;
        return "api call failed";
      }
      //return "api call ended";
    } catch (e) {
      return e.toString();
    }
  }


  Future farziApi(String prompt) async {

 Map data = {
   "prompt" : prompt,
 };
    //try {
      final response = await http.post(

        Uri.parse('http://127.0.0.1:5000/generate-response'),
        headers: {
              // "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json',

        },
       body: jsonEncode(data),

      );
    //  print('messages is ${messages}');

      print(response.body);
      // if (response.statusCode == 200) {
      //   print(jsonDecode(response.body));
      //   Map<String, dynamic> result =
      //   jsonDecode(response.body)["choices"][0]["message"];
      //   messages.add(result);
      //   isLoading = false;
      //   print(result["content"]);
      //   return result["content"].toString();
      //   //  print(content);
      // } else {
      //   isLoading = false;
      //   return "api call failed";
      }
      //return "api call ended";
    // } catch (e) {
    //   return e.toString();
    // }
  }

