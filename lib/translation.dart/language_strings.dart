import 'package:get/get_navigation/src/root/internacionalization.dart';

class LanguageStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "Ameya Bot": "Ameya bot",
          "Good Morning , What task can i do for you": ""
              "Good Morning , What task can i do for you",
          "Here are a few features": "Here are a few features",
          "jobs": "jobs",
        },
        'hi_IN': {
          "Ameya Bot": "अमेया बॉट",
          "Good Morning , What task can i do for you":
              "सुप्रभात, मैं आपके लिए क्या कार्य कर सकता हूँ?",
          "Here are a few features": "यहां कुछ विशेषताएं दी गई हैं",
          "jobs": "नौकरियां",
        },
        'pa_IN': {
          "Ameya Bot": "ਅਮੇਯਾ ਬੋਟ",
          "Good Morning , What task can i do for you":
              "ਗੁੱਡ ਮਾਰਨਿੰਗ, ਮੈਂ ਤੁਹਾਡੇ ਲਈ ਕੀ ਕੰਮ ਕਰ ਸਕਦਾ ਹਾਂ",
          "Here are a few features": "ਇੱਥੇ ਕੁਝ ਵਿਸ਼ੇਸ਼ਤਾਵਾਂ ਹਨ",
          "jobs": "punjabi",
        }
      };
}

List<Map<String, List<Map<String, List<Map<String, int>>>>>> lists = [
  {
    "Jobs": [
      {
        "Job Type": [
          {"Private": 0},
          {"Goverment": 1}
        ]
      },
      {}
    ]
  },
];
