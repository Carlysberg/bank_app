import "package:auto_route/auto_route.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/my_submit_button.dart";
import "package:bank/common/my_text_filled/components/generic_text_field.dart";
import "package:bank/routes/app_router.gr.dart";
import "package:flutter/material.dart";

@RoutePage()
class SetNewEmailPage extends StatelessWidget {
  const SetNewEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF022E64),
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Color(0xFFFFFFFF),
                ),
                Text(
                  "Back",
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ],
            ),
          ),
        ),
        leadingWidth: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset("assets/images/bank_logo.png"),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: scaffoldBackgroundColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(
              flex: 2,
            ),
            const Text(
              "Set New Email",
              textAlign: TextAlign.center,
              style: kPageDescriptionStyle,
            ),
            const SizedBox(height: 10),
            const AutoSizeText(
              "Enter the new email for you account.\nDon’t forget it this time please",
              maxLines: 2,
              minFontSize: 14,
              maxFontSize: 18,
              stepGranularity: 2,
              textAlign: TextAlign.center,
              style: kQuestionTextStyle,
            ),
            const Spacer(flex: 3),
            const GenericTextField(
              hintText: "Enter new email",
              obscureText: false,
            ),
            const Spacer(),
            MySubmitButton(
              label: "Continue",
              onPressed: () {
                context.pushRoute(const VerifyEmailRoute());
              },
            ),
            const Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}
