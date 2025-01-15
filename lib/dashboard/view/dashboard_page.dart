import "dart:io";

import "package:auto_route/auto_route.dart";
import "package:bank/common/constant.dart";
import "package:bank/dashboard/component/bottom_navbar.dart";
import "package:bank/dashboard/component/rhombus_clipper.dart";
import "package:bank/data/bloc/data_cubit.dart";
import "package:bank/data/bloc/data_state.dart";
import "package:bank/home/view/home_page.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_bloc.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_state.dart";
import "package:bank/routes/app_router.gr.dart" as app_router;
import "package:bank/transaction/view/transaction_page.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";

@RoutePage()
class DashboardPage extends StatefulWidget {
  static String id = "dashboard";

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  PageController? pageController;
  ValueNotifier<int>? selectedIndexNotifier;

  @override
  void initState() {
    pageController = PageController();
    selectedIndexNotifier = ValueNotifier<int>(0);
    pageController!.addListener(pageListener);
    context.read<DataCubit>().loadData();
    super.initState();
  }

  @override
  void dispose() {
    pageController!.dispose();
    selectedIndexNotifier!.dispose();
    super.dispose();
  }

  void pageListener() {
    final pageIndex = pageController!.page!.toInt();
    selectedIndexNotifier!.value = pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<DataCubit, DataState>(
          builder: (context, state) {
            switch (state) {
              case DataLoaded():
                return GestureDetector(
                  onTap: () {
                    context.pushRoute(const app_router.SettingsRoute());
                  },
                  child: AppBar(
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Color(0xFF022E64),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    backgroundColor: const Color(0xFF022E64),
                    leading: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8,
                        bottom: 8,
                      ),
                      child: ClipPath(
                        clipper: RhombusClipper(),
                        child: BlocBuilder<ImageBloc, ImageState>(
                          builder: (context, state) {
                            if (state is ImageInitial) {
                              return Image.asset(
                                "assets/images/profile_img.png",
                              );
                            } else if (state is ImagePickedState) {
                              return Image.file(
                                File(state.imagePath),
                                fit: BoxFit.cover,
                              );
                            } else if (state is ImageCroppedState) {
                              return Image.file(
                                File(state.croppedImagePath!),
                                fit: BoxFit.cover,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        // Image.asset(
                        //   "assets/images/profile_img.png",
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getSalutation(),
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF).withOpacity(0.8),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${state.title == "Mr." ? "Mr." : "Mrs."} ${state.customerName}",
                          style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    centerTitle: false,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset("assets/images/bank_logo.png"),
                      ),
                    ],
                  ),
                );
              case DataInitial():
                return AppBar(
                  backgroundColor: const Color(0xFF022E64),
                );
              case DataLoading():
                return AppBar(
                  backgroundColor: const Color(0xFF022E64),
                  title: Text(
                    getSalutation(),
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                );
              case DataError():
                return const Text("Error loading data");
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: selectedIndexNotifier!,
        builder: (context, selectedIndex, child) {
          return MyBottomNavBar(
            leftBackgroundColor:
                selectedIndex == 0 ? kActiveBarColor : kInactiveBarColor,
            leftForegroundColor:
                selectedIndex == 0 ? kActiveIconColor : kInactiveIconColor,
            rightBackgroundColor:
                selectedIndex == 1 ? kActiveBarColor : kInactiveBarColor,
            rightForegroundColor:
                selectedIndex == 1 ? kActiveIconColor : kInactiveIconColor,
            leftOnPressed: () {
              pageController!.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
            rightOnPressed: () {
              pageController!.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
            activated: selectedIndex,
          );
        },
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(
            onTapSeeAll: () {
              pageController!.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
          const TransactionPage(),
        ],
      ),
    );
  }
}
