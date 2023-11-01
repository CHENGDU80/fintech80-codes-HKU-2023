import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventNewsSource extends StatelessWidget {
  final String news;
  const EventNewsSource({super.key, required this.news});

  Future<String?> getIcon() async {
    final response = await http.get(
      Uri.parse(
          "http://3.1.30.54:8080/get_image?path=newsSourceIcon/$news.jpg"),
    );
    if (response.statusCode != 200) {
      return null;
    }
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          FutureBuilder(
            future: getIcon(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const CircleAvatar(radius: 18);
              }
              final image = snapshot.data!;
              return CircleAvatar(
                radius: 18,
                foregroundImage: CachedNetworkImageProvider(image),
              );
            },
          ),
          const SizedBox(width: 6),
          Text(
            news,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
