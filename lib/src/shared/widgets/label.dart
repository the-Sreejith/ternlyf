import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../theme/app_fonts.dart';


class Label extends StatelessWidget {
  const Label({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.radioCanadaBig,
          ),
        ),

        gapH4,

        Text(
          subTitle,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.black.withOpacity(0.7),
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.radioCanadaBig,
          ),
        ),
      ],
    );
  }
}
