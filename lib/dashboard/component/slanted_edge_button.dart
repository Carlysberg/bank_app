import "package:bank/dashboard/component/slanted_edge_clipper.dart";
import "package:flutter/material.dart";

class SlantedEdgeButton extends StatelessWidget {
  const SlantedEdgeButton({
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
      clipper: SlantedEdgeClipper(),
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
