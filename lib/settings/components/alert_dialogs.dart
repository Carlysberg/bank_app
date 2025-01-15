import "package:auto_route/auto_route.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/my_snackbar.dart";
import "package:bank/routes/app_router.gr.dart";
import "package:bank/settings/bloc/package_info_bloc.dart";
import "package:bank/settings/bloc/package_info_state.dart";
import "package:bank/settings/components/alert_button_1.dart";
import "package:bank/settings/components/alert_button_2.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

Future<void> signOutAlert(BuildContext context) {
  final screenWidth = MediaQuery.sizeOf(context).width;
  final screenHeight = MediaQuery.sizeOf(context).height;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: const Text(
          "Sign Out?",
          textAlign: TextAlign.center,
        ),
        titleTextStyle: kAlertTitleStyle,
        insetPadding: EdgeInsets.all(screenWidth / 20),
        content: SizedBox(
          width: screenWidth,
          child: const Text(
            "Are you sure you want to sign out of the app?",
            textAlign: TextAlign.center,
          ),
        ),
        contentTextStyle: kAlertQuestionStyle,
        actions: [
          Row(
            children: [
              Expanded(
                child: AlertButton1(
                  label: const Text(
                    "Confirm",
                    style: kAlertButtonStyle,
                  ),
                  onPressed: () {
                    context.router.pushAndPopUntil(
                      const SignInRoute(),
                      predicate: (_) => false,
                    );
                    buildShowMySnackBar(
                      context,
                      screenWidth,
                      screenHeight,
                      "Signed out successfully",
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: AlertButton2(
                  label: "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
        actionsPadding: EdgeInsets.only(
          left: screenWidth / 20,
          right: screenWidth / 20,
          bottom: screenWidth / 20,
          top: screenWidth / 40,
        ),
      );
    },
  );
}

Future<void> appVersionAlert(BuildContext context) {
  final screenWidth = MediaQuery.sizeOf(context).width;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: const Text(
          "App Version",
          textAlign: TextAlign.center,
        ),
        titleTextStyle: kAlertTitleStyle,
        insetPadding: EdgeInsets.all(MediaQuery.sizeOf(context).width / 20),
        content: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: BlocBuilder<PackageInfoBloc, PackageInfoState>(
            builder: (context, state) {
              if (state is PackageInfoInitial) {
                return const Text(
                  "version",
                  textAlign: TextAlign.center,
                );
              } else if (state is PackageInfoFetched) {
                return Text(
                  state.version,
                  textAlign: TextAlign.center,
                );
              } else {
                return const Text(
                  "N/A",
                  textAlign: TextAlign.center,
                );
              }
            },
          ),
        ),
        contentTextStyle: kAlertQuestionStyle,
        actions: [
          Row(
            children: [
              Expanded(
                child: AlertButton2(
                  label: "Okay",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
        actionsPadding: EdgeInsets.only(
          left: screenWidth / 20,
          right: screenWidth / 20,
          bottom: screenWidth / 20,
          top: screenWidth / 40,
        ),
      );
    },
  );
}
