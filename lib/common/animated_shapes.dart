import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_svg/svg.dart";

class AnimatedShapes extends HookWidget {
  const AnimatedShapes({
    required this.controller,
    this.size,
    super.key,
  });
  final double? size;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final animations = List.generate(2, (index) {
      return useAnimation(
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(index / 2, (index + 0.5) / 2, curve: Curves.easeIn),
          ),
        ),
      );
    });

    final shapes = List<Widget>.generate(2, (index) {
      final opacity = animations[index];
      final changeColor = index == 0
          ? const ColorFilter.mode(Color(0xffE6B014), BlendMode.srcIn)
          : null;

      return Opacity(
        opacity: opacity,
        child: SvgPicture.asset(
          "assets/images/blue_rectangle.svg",
          colorFilter: changeColor,
          width: size,
        ),
      );
    });

    return Row(children: shapes);
  }
}
