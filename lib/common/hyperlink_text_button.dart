import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";

class HyperlinkTextButton extends StatelessWidget {
  const HyperlinkTextButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: AutoSizeText(
        text,
        minFontSize: 14,
        maxFontSize: 18,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: "OpenSans",
          color: Color(0xFFE6B014),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.18,
        ),
      ),
    );
  }
}
