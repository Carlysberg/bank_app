import "package:auto_route/auto_route.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/my_submit_button.dart";
import "package:bank/common/my_text_filled/bloc/password_visibility_bloc/password_visibility_bloc.dart";
import "package:bank/common/my_text_filled/components/generic_text_field.dart";
import "package:bank/routes/app_router.gr.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

@RoutePage()
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF022E64),
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.adaptive.arrow_back,
                  color: const Color(0xFFFFFFFF),
                ),
                const Text(
                  "Back",
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ],
            ),
          ),
        ),
        leadingWidth: screenWidth,
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
        child: Center(
          child: BlocProvider(
            create: (context) => PasswordVisibilityBloc(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Text(
                  "Email/Phone Number",
                  textAlign: TextAlign.center,
                  style: kPageDescriptionStyle,
                ),
                const SizedBox(height: 10),
                const AutoSizeText(
                  "Enter the email or phone for the account\nyou want to reset your password for",
                  maxLines: 2,
                  minFontSize: 14,
                  maxFontSize: 18,
                  stepGranularity: 2,
                  textAlign: TextAlign.center,
                  style: kQuestionTextStyle,
                ),
                const Spacer(
                  flex: 2,
                ),
                const GenericTextField(
                  initialValue: "johnjimoh2@email.com",
                  obscureText: false,
                ),
                const Spacer(),
                MySubmitButton(
                  label: "Continue",
                  onPressed: () {
                    context.pushRoute(const VerifyAccessRoute());
                  },
                ),
                const Spacer(),
                const Spacer(
                  flex: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}