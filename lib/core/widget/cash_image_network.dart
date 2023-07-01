import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CashImageNetwork extends StatelessWidget {
  const CashImageNetwork(
      {super.key, required this.url, this.width, this.height, this.borderRadius});

  final String url;
  final double? width;

  final double? height;
  final BorderRadius ?borderRadius ;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius??BorderRadius.circular(100),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.red,),
      ),
    );
  }
}
