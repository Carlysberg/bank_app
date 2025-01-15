import "package:auto_route/auto_route.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/hyperlink_text_button.dart";
import "package:bank/common/my_snackbar.dart";
import "package:bank/common/my_submit_button.dart";
import "package:bank/common/my_text_filled/components/generic_text_field.dart";
import "package:bank/common/question_text.dart";
import "package:bank/forgot_password/bloc/count_down_bloc/count_down_bloc.dart";
import "package:bank/forgot_password/bloc/try_again_bloc/try_again_bloc.dart";
import "package:bank/routes/app_router.gr.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

@RoutePage()
class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
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
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CountdownBloc(),
            ),
            BlocProvider(
              create: (context) => TryAgainBloc(),
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(
                flex: 2,
              ),
              const Text(
                "Verify Email",
                textAlign: TextAlign.center,
                style: kPageDescriptionStyle,
              ),
              const SizedBox(height: 10),
              const AutoSizeText(
                "Enter the code we just sent to your new\nemail to verify your account",
                maxLines: 2,
                minFontSize: 14,
                maxFontSize: 18,
                stepGranularity: 2,
                textAlign: TextAlign.center,
                style: kQuestionTextStyle,
              ),
              const Spacer(flex: 3),
              const GenericTextField(
                hintText: "Enter the code",
                obscureText: false,
              ),
              const Spacer(),
              MySubmitButton(
                label: "Verify",
                onPressed: () {
                  context.router.popUntil(
                    (route) => route.settings.name == SettingsRoute.name,
                  );
                  buildShowMySnackBar(
                    context,
                    screenWidth,
                    screenHeight,
                    "Account email changed successfully",
                  );
                },
              ),
              const Spacer(),
              BlocBuilder<TryAgainBloc, bool>(
                builder: (context, showText) {
                  final tryAgainBloc = BlocProvider.of<TryAgainBloc>(context);
                  final countDownBloc = BlocProvider.of<CountdownBloc>(context);
                  return showText
                      ? BlocBuilder<CountdownBloc, int>(
                          builder: (BuildContext context, countdown) {
                            return Center(
                              child: Text(
                                "Resend code in ${countdown ~/ 60}:${(countdown % 60).toString().padLeft(2, '0')}",
                                style: kQuestionTextStyle,
                              ),
                            );
                          },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const QuestionText(text: "Didn’t get the code?"),
                            HyperlinkTextButton(
                              text: "Try again",
                              onPressed: () {
                                tryAgainBloc.showText();
                                countDownBloc.startCountdown();
                              },
                            ),
                          ],
                        );
                },
              ),
              const Spacer(
                flex: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
