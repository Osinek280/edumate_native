import 'dart:convert';
import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const ImageBuilder({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return errorWidget ?? _defaultErrorWidget();
    }

    final isBase64 = !_isProbablyUrl(imageUrl);

    if (isBase64) {
      try {
        return Image.memory(
          base64Decode(imageUrl),
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => errorWidget ?? _defaultErrorWidget(),
        );
      } catch (e) {
        debugPrint('❌ Błąd dekodowania base64: $e');
        return errorWidget ?? _defaultErrorWidget();
      }
    }

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ?? _defaultPlaceholder();
      },
      errorBuilder: (_, __, ___) => errorWidget ?? _defaultErrorWidget(),
    );
  }

  Widget _defaultPlaceholder() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
      ),
    );
  }

  Widget _defaultErrorWidget() {
    return const Center(
      child: Icon(
        Icons.broken_image_outlined,
        size: 48,
        color: Color(0xFF9CA3AF),
      ),
    );
  }

  static bool _isProbablyUrl(String str) {
    return str.startsWith('http://') || str.startsWith('https://');
  }
}
