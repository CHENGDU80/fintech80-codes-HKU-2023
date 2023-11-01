import 'package:apollo/data/companies.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkRoundImage extends StatelessWidget {
  final String name;
  final double size;
  const NetworkRoundImage({super.key, required this.name, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: CachedNetworkImageProvider(
              "https://logo.clearbit.com/${Companies.mp[name]!}"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
