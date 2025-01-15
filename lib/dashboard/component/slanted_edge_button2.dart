import "package:bank/dashboard/component/slanted_edge_clipper2.dart";
import "package:flutter/material.dart";

class SlantedEdgeButton2 extends StatelessWidget {
  const SlantedEdgeButton2({
    required this.text,
    required this.onPressed,
    required this.icon,
    required this.buttonColor,
    super.key,
  });
  final Widget text;
  final VoidCallback onPressed;
  final Widget icon;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SlantedEdgeClipper2(),
      child: Container(
        height: kBottomNavigationBarHeight,
        color: buttonColor,
        child: MaterialButton(
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [icon, text],
          ),
        ),
      ),
    );
  }
}
