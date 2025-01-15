import "package:bank/dashboard/component/slanted_edge_button.dart";
import "package:bank/dashboard/component/slanted_edge_button2.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    required this.leftOnPressed,
    required this.rightOnPressed,
    required this.leftForegroundColor,
    required this.leftBackgroundColor,
    required this.rightForegroundColor,
    required this.rightBackgroundColor,
    required this.activated,
  });

  final VoidCallback leftOnPressed;
  final VoidCallback rightOnPressed;
  final Color leftForegroundColor;
  final Color leftBackgroundColor;
  final Color rightForegroundColor;
  final Color rightBackgroundColor;
  final int activated;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: leftBackgroundColor,
      child: Row(
        children: [
          //------------------------------------
          // button on the left
          //------------------------------------
          Expanded(
            child: SlantedEdgeButton(
              buttonColor: leftBackgroundColor,
              icon: SvgPicture.asset(
                "assets/images/home_icon.svg",
                colorFilter:
                    ColorFilter.mode(leftForegroundColor, BlendMode.srcIn),
              ),
              text: Text(
                "Home",
                style: TextStyle(
                  color: leftForegroundColor,
                  fontSize: 11,
                  fontWeight:
                      activated == 0 ? FontWeight.w700 : FontWeight.w400,
                  fontFamily: "OpenSans",
                  letterSpacing: 0.5,
                ),
              ),
              onPressed: leftOnPressed,
            ),
          ),
          //------------------------------------
          // button on the right
          //------------------------------------
          Expanded(
            child: SlantedEdgeButton2(
              text: Text(
                "Transactions",
                style: TextStyle(
                  color: rightForegroundColor,
                  fontSize: 11,
                  fontWeight:
                      activated == 1 ? FontWeight.w700 : FontWeight.w400,
                  fontFamily: "OpenSans",
                  letterSpacing: 0.5,
                ),
              ),
              onPressed: rightOnPressed,
              icon: SvgPicture.asset(
                "assets/images/transaction_icon.svg",
                colorFilter: ColorFilter.mode(
                  rightForegroundColor,
                  BlendMode.srcIn,
                ),
              ),
              buttonColor: rightBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
