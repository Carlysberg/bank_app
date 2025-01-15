import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildShowMySnackBar(
  BuildContext context,
  double screenWidth,
  double screenHeight,
  String message,
) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        left: screenWidth / 20,
        right: screenWidth / 20,
        bottom: screenHeight / 15,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.cover,
              child: AutoSizeText(
                message,
                minFontSize: 10,
                maxFontSize: 12,
                stepGranularity: 2,
                style: const TextStyle(
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
            ),
          ),
          const Icon(Icons.close),
        ],
      ),
      backgroundColor: const Color(0xFFE9F6ED), //change the background color
      shape: RoundedRectangleBorder(
        //change the shape
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: Color(0xFF25A249),
          width: 2,
        ),
      ),
    ),
  );
}
