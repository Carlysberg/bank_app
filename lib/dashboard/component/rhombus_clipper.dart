import "package:flutter/material.dart";

class RhombusClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height) // Move to the bottom-left corner
      ..lineTo(10, 0) // Draw line to top-middle
      ..lineTo(size.width, 0) // Draw line to top-right
      ..lineTo(size.width - 10, size.height) // Draw line to the bottom-middle
      ..close(); // Close the path to complete the shape
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
