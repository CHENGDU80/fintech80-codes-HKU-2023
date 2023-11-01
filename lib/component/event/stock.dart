import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventStock extends StatelessWidget {
  final String code;
  final double impact;
  const EventStock({super.key, required this.code, required this.impact});

  Future<String?> getIcon() async {
    final response = await http.get(
      Uri.parse("http://3.1.30.54:8080/get_image?path=stock/$code.jpg"),
    );
    if (response.statusCode != 200) {
      return null;
    }
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    var displayImpact = '';
    Color color = Colors.red;
    if (impact > 0) {
      displayImpact += '+';
      color = Colors.green;
    } else {
      displayImpact += '-';
    }
    displayImpact += ' ';
    displayImpact += impact.abs().toString();
    displayImpact += '%';
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder(
          future: getIcon(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const CircleAvatar(
                radius: 18,
              );
            }
            final icon = snapshot.data!;
            return CircleAvatar(
              radius: 18,
              foregroundImage: CachedNetworkImageProvider(icon),
            );
          },
        ),
        const SizedBox(width: 6),
        Text(
          displayImpact,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: color),
        ),
      ],
    );
  }
}
