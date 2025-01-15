import "package:flutter/material.dart";

const kActiveBarColor = Color(0xFF022E64);
const kInactiveBarColor = Color(0xFFFFFFFF);
const kActiveIconColor = Color(0xFFE6B014);
const kInactiveIconColor = Color(0xFF022E64);

const kQuestionTextStyle = TextStyle(
  fontSize: 16,
  color: Color(0xFFF5F5F5),
  fontWeight: FontWeight.w600,
  letterSpacing: 0.18,
);

const kPageDescriptionStyle = TextStyle(
  fontFamily: "OpenSansExtraBold",
  fontSize: 24,
  fontWeight: FontWeight.w800,
  color: Color(0xFFF5F5F5),
  letterSpacing: 0.18,
);

const kAppBarStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: Color(0xFFF5F5F5),
  letterSpacing: 0.18,
);

const kAlertTitleStyle = TextStyle(
  fontFamily: "OpenSansExtraBold",
  fontSize: 24,
  fontWeight: FontWeight.w800,
  color: Color(0xFF212121),
  letterSpacing: 0.18,
);

const kAlertQuestionStyle = TextStyle(
  fontSize: 16,
  color: Color(0xFF212121),
  fontWeight: FontWeight.w600,
  letterSpacing: 0.18,
);

const kAlertButtonStyle = TextStyle(
  fontWeight: FontWeight.w600,
  letterSpacing: 0.2,
  fontSize: 16,
);

const kInfoTextStyle1 = TextStyle(
  fontWeight: FontWeight.w800,
  letterSpacing: 0.18,
  fontSize: 24,
  color: Color(0xFF022E64),
);

const kInfoTextStyle2 = TextStyle(
  fontWeight: FontWeight.w600,
  letterSpacing: 0.18,
  fontSize: 16,
  color: Color(0xFF022E64),
);

const scaffoldBackgroundColor = <Color>[
  Color(0xFF022E64),
  Color(0xFF004395),
  Color(0xFF00408F),
];

const kTextStyle400 = TextStyle(
  fontWeight: FontWeight.w400,
  color: Color(0xFF022E64),
);

const kTextStyle600 = TextStyle(
  fontWeight: FontWeight.w600,
  color: Color(0xFF022E64),
);

String getSalutation() {
  final hour = DateTime.now().hour;
  String salutation;

  if (hour < 12) {
    salutation = "Good Morning";
  } else if (hour < 17) {
    salutation = "Good Afternoon";
  } else {
    salutation = "Good Evening";
  }

  return salutation;
}

double getTextScaler(
  BuildContext context,
) {
  final screenHeight = MediaQuery.sizeOf(context).height;
  if (screenHeight > 812) {
    return 1.0;
  } else {
    return 0.8;
  }
}
