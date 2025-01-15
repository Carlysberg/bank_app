import "package:flutter/material.dart";

class RoundedRhombusClipper extends CustomClipper<Path> {
  RoundedRhombusClipper({
    this.cornerRadius = 10.0,
    this.slantLength = 30.0,
  }); // Radius for rounded tips

  final double cornerRadius;
  final double slantLength;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(slantLength + cornerRadius, 0)
      ..lineTo(size.width - cornerRadius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, cornerRadius)
      ..lineTo(size.width - slantLength, size.height - cornerRadius)
      ..quadraticBezierTo(
        size.width - slantLength,
        size.height,
        size.width - slantLength - cornerRadius,
        size.height,
      )
      ..lineTo(cornerRadius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - cornerRadius)
      ..lineTo(slantLength, cornerRadius)
      ..quadraticBezierTo(slantLength, 0, cornerRadius + slantLength, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
