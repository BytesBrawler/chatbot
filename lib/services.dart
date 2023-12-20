// import 'package:chatbot/openai_services.dart';
// import 'package:get/get.dart';

// class Services extends GetxController {
//   final OpenAIService openAIService = OpenAIService();
  
//   final List<Map<String, dynamic>> messages = [];

//   void addMessage(String role, String content) {
    
//       messages.add({'role': role, 'content': content});
    
//   }
//   //o by chatgpt
//   //1 by us
//   void chatbotService(String messageByUserToChatgpt , ) async {
//     if (messages.isEmpty) {
//       //convert it into english from any lanuage

//       //response = call and exceture open ai code//
//       messages.add({1: messageByUserToChatgpt});
//       Map responseMap = convertQueryStringToMap("response"); //
      
//       }
//     } else {
//       chatBotService1(responseMap);
//     }
  
//   void chatBotService1(Map responseMap)async{
//     if (responseMap["location"] == "" &&
//           responseMap["qualification"] == "" &&
//           responseMap["exprience"] == "" &&
//           responseMap["job_type"] == "") {
//         //pass a string to get that the data is not correctly enter
//         messages.add({0: "Wrong Data Message"});
//         //procceed via differnt steps as per time

//         //don't forget to convert incoming datas language
//       } else {
//         chatBotService2(responseMap);
//         //pass string mentioning that there data is procceed successfully//means waiting
        
//   }
//   }

//   void chatBotService2(Map responseMap)async{
//     final String dbResponse =
//             await openAIService.dataBaseApi("responseMap"); //
//         if (dbResponse == "jsonData") {
//           if ("noerror" == "noerror") {
//             //we will show a custom list view builder widget and audio will be played
//             //of only the title
//             //after it this should ask for any other help(yes/no and feed back afer no call saem api after yes)
//             messages.add({0: "jsonData"});
//             //and also have to do something for the hindi and english message
//           } else {
//             messages.add({0: "Error shown"});
//             //Error will be Shown
//             //start from start
//             //chatbotService(messageByUserToChatgpt);
//           }
//         } else {
//           messages.clear();
//           chatbotService(messageByUserToChatgpt);
//         }
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
// }
