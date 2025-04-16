import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../constants/app_colors.dart';

import 'box_decoration.dart';
import 'box_shadow.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  final Color color;

  const CustomButton.primary({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = AppColors.primaryColor,
  });
  
  
  const CustomButton.danger({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = AppColors.danger,
  });

  const CustomButton.secondary({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: color,
          border: Border.all(color: AppColors.black, width: 1),
          boxShadow:  [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 0,
              color: Colors.black,
              inset: false,
            ),
          ],
        ),
        child: child
      ),
    );
  }
}
