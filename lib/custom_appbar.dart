import 'package:animate_do/animate_do.dart';
import 'package:chatbot/translation.dart/change_translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: BounceInLeft(
                child: const Icon(
                  Icons.menu,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),
            BounceInDown(
              child: Text(
                "Ameya Bot".tr,
                style: const TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
            BounceInLeft(
              child: const Icon(
                Icons.exit_to_app,
                size: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
