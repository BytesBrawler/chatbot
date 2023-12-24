import 'dart:convert';
import 'package:chatbot/secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  bool isLoading = false;
  final List<Map<String, dynamic>> messages = [];

  Future<String> CHATGPTAPI(String prompt) async {
    // print("api call starts");
    // print('prompt is ${prompt}');
    // messages.add({
    //   'role': "system",
    //   'content':
    //       "you should act as an asistant and have to reply in single String format of /api/jobs/getDetails/query?location=(location value  and if it doen't containe string then give value of location as 0"
    // });
    //&qualification=(qualification value)&location=(location value)
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

  Future dataBaseApi(String Url) async {
    print(Url);

    //try {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:2000/api/jobs/getDetails/query?location=Kota'),
      //  Uri.parse('http://http://127.0.0.1:2000$Url'),
      headers: {
        // "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
      },
      // body: jsonEncode(data),
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

Future<String> farziApi(String prompt) async {
// Map content = {
//   "content": "I want a private job with 2 years of exprience",
// };
//
// Map role = {
//   "role": "user"
// };
//
// List list = [role,content];
//
// Map messages = {
//   "messages" : list
// };
  Map alpha = {"content": prompt};
  try {
    // print(messages);
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/chatbot'),
      //  Uri.parse('http://http://127.0.0.1:2000$Url'),
      headers: {
        // "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
      },

      body: jsonEncode(alpha),
    );
    //  print('messages is ${messages}');

    print(response.body);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final String output = jsonDecode(response.body)["response"];

      return output.toString();
      print(output);
      //  print(content);
    } else {
      return "api call failed bhaiyaa ji baad mai try kerna";
    }
    return "api call ended";
  } catch (e) {
    return e.toString();
  }
}
