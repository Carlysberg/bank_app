import "package:auto_size_text/auto_size_text.dart";
import "package:bank/common/constant.dart";
import "package:flutter/material.dart";

class QuestionText extends StatelessWidget {
  const QuestionText({
    required this.text,
    super.key,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      minFontSize: 14,
      maxFontSize: 18,
      style: kQuestionTextStyle,
    );
  }
}
