import 'package:chatbot/chat_screen.dart';
import 'package:chatbot/openai_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Features extends StatelessWidget {
  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        itemCount: featureList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          // print(featureList[index][1]);
          return buildItem(
            context,
            imageUrl: featureList[index][1],
            title: featureList[index][0],
            onTap: featureList[index][2],
          );
        },
      ),
    );
  }

  Widget buildItem(
    BuildContext context, {
    required String imageUrl,
    required String title,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap(context);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        width: MediaQuery.of(context).size.width * 0.25,
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageUrl,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//title , url ,function
final List<List> featureList = [
  [
    "jobs".tr,
    "assets/images/icon7.png",
    (BuildContext context) async {
      final response = await farziApi("jobs");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              initialString: "Jobs",
              response: response,
            ),
          ));
    }
  ],
  [
    "skill Training",
    "assets/images/icon5.png",
    (BuildContext context) async {
      final response = await farziApi("Skil Training");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              initialString: "Skill Training",
              response: response,
            ),
          ));
    }
  ],
  [
    "Self Employment",
    "assets/images/icon7.png",
    () {},
  ],
  [
    "Local Services",
    "assets/images/service-ico.png",
    () {},
  ],
  [
    "Jobs for Womens",
    "assets/images/jobforwoman2.png",
    () {},
  ],
  [
    "Jobs for Disables",
    "assets/images/disabled.png",
    () {},
  ],
];
