import "dart:io";

import "package:auto_route/auto_route.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/my_snackbar.dart";
import "package:bank/dashboard/component/slanted_edge_clipper.dart";
import "package:bank/data/bloc/data_cubit.dart";
import "package:bank/data/bloc/data_state.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_bloc.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_state.dart";
import "package:bank/routes/app_router.gr.dart";
import "package:bank/settings/bloc/package_info_bloc.dart";
import "package:bank/settings/bloc/package_info_event.dart";
import "package:bank/settings/components/alert_dialogs.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
            "Settings",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //----------------------------------
                //user details
                //----------------------------------
                Container(
                  height: screenHeight / 5,
                  color: Colors.yellow.shade50,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ClipPath(
                          clipper: SlantedEdgeClipper(),
                          child: Stack(
                            children: [
                              BlocBuilder<ImageBloc, ImageState>(
                                builder: (context, state) {
                                  switch (state) {
                                    case ImageInitial():
                                      return Image.asset(
                                        "assets/images/profile_img.png",
                                        fit: BoxFit.cover,
                                      );
                                    case ImagePickedState():
                                      return Image.file(
                                        File(state.imagePath),
                                        fit: BoxFit.cover,
                                      );
                                    case ImageCroppedState():
                                      return Image.file(
                                        File(state.croppedImagePath!),
                                        fit: BoxFit.cover,
                                      );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                              PositionedDirectional(
                                start: screenWidth / 40,
                                bottom: screenWidth / 40,
                                end: screenWidth / 7,
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .pushRoute(const EditProfileRoute())
                                        .then((value) {
                                      if (value == true) {
                                        buildShowMySnackBar(
                                          context,
                                          screenWidth,
                                          screenHeight,
                                          "Account information changed successfully",
                                        );
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/edit_photo.svg",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: BlocBuilder<DataCubit, DataState>(
                          builder: (context, state) {
                            switch (state) {
                              case DataInitial():
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              case DataLoading():
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              case DataLoaded():
                                return GridView.builder(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisExtent: screenHeight / 18,
                                    //childAspectRatio: 6,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    var title = "";
                                    var value = "";

                                    final fullName = state.customerName;
                                    final nameParts = fullName.split(" ");
                                    switch (index) {
                                      case 0:
                                        title = "FIRST NAME";
                                        value = nameParts[0].toUpperCase();
                                      case 1:
                                        title = "OTHER NAMES";
                                        value = nameParts[1].toUpperCase();
                                      case 2:
                                        title = "EMAIL";
                                        value = "johnjimoh@email.com";
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF022E64)
                                                .withOpacity(0.8),
                                          ),
                                        ),
                                        Flexible(
                                          child: FittedBox(
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF022E64)
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              case DataError():
                                return const Center(
                                  child: Text("Error loading data"),
                                );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 5,
                  color: const Color(0xFF022E64).withOpacity(0.6),
                ),
              ],
            ),

            //----------------------------------
            //account settings
            //----------------------------------
            ListTile(
              title: const Text("Account Settings"),
              tileColor: const Color(0xFFE1E6F0).withOpacity(0.32),
            ),
            //----------------------------------
            //change account email
            //----------------------------------
            ListTile(
              minLeadingWidth: 20,
              shape: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              onTap: () {
                context.pushRoute(const ChangeEmailRoute());
              },
              title: const Text(
                "Change Account Email",
                style: kTextStyle400,
              ),
              leading: SvgPicture.asset(
                "assets/images/sms.svg",
              ),
            ),
            //----------------------------------
            //change account password
            //----------------------------------
            ListTile(
              minLeadingWidth: 20,
              shape: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              onTap: () {
                context.pushRoute(const ChangePasswordRoute());
              },
              title: const Text(
                "Change Account Password",
                style: kTextStyle400,
              ),
              leading: SvgPicture.asset(
                "assets/images/lock_icon.svg",
              ),
            ),
            //----------------------------------
            //sign out
            //----------------------------------
            ListTile(
              minLeadingWidth: 20,
              shape: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              onTap: () async {
                await signOutAlert(context);
              },
              title: const Text(
                "Sign Out",
                style: kTextStyle400,
              ),
              leading: SvgPicture.asset(
                "assets/images/logout_icon.svg",
              ),
            ),
            //----------------------------------
            //about
            //----------------------------------
            ListTile(
              title: const Text("About"),
              tileColor: const Color(0xFFE1E6F0).withOpacity(0.32),
            ),
            //----------------------------------
            //Terms and Conditions
            //----------------------------------
            ListTile(
              shape: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              title: const Text(
                "Terms and Conditions",
                style: kTextStyle400,
              ),
            ),
            //----------------------------------
            //privacy policy
            //----------------------------------
            ListTile(
              shape: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              title: const Text(
                "Privacy Policy",
                style: kTextStyle400,
              ),
            ),
          ],
        ),
      ),
      //----------------------------------
      //app version
      //----------------------------------
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          context.read<PackageInfoBloc>().add(const FetchPackageInfoEvent());
          await appVersionAlert(context);
        },
        child: Container(
          height: 41,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0x99e1e6f0)),
            color: const Color(0xffffffff),
          ),
          child: const Center(
            child: Text(
              "App Version",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff022e64),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
