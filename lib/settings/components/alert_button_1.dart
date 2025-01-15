import "package:flutter/material.dart";

class AlertButton1 extends StatelessWidget {
  const AlertButton1({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final Widget label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(
          16,
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFFE6B014),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: Color(0xFFE6B014),
            width: 2,
          ),
        ),
      ),
      child: label,
    );
  }
}
