import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CashImageNetwork extends StatelessWidget {
  const CashImageNetwork(
      {super.key, required this.url, this.width, this.height});

  final String url;
  final double? width;

  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
