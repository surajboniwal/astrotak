import 'package:astrotak/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({
    Key? key,
    required this.text,
    required this.buttonText,
    this.height,
    this.borderRadius,
    this.style,
  }) : super(key: key);

  final String text;
  final String buttonText;
  final double? height;
  final double? borderRadius;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 56.0,
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            text,
            style: style ??
                TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.black),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 12.0,
                color: AppColors.blue,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
