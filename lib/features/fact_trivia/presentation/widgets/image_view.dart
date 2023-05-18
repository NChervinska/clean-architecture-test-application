import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String url;

  const ImageView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
      loadingBuilder: (_, child, loadingProgress) {
        if (loadingProgress == null) return child;

        final expectedTotalBytes = loadingProgress.expectedTotalBytes;
        if (expectedTotalBytes == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.cumulativeBytesLoaded / expectedTotalBytes,
          ),
        );
      },
    );
  }
}
