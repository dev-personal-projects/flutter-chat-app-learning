import 'package:flutter/material.dart';

class WhatsappLogo extends StatelessWidget {
  static const double _defaultSize = 120.0;

  final double? size;

  const WhatsappLogo({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final assetPath = isDarkMode
        ? 'assets/whatsapp-icon-light.png'
        : 'assets/whatsapp-icon-dark.png';
    final logoSize = size ?? _defaultSize;

    return Image.asset(
      assetPath,
      width: logoSize,
      height: logoSize,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Error loading WhatsApp logo: $error');
        return Icon(
          Icons.message,
          size: logoSize,
          color: Theme.of(context).colorScheme.primary,
        );
      },
    );
  }
}
