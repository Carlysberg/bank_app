import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:bank/common/animated_shapes.dart";
import "package:bank/common/constant.dart";
import "package:bank/routes/app_router.gr.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_svg/flutter_svg.dart";

@RoutePage()
class LoadingPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller =
        useAnimationController(duration: const Duration(seconds: 2));
    final screenHeight = MediaQuery.of(context).size.height;

    useEffect(
      () {
        Timer(const Duration(seconds: 4), () {
          context.replaceRoute(const DashboardRoute());
        });

        controller.repeat();
        return null;
      },
      [],
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "splash",
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/blue_rectangle.svg"),
                  AnimatedShapes(controller: controller),
                ],
              ),
            ),
            SizedBox(height: screenHeight / 20),
            const Text(
              "Please wait..",
              textAlign: TextAlign.center,
              style: kInfoTextStyle1,
            ),
            SizedBox(height: screenHeight / 40),
            const Text(
              "We are setting up your account",
              textAlign: TextAlign.center,
              style: kInfoTextStyle2,
            ),
          ],
        ),
      ),
    );
  }
}
