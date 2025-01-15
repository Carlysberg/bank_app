import "package:bank/common/constant.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_bloc.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_event.dart";
import "package:bank/settings/components/alert_button_1.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:image_picker/image_picker.dart";

Future<dynamic> uploadPhotoBottomSheet(
  BuildContext context,
  double screenHeight,
) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(26.21),
        topRight: Radius.circular(26.21),
      ),
    ),
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // small rounded rectangle
            margin: const EdgeInsets.symmetric(vertical: 16),
            width: 39,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xffd9d9d9),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Select Upload Method",
                style: kTextStyle600,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: kTextStyle400,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight / 20),
          Row(
            children: [
              Expanded(
                child: AlertButton1(
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/camera.svg",
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Camera",
                        style: kAlertButtonStyle,
                      ),
                    ],
                  ),
                  onPressed: () {
                    BlocProvider.of<ImageBloc>(context)
                        .add(const PickImageEvent(ImageSource.camera));
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight / 40),
          Row(
            children: [
              Expanded(
                child: AlertButton1(
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/gallery.svg",
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Gallery",
                        style: kAlertButtonStyle,
                      ),
                    ],
                  ),
                  onPressed: () {
                    BlocProvider.of<ImageBloc>(context)
                        .add(const PickImageEvent(ImageSource.gallery));
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight / 40),
        ],
      ),
    ),
  );
}
