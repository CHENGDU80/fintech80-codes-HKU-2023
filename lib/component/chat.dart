import 'package:apollo/data/colors.dart';
import 'package:flutter/material.dart';

class ChatButton extends StatelessWidget {
  const ChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {},
        child: Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: MyGradient.main,
          ),
          child: const Icon(
            Icons.chat_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
