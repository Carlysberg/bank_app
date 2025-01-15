import "dart:io";

import "package:auto_route/auto_route.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:bank/common/bottom_sheet.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/my_submit_button.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_bloc.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_state.dart";
import "package:bank/routes/app_router.gr.dart";
import "package:bank/sign_up/component/rounded_rhombus_clipper.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";

@RoutePage()
class PictureUploadPage extends StatelessWidget {
  const PictureUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
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
          child: Column(
            children: [
              const Spacer(),
              const Text(
                "One Last Thing",
                textAlign: TextAlign.center,
                style: kPageDescriptionStyle,
              ),
              const SizedBox(height: 10),
              const AutoSizeText(
                "This is the last thing, we promise.\nUpload a profile photo and we are done",
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
              GestureDetector(
                onTap: () {
                  uploadPhotoBottomSheet(context, screenHeight);
                },
                child: ClipPath(
                  clipper: RoundedRhombusClipper(),
                  child: Container(
                    height: screenHeight / 3.5,
                    width: screenWidth - screenWidth / 3,
                    color: Colors.white,
                    child: BlocBuilder<ImageBloc, ImageState>(
                      builder: (context, state) {
                        if (state is ImageInitial) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/upload_placeholder.svg",
                              ),
                            ],
                          );
                        } else if (state is ImagePickedState) {
                          return Image.file(
                            File(state.imagePath),
                            fit: BoxFit.fill,
                          );
                        } else if (state is ImageCroppedState) {
                          return Image.file(
                            File(state.croppedImagePath!),
                            fit: BoxFit.fill,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),

                    //
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: MySubmitButton(
                      label: "Sign Up",
                      onPressed: () {
                        context.router.pushAndPopUntil(
                          const LoadingRoute(),
                          predicate: (_) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
