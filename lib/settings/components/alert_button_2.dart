import "package:bank/common/constant.dart";
import "package:flutter/material.dart";

class AlertButton2 extends StatelessWidget {
  const AlertButton2({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(
          16,
        ),
        backgroundColor: const Color(0xFFE6B014),
        foregroundColor: const Color(0xFF212121),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: kAlertButtonStyle,
      ),
    );
  }
}
