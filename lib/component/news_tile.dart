import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class NewsTile extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;
  const NewsTile(
      {super.key,
      required this.title,
      this.padding = const EdgeInsets.symmetric(vertical: 22.0)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 24,
          ),
          SizedBox(
            width: 360,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  loremIpsum(words: 12),
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 60),
          const CircleAvatar(
            radius: 120,
          ),
          const SizedBox(width: 60),
          const CircleAvatar(
            radius: 120,
          ),
        ],
      ),
    );
  }
}
