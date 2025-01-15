import "package:auto_route/auto_route.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/hyperlink_text_button.dart";
import "package:bank/common/my_submit_button.dart";
import "package:bank/common/my_text_filled/bloc/my_form_bloc/my_form_bloc.dart";
import "package:bank/common/my_text_filled/bloc/my_form_bloc/my_form_event.dart";
import "package:bank/common/my_text_filled/bloc/my_form_bloc/my_form_state.dart";
import "package:bank/common/my_text_filled/components/confirm_password_input.dart";
import "package:bank/common/my_text_filled/components/email_input.dart";
import "package:bank/common/my_text_filled/components/password_input.dart";
import "package:bank/common/question_text.dart";
import "package:bank/routes/app_router.gr.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(const SignUpEmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(const SignUpPasswordUnfocused());
      }
    });
    _confirmPasswordFocusNode.addListener(() {
      if (!_confirmPasswordFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(const ConfirmPasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: kPageDescriptionStyle,
                    ),
                    const SizedBox(height: 10),
                    const AutoSizeText(
                      "New to the FBN Mobile App?\nSign up and let’s get started",
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
                      errorText:
                          "Password must be at least 8 characters and contain at least one letter and number",
                    ),
                    const SizedBox(height: 10),
                    ConfirmPasswordInput(
                      focusNode: _confirmPasswordFocusNode,
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    BlocBuilder<MyFormBloc, MyFormState>(
                      builder: (context, state) {
                        final isButtonDisabled =
                            !state.email.isValid || !state.password.isValid;
                        //final bool isPhoneNumber = state.emailOrPhone.value;
                        return MySubmitButton(
                          label: "Sign Up",
                          onPressed: isButtonDisabled
                              ? null
                              : () {
                                  context.pushRoute(
                                    const VerifyEmailDetailsRoute(),
                                  );
                                },
                        );
                      },
                    ),
                    const Spacer(flex: 9),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const QuestionText(
                          text: "Already have an account?",
                        ),
                        HyperlinkTextButton(
                          text: "Sign In",
                          onPressed: () {
                            context.replaceRoute(const SignInRoute());
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
