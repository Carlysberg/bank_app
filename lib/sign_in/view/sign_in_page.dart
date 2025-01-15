import "package:auto_route/auto_route.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/hyperlink_text_button.dart";
import "package:bank/common/my_submit_button.dart";
import "package:bank/common/my_text_filled/bloc/my_form_bloc/my_form_bloc.dart";
import "package:bank/common/my_text_filled/bloc/my_form_bloc/my_form_event.dart";
import "package:bank/common/my_text_filled/bloc/my_form_bloc/my_form_state.dart";
import "package:bank/common/my_text_filled/components/email_input.dart";
import "package:bank/common/my_text_filled/components/password_input.dart";
import "package:bank/common/question_text.dart";
import "package:bank/routes/app_router.gr.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(const SignInEmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(const SignInPasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: scaffoldBackgroundColor,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: screenHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    SizedBox(
                      height: screenHeight / 20,
                      width: screenWidth / 3,
                      child: SvgPicture.asset("assets/images/logo.svg"),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    const Text(
                      "Sign In",
                      textAlign: TextAlign.center,
                      style: kPageDescriptionStyle,
                    ),
                    const SizedBox(height: 10),
                    const AutoSizeText(
                      "Welcome Back!\nSign in and let’s get going",
                      maxLines: 2,
                      minFontSize: 14,
                      maxFontSize: 18,
                      stepGranularity: 2,
                      textAlign: TextAlign.center,
                      style: kQuestionTextStyle,
                    ),
                    const Spacer(flex: 3),
                    EmailInput(focusNode: _emailFocusNode),
                    const SizedBox(height: 10),
                    PasswordInput(
                      focusNode: _passwordFocusNode,
                      errorText: "Password is incorrect. Please try again.",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: const Text(
                            "Forgot Password?",
                            style: kQuestionTextStyle,
                          ),
                          onTap: () {
                            context.pushRoute(const ForgotPasswordRoute());
                          },
                        ),
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<MyFormBloc, MyFormState>(
                      builder: (context, state) {
                        final isButtonDisabled =
                            !state.email.isValid || !state.password.isValid;
                        return MySubmitButton(
                          label: "Sign In",
                          onPressed: isButtonDisabled
                              ? null
                              : () {
                                  context.replaceRoute(const LoadingRoute());
                                },
                        );
                      },
                    ),
                    const Spacer(flex: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const QuestionText(
                          text: "Don't have an account yet?",
                        ),
                        HyperlinkTextButton(
                          text: "Sign Up",
                          onPressed: () {
                            context.replaceRoute(const SignUpRoute());
                          },
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
