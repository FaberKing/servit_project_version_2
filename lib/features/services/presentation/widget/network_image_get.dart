import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class NetworkImageGet extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  const NetworkImageGet({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      imageUrl == null
          ? "https://img.freepik.com/free-psd/cape-cod-house-isolated-transparent-background_191095-27126.jpg"
          : "$imageUrl",
      // key: imageKey,
      height: height ?? 0,
      width: width ?? double.infinity,
      fit: BoxFit.cover,
      handleLoadingProgress: true,
      loadStateChanged: (state) {
        if (state.extendedImageLoadState == LoadState.failed) {
          return AspectRatio(
            aspectRatio: 16 / 9,
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
              child: const Icon(
                Icons.broken_image,
                color: Colors.black,
              ),
            ),
          );
        }
        if (state.extendedImageLoadState == LoadState.loading) {
          return AspectRatio(
            aspectRatio: 16 / 9,
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
              child: const CircularProgressIndicator.adaptive(),
            ),
          );
        }
        return null;
      },
    );
  }
}
