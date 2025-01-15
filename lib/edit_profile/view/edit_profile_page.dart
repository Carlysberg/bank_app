import "dart:io";

import "package:auto_route/auto_route.dart";
import "package:bank/common/bottom_sheet.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/my_snackbar.dart";
import "package:bank/common/my_submit_button.dart";
import "package:bank/common/my_text_filled/bloc/password_visibility_bloc/password_visibility_bloc.dart";
import "package:bank/common/my_text_filled/components/generic_text_field.dart";
import "package:bank/data/bloc/data_cubit.dart";
import "package:bank/data/bloc/data_state.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_bloc.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_state.dart";
import "package:bank/sign_up/component/rounded_rhombus_clipper.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";

@RoutePage()
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF022E64),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "User Profile",
            style: kAppBarStyle,
          ),
        ),
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
        leadingWidth: 100,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: scaffoldBackgroundColor,
          ),
        ),
        child: BlocProvider(
          create: (context) => PasswordVisibilityBloc(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ClipPath(
                clipper: RoundedRhombusClipper(),
                child: Stack(
                  children: [
                    SizedBox(
                      height: screenHeight / 3.5,
                      width: screenWidth - screenWidth / 3,
                      child: BlocConsumer<ImageBloc, ImageState>(
                        builder: (context, state) {
                          if (state is ImageInitial) {
                            return ColoredBox(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/upload_placeholder.svg",
                                  ),
                                ],
                              ),
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
                        listener: (context, state) {
                          if (state is ImageCroppedState) {
                            buildShowMySnackBar(
                              context,
                              screenWidth,
                              screenHeight,
                              "Photo uploaded successfully",
                            );
                          }
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10, // Align to the bottom
                      left: 0,
                      right: 30, // Center horizontally
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            uploadPhotoBottomSheet(context, screenHeight);
                          },
                          child: SvgPicture.asset(
                            "assets/images/change_photo.svg",
                            width: screenWidth / 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              BlocBuilder<DataCubit, DataState>(
                builder: (context, state) {
                  if (state is DataLoaded) {
                    final fullName = state.customerName;
                    final name = fullName.split(" ");
                    return Column(
                      children: [
                        GenericTextField(
                          initialValue: name[0],
                          obscureText: false,
                        ),
                        const SizedBox(height: 10),
                        GenericTextField(
                          initialValue: name[1],
                          obscureText: false,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: MySubmitButton(
                      label: "Save",
                      onPressed: () {
                        context.popRoute(true);
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }
}
